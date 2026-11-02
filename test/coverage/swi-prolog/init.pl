%   Init file for the coverage run (test/coverage.pl). The run points
%   XDG_CONFIG_HOME at test/coverage, so every swipl it starts, the
%   bin/mutalog commands of the end-to-end tests and the workers they
%   start included, loads this file and records which clauses of
%   prolog/ it entered. A process that is killed records nothing.
%
%   The worker's dry run uses the same coverage primitives for its own
%   purpose. Its start and stop nest inside the recording started here,
%   but it also resets the data before each test, so the reset is
%   wrapped: it first takes what was recorded so far, and recording
%   goes on afterwards.

:- if(getenv('MUTALOG_COVERAGE_OUT', _)).

:- dynamic '$mutalog_cov_hit'/2.

'$mutalog_cov_snapshot' :-
    getenv('MUTALOG_COVERAGE_SRC', Src),
    forall(( system:'$cov_data'(clause(Ref), Enter, _),
             Enter > 0,
             catch(clause_property(Ref, file(File)), _, fail),
             sub_atom(File, 0, _, _, Src),
             clause_property(Ref, line_count(Line)),
             \+ '$mutalog_cov_hit'(File, Line)
           ),
           assertz('$mutalog_cov_hit'(File, Line))).

'$mutalog_cov_dump' :-
    '$mutalog_cov_snapshot',
    getenv('MUTALOG_COVERAGE_OUT', Dir),
    current_prolog_flag(pid, Pid),
    format(atom(Base), 'cov-~d.pl', [Pid]),
    directory_file_path(Dir, Base, File),
    setup_call_cleanup(
        open(File, write, Out),
        forall('$mutalog_cov_hit'(F, L),
               format(Out, "~q.~n", [hit(F, L)])),
        close(Out)).

:- redefine_system_predicate('$cov_reset').
'$cov_reset' :-
    '$mutalog_cov_snapshot',
    '$mutalog_cov_stop',
    system:'$cov_reset',
    '$mutalog_cov_start'.

:- if(current_predicate(system:'$cov_start'/1)).
'$mutalog_cov_start' :-
    system:'$cov_start'(Level),
    nb_setval('$mutalog_cov_level', Level).
'$mutalog_cov_stop' :-
    nb_getval('$mutalog_cov_level', Level),
    system:'$cov_stop'(Level).
:- else.
'$mutalog_cov_start' :-
    system:'$cov_start'.
'$mutalog_cov_stop' :-
    system:'$cov_stop'.
:- endif.

:- '$mutalog_cov_start'.
:- at_halt('$mutalog_cov_dump').

:- endif.
