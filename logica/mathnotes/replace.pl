/*  REPLACE.PL  */


/*
This program demonstrates how program transformation can be used when
writing Prolog.

It implements the following predicates

replace( T1+, S1+, S2+, T2- ):
T2 is the result of replacing the first occurrence of S1 in T1 by S2,
where the arguments are all lists.

segment( T+, Pre-, S+, Post- ):
T = Pre + S + Post, where the arguments are lists, and + denotes
concatenation.


'replace' calls 'segment to search for occurrences of S1.

I derived 'segment' by starting with a naive definition using 'append'
and then unrolling it, as suggested in Chapter 6 of "The Craft of
Prolog" by Richard O'Keefe. Here's the derivation:

(1) Start with
        segment( List, Pre, Seg, Post ) :-
            append( Pre_plus_Seg, Post, List ),
            append( Pre, Seg, Pre_plus_Seg ).

    This is obviously correct. The appends have to be in this order,
    otherwise the predicate won't terminate if Seg is not in List.


(2) Replace the first append by its first clause.
        segment( List, Pre, Seg, Post ) :-
            Pre_plus_Seg = [], Post = List,
            append( Pre, Seg, Pre_plus_Seg ).

    Simplify to
        segment( List, Pre, Seg, List ) :-
            append( Pre, Seg, [] ).

    And note that since the third argument of append is [], so must be
    Pre and Seg:
        segment( List, [], [], List ).

    This gives us the first clause for the new definition of segment.


(3) Now we have to go back to the end of (1) and replace the first
    append by its second clause:
        segment( List, Pre, Seg, Post ) :-
            Pre_plus_Seg = [H|T], Post=L, List=[H|T_],
            append( T, L, T_ ),
            append( Pre, Seg, Pre_plus_Seg ).

    which simplifies to
        segment( [H|T_], Pre, Seg, Post ) :-
            append( T, Post, T_ ),
            append( Pre, Seg, [H|T] ).


(4) Now deal with the second append. First replace by its first clause:
        segment( [H|T_], Pre, Seg, Post ) :-
            append( T, Post, T_ ),
            Pre = [], Seg=M, [H|T]=M.

    I.e.
        segment( [H|T_], [], [H|T], Post ) :-
            append( T, Post, T_ ).

    And back-substitute segment for append:
        segment( [H|T_], [], [H|T], Post ) :-
            segment( T_, [], T, Post ).


(5) Finally, return to the start of (4), and replace the second append
    by its second clause:
        segment( [H|T_], Pre, Seg, Post ) :-
            append( T, Post, T_ ),
            Pre = [I|U], Seg=M, [H|T]=[I|U_],
            append( U, M, U_ ).

    I.e.
        segment( [H|T_], [H|U], Seg, Post ) :-
            append( T, Post, T_ ),
            append( U, Seg, T ).

    Finally, note that the two appends are clearly saying that
        T_ = U + Seg + Post,
    i.e. that
        segment( T_, U, Seg, Post )

    So we can back-substitute and get
        segment( [H|T_], [H|U], Seg, Post ) :-
            segment( T_, U, Seg, Post ).


(6) So the definition is now (with cuts added):
        segment( List, [], [], List ) :- !.

        segment( [H|T_], [], [H|T], Post ) :-
            segment( T_, [], T, Post ), !.

        segment( [H|T_], [H|U], Seg, Post ) :-
            segment( T_, U, Seg, Post ).

Finally, putting cuts in, and switching the arguments to exploit
indexing on the first argument, I get the definition used below.                     

This is the same shape as O'Keefe's "segment" (which doesn't keep Pre
and Post), "The Craft of Prolog" 6.5.6. Procedurally, what it does is:

Clause 1: the substring you want is null. Assume it's at the front,
          set Pre to [] and Post to List.

Clause 2: the substring has the same head as List. Maybe List continues
          with the rest of the substring. Recurse in hope.

Clause 3: the substring didn't have the same head as List, or did, but
          wasn't found by clause 2. Move on one place and try again.


On my system, timings are, for the goal
    segment( "john loves X if Y likes wine", Pre, "Y", Post )
average times of
    Original two-append version         : 1.94 ms
    Version in (6)                      : 1.06 ms
    Version below (arguments switched)  : 0.83 ms.

To show where the extra variables came from, the clauses for append I
used were
    append( [], L, L ).
    append( [H|T], L, [H|T_] ) :-
        append( T, L, T_ ).
or the same but using variables I,M,U,U_ instead of H,L,T,T_.


Given this, 'replace' is simple. I haven't bothered to unroll the
appends. As O'Keefe points out, if you want to evaluate
    List = Pre + Seg + Post
it's more efficient to do
    List = Pre + ( Seg + Post )
then
    List = ( Pre + Seg ) + Post

On my system, the two goals
    append( "Y", " likes wine", L ),
    append( "john loves X if ", L, All )
and
    append( "john loves X if ", "Y", L ),
    append( L, " likes wine", All )
took an average of 0.764 ms and 1.336 ms respectively.

See Theme 49 in ``Essentials of Logic Programming'' by C.J.Hogger for a
theoretical justification of unfolding and back-substitution.

Would that we had tools to do this automatically: in a rational
programming environment, it would be necessary to do no more than quote
the original naive definition and run it through an unfolder. Doing it
manually is as ludicrous as compiling a program by hand and then
painstakingly saving and annotating the derived machine code because no
automatic compiler exists.
*/


replace( T1, S1, S2, T2 ) :-
    segment( T1, Pre, S1, Post ),
    append( S2, Post, S2_plus_Post ),
    append( Pre, S2_plus_Post, T2 ).


segment( T, Pre, S, Post ) :-
    segment_1( S, T, Pre, Post ).


segment_1( [], L, [], L ) :- !.

segment_1( [H|T_], [H|T], [], Post ) :-
    segment_1( T_, T, [], Post ),
    !.

segment_1( S, [H|T], [H|U], Post ) :-
    segment_1( S, T, U, Post ).


append( [], L, L ).

append( [H|T], L, [H|T1] ) :-
    append( T, L, T1 ).
