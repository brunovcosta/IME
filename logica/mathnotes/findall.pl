/*  FINDALL.PL  */


/*
This is needed for the logic-with-certainties program in
UNCERTAIN.PL.
*/


/*
SPECIFICATION
-------------

If your system doesn't contain 'findall', you can use the version here.
It is for systems that don't implement 'recorded' and the other
recorded data base predicates. If you have them, you can make it
faster: see the implementation section.


PUBLIC findall( Template, Enumerator+, List? ):

Finds all the instances of Template for which Enumerator is provable,
collects them into a list in the order in which it found them (first
solution found gives the first element of the list) and unifies List
with the result. Normally Template is a variable or a compound term
whose arguments are variables, but it can be anything.
*/


/*
IMPLEMENTATION
--------------

This code is copied from page 360 of "The Craft of Prolog", which gives
a full explanation. Briefly, the points to watch are:

1) The predicate asserts the instances of Template for 'all found' to
collect, storing each as a clause for
        'find all'(...)
There is also a marker ([]) asserted; this is done by the initial
'asserta' and will appear in the final clause for 'find all'. To
distinguish this from the instances, the latter are each asserted as
        'find all'( {Template} )
Any functor would do here.

2) Use asserta rather than assert in case the Enumerator calls findall.

3) Asserting the instances in this order means 'all found' will collect
them in the order first-solved first-in-list.

4) Use uncommon names for the internal predicates to avoid name clashes
in Prologs without module systems.


If your Prolog has the recorded data-base you can make a faster version.
There are several possibilities: see "The Craft of Prolog" for code and
a discussion of timing.
*/


findall( Template, Enumerator, List ) :-
        asserta( 'find all'( [] ) ),
        call( Enumerator ),
        asserta( 'find all'( {Template} ) ),
        fail
    ;
        'all found'( [], List ).


'all found'( SoFar, List ) :-
    retract( 'find all'( Item ) ),
    !,
    /*  to stop retract looking for more Items.  */
    'all found'( Item, SoFar, List ).


'all found'( [], List, List ).

'all found'( {Template}, SoFar, List ) :-
    'all found'( [Template|SoFar], List ).
