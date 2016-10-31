/*  UNCERTAIN.PL  */


/*
This program demonstrates the use of Prolog for implementing logical
systems.

It implements ``uncertain inference'' over rules of the form
    Proposition Q/Certainty ::- PropositionP1, PropositionP2, ... .
This means
    The probability of Proposition Q is the total probability
    of the Propositions P, multiplied by Certainty Q.

Propositions are zero-arity predicates.

Base data is given as facts of the form
    Proposition.

If a proposition can be proved from more than one rule, its certainty is
the maximum of the certainties given by each rule.

The certainty of (P,Q) is the minimum of their certainties.

For an example, see the rules at the end of this file.


Warning: This logical system has absolutely no mathematical validity.
It's just a convenient demonstration of how to use Prolog to implement
inference rules very different from its own.
*/


:- op( 255, xfx, ::- ).
/*
This is the implication operator for the rules.
*/


:- reconsult( 'findall.pl' ).
/*
Implements 'findall', a predicate for getting all solutions to a goal.
*/


/*  solve( Goal+, Certainty- ):
        The main predicate. Returns in Certainty the certainty of
        proposition Goal.
*/
solve( (G1,G2), Certainty ) :-
    !,
    solve( G1, G1Certainty ),
    solve( G2, G2Certainty ),
    min( G1Certainty, G2Certainty, Certainty ).

solve( true, 1 ) :- !.

solve( Goal, 1 ) :-
    Goal.

solve( Goal, Certainty ) :-
    findall(
        Goal/Post ::- Tail,
        ((Goal/Post) ::- Tail ),
        Clauses
    ),
    solve_clauses( Clauses, Certainties ),
    max_list( Certainties, Certainty ).


/*  solve_clauses( ClauseList+, CertaintyList- ):
        Given a list of clauses defining a proposition, returns
        the certainty of each.
*/
solve_clauses( [], [0] ) :- !.

solve_clauses( [Clause|Clauses], [Certainty|Certainties] ) :-
    solve_clause( Clause, Certainty ),
    solve_clauses( Clauses, Certainties ).


/*  solve_clause( Clause+, Certainty- ):
        Given one clause defining a proposition, returns its certainty.
*/
solve_clause( (Head/HeadCertainty ::- Tail), Certainty ) :-
    solve( Tail, TailCertainty ),
    Certainty is TailCertainty * HeadCertainty.


/*  max( A+, B+, C- ):
        C is the maximum of A and B.
*/
max( A, B, C ) :- A >= B, !, C=A.
max( A, B, B ).


/*  min( A+, B+, C- ):
        C is the minimum of A and B.
*/
min( A, B, C ) :- A >= B, !, C=B.
min( A, B, A ).


/*  max_list( L+, M- ):
        M is the maximum element of L.
*/
max_list( [A], A ) :- !.
max_list( [A|T], M ) :-
    max_list( T, Mt ),
    max( A, Mt, M ).


/*  min_list( L+, M- ):
        M is the minimum element of L.
*/
min_list( [A], A ) :- !.
min_list( [A|T], M ) :-
    min_list( T, Mt ),
    min( A, Mt, M ).


/*
Test data.
----------

These are the some example clauses. Call 'test' to try it out.
*/


rain_tomorrow/0.5 ::- rain_today.
rain_tomorrow/0.2 ::- sun_today.

sun_tomorrow/0.8 ::- sun_today.
sun_tomorrow/0.1 ::- rain_today.

aunt_will_visit/0.9 ::- rain_tomorrow, aunt_has_umbrella.
aunt_will_visit/0.8 ::- sun_tomorrow.

aunt_has_umbrella/0.8 ::- aunt_went_shopping_today.


rain_today.

aunt_went_shopping_today.



test :-
    solve( aunt_will_visit, Certainty ),
    write( 'Certainty = ' ), write( Certainty ), nl.
