/*  RELATIONS.PL  */


/*
Some definitions of family relationships in Prolog.
First the relations, then the facts they operate on.
*/


is_half_sister_of(X, Y) :-
    is_a(X, female),
    is_parent_of(Z, X),
    is_parent_of(Z, Y),
    X \= Y.


is_full_sister_of(X, Y) :-
    is_a(X, female),
    have_same_parent(X, Y, female),
    have_same_parent(X, Y, male),
    X \= Y.


have_same_parent(X, Y, Sex) :-
    is_parent_of(Z, X),
    is_parent_of(Z, Y),
    is_a(Z, Sex).


is_parent_of(X, Y) :-
    is_mother_of(X, Y).

is_parent_of(X, Y) :-
    is_father_of(X, Y).


is_grandparent_of(X, Z) :-
    is_parent_of(X, Y),
    is_parent_of(Y, Z).


is_ancestor_of(X, Y) :-
    is_parent_of(X, Y).

is_ancestor_of(X, Z) :-
    is_parent_of(X, Y),
    is_ancestor_of(Y, Z).


is_a(abel,male).
is_a(adam,male).
is_a(bert,male).
is_a(bill,male).
is_a(cain,male).
is_a(charles,male).
is_a(chris,male).

is_a(amanda,female).
is_a(anjali,female).
is_a(anne,female).
is_a(belinda,female).
is_a(beth,female).
is_a(bridget,female).
is_a(caroline,female).
is_a(christine,female).
is_a(freda,female).
is_a(gertrude,female).

is_father_of(abel,bert).
is_father_of(abel,belinda).
is_father_of(abel,beth).

is_father_of(adam,bill).
is_father_of(adam,bridget).

is_father_of(bill,caroline).
is_father_of(bill,cain).

is_father_of(bert,charles).
is_father_of(bert,chris).

is_mother_of(amanda,bert).
is_mother_of(amanda,belinda).
is_mother_of(amanda,beth).

is_mother_of(anjali,bill).
is_mother_of(anjali,bridget).

is_mother_of(belinda,caroline).
is_mother_of(beth,cain).

is_mother_of(belinda,charles).
is_mother_of(belinda,chris).
