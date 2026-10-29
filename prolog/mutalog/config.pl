:- module(mutalog_config,
          [ load_config/3,          % +Root, +Overrides, -Config
            config_value/3,         % +Key, +Config, -Value
            default_operators/1     % -Names
          ]).

/** <module> Mutalog configuration

The configuration is a list of Key(Value) terms. It is built from three
layers, later layers winning: built-in defaults, the project's
`mutalog.config.pl` file, and command-line overrides.

The config file holds one term per key, for example:

```
mutate(["src/parser.pl", "src/eval.pl"]).
ignore(["src/generated.pl"]).
operators([arith, compare, cut]).
```
*/

:- use_module(library(lists)).
:- use_module(library(error)).
:- use_module(library(readutil)).

%!  default_operators(-Names) is det.
%
%   The operators enabled when the config does not name any.

default_operators([ arith, compare, unify, negate, cut, cut_insert,
                    goal_true, goal_fail, clause_drop, literal ]).

defaults([ root('.'),
           mutate(["src/**/*.pl", "prolog/**/*.pl"]),
           ignore([]),
           tests(["test/**/*.plt"]),
           load([]),
           operators(Ops),
           ignore_mutants([]),
           concurrency(0),
           timeout_ms(5000),
           timeout_factor(1.5),
           retries(1),
           worker_reuse(0),
           stack_limit('1g'),
           thresholds(high(80), low(60), break(0)),
           reporters([clear_text, progress, html, json]),
           report_dir("reports/mutation")
         ]) :-
    default_operators(Ops).

known_key(Key) :-
    defaults(Defaults),
    member(Term, Defaults),
    functor(Term, Key, _).

%!  load_config(+Root, +Overrides, -Config) is det.
%
%   Build the configuration for the project rooted at Root. When
%   Overrides contains config(File), that file is read instead of
%   Root/mutalog.config.pl. A missing default file is not an error.
%
%   Globs and `report_dir` are resolved against the project root: the
%   directory that holds the config file, or Root when there is none.
%   A `root(Dir)` term in the config file moves it, relative to the
%   file's directory; root(Dir) in Overrides moves it relative to Root.

load_config(Root, Overrides, Config) :-
    defaults(Defaults),
    (   memberchk(config(File0), Overrides)
    ->  absolute_file_name(File0, File, [relative_to(Root)]),
        (   exists_file(File)
        ->  true
        ;   existence_error(mutalog_config_file, File)
        )
    ;   directory_file_path(Root, 'mutalog.config.pl', File)
    ),
    (   exists_file(File)
    ->  read_config_file(File, FileTerms),
        file_directory_name(File, ConfigRoot)
    ;   FileTerms = [],
        ConfigRoot = Root
    ),
    (   memberchk(root(Dir0), FileTerms)
    ->  project_dir(ConfigRoot, Dir0, FileRoot)
    ;   FileRoot = ConfigRoot
    ),
    (   memberchk(root(Dir1), Overrides)
    ->  project_dir(Root, Dir1, ProjectRoot)
    ;   ProjectRoot = FileRoot
    ),
    exclude([T]>>( functor(T, config, 1) ; functor(T, root, 1) ),
            Overrides, Overrides1),
    merge_layers([Defaults, FileTerms, Overrides1, [root(ProjectRoot)]], Config).

project_dir(Base, Dir0, Dir) :-
    absolute_file_name(Dir0, Dir,
                       [ relative_to(Base),
                         file_type(directory),
                         access(exist)
                       ]).

read_config_file(File, Terms) :-
    setup_call_cleanup(
        open(File, read, In, [encoding(utf8)]),
        read_terms(In, Terms0),
        close(In)),
    maplist(check_config_term(File), Terms0),
    Terms = Terms0.

read_terms(In, Terms) :-
    read_term(In, Term, []),
    (   Term == end_of_file
    ->  Terms = []
    ;   Terms = [Term|Rest],
        read_terms(In, Rest)
    ).

check_config_term(File, Term) :-
    (   compound(Term),
        functor(Term, Key, _),
        known_key(Key)
    ->  true
    ;   domain_error(mutalog_config_term(File), Term)
    ).

merge_layers(Layers, Config) :-
    foldl(merge_layer, Layers, [], Config).

merge_layer(Layer, Acc, Merged) :-
    foldl(set_term, Layer, Acc, Merged).

set_term(Term, Acc, [Term|Rest]) :-
    functor(Term, Key, _),
    exclude([T]>>functor(T, Key, _), Acc, Rest).

%!  config_value(+Key, +Config, -Value) is det.
%
%   Value of a single-argument key. Fails silently for unknown keys
%   so callers can supply their own fallback.

config_value(Key, Config, Value) :-
    Term =.. [Key, Value],
    memberchk(Term, Config).
