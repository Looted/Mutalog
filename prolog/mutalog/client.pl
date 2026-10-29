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
%   within TimeoutS seconds, or `crashed` when its output closed or
%   was not a term. In both of the latter cases the worker has been
%   stopped.

worker_call(W, Command, TimeoutS, Reply) :-
    W = worker(_, In, _),
    catch(( write_term(In, Command, [quoted(true), fullstop(true), nl(true)]),
            flush_output(In)
          ), _, true),
    get_time(Now),
    Deadline is Now + TimeoutS,
    read_reply(W, Deadline, [], Reply0),
    (   Reply0 == timeout
    ->  worker_kill(W),
        Reply = timeout
    ;   Reply0 == crashed
    ->  worker_stop(W),
        Reply = crashed
    ;   Reply = Reply0
    ).

%   Replies are one term per line. The line is collected from whatever
%   input is pending, never with a blocking read, so that a worker that
%   writes part of a line and then hangs still meets the deadline.

read_reply(W, Deadline, Codes0, Reply) :-
    W = worker(_, _, Out),
    get_time(Now),
    Left is Deadline - Now,
    (   Left > 0,
        catch(wait_for_input([Out], Ready, Left), _, Ready = [Out]),
        Ready \== []
    ->  (   catch(( fill_buffer(Out),
                    \+ at_end_of_stream(Out),
                    read_pending_codes(Out, New, [])
                  ), _, fail)
        ->  append(Codes0, New, Codes),
            (   append(Line, [0'\n|_], Codes)
            ->  parse_reply(Line, Reply)
            ;   read_reply(W, Deadline, Codes, Reply)
            )
        ;   Reply = crashed
        )
    ;   Reply = timeout
    ).

parse_reply(Line, Reply) :-
    (   catch(term_string(Reply0, Line), _, fail),
        nonvar(Reply0)
    ->  Reply = Reply0
    ;   Reply = crashed
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
