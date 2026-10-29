:- module(mutalog_client,
          [ worker_start/3,          % +Root, +Options, -Worker
            worker_call/4,           % +Worker, +Command, +TimeoutS, -Reply
            worker_stop/1            % +Worker
          ]).

/** <module> Controller side of a worker

Starts a worker (see mutalog_worker) as a child `swipl` with pipes for
its standard input and output, sends it one command at a time and waits
for the reply with a hard time limit. A worker that does not answer in
time or dies is killed; the caller decides whether to start a new one.

A worker handle is `worker(Pid, In, Out)`.
*/

:- use_module(library(process)).
:- use_module(library(lists)).
:- use_module(library(option)).

:- prolog_load_context(directory, Dir),
   directory_file_path(Dir, 'worker.pl', WorkerFile),
   asserta(worker_file(WorkerFile)).

%!  worker_start(+Root, +Options, -Worker) is det.
%
%   Options: stack_limit(Limit), verbose(Bool). With verbose(true) the
%   worker's standard error, where the project's own output goes, is
%   passed through; otherwise it is discarded.

worker_start(Root, Options, worker(Pid, In, Out)) :-
    worker_file(WorkerFile),
    current_prolog_flag(executable, Exe),
    option(stack_limit(Limit), Options, '1g'),
    format(atom(StackOpt), '--stack-limit=~w', [Limit]),
    (   option(verbose(true), Options)
    ->  Err = std
    ;   Err = null
    ),
    process_create(Exe,
                   [ StackOpt, '-q',
                     '-g', 'mutalog_worker:worker_main',
                     '-t', 'halt',
                     WorkerFile
                   ],
                   [ stdin(pipe(In)),
                     stdout(pipe(Out)),
                     stderr(Err),
                     cwd(Root),
                     process(Pid)
                   ]),
    set_stream(In, encoding(utf8)),
    set_stream(Out, encoding(utf8)).

%!  worker_call(+Worker, +Command, +TimeoutS, -Reply) is det.
%
%   Reply is the worker's answer, `timeout` when it did not answer
%   within TimeoutS seconds, or `crashed` when its output closed. In
%   both of the latter cases the worker has been stopped.

worker_call(W, Command, TimeoutS, Reply) :-
    W = worker(_, In, Out),
    catch(( write_term(In, Command, [quoted(true), fullstop(true), nl(true)]),
            flush_output(In)
          ), _, true),
    (   wait_for_input([Out], Ready, TimeoutS),
        Ready \== []
    ->  catch(read_term(Out, Reply0, []), _, Reply0 = end_of_file),
        (   Reply0 == end_of_file
        ->  worker_stop(W),
            Reply = crashed
        ;   Reply = Reply0
        )
    ;   worker_kill(W),
        Reply = timeout
    ).

%!  worker_stop(+Worker) is det.

worker_stop(W) :-
    W = worker(Pid, In, Out),
    catch(( write_term(In, halt, [fullstop(true), nl(true)]),
            flush_output(In)
          ), _, true),
    catch(close(In, [force(true)]), _, true),
    (   catch(process_wait(Pid, _, [timeout(2)]), _, fail)
    ->  true
    ;   catch(process_kill(Pid, kill), _, true),
        catch(process_wait(Pid, _), _, true)
    ),
    catch(close(Out, [force(true)]), _, true).

worker_kill(worker(Pid, In, Out)) :-
    catch(process_kill(Pid, kill), _, true),
    catch(process_wait(Pid, _), _, true),
    catch(close(In, [force(true)]), _, true),
    catch(close(Out, [force(true)]), _, true).
