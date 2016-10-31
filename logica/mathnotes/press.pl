/*  PRESS.PL  */


/*
This is a very simple demonstration of how Alan Bundy's PRESS
equation solver works. See "The Computer Modelling of Mathematical
Reasoning", by Alan Bundy.

Call 'test' to demonstrate it.

Note that the way it searches for sub-expressions to rewrite is not
effficient: I did it like that for simplicity.
*/


/*  solution( Equation+, SolvedEquation- ):
        Equation1 is the solved form of Equation, i.e.
        x = <some expression not ccontaining x's>.
*/
solution( Lhs=Rhs, SolvedEquation ) :-
    occurrences_of( x, Lhs, 1 ),
    occurrences_of( x, Rhs, 0 ),
    isolate( Lhs=Rhs, SolvedEquation ),
    !.

solution( Equation, SolvedEquation ) :-
    occurrences_of( x, Equation, N ),
    N > 1,
    collect( Equation, Equation1 ),
    solution( Equation1, SolvedEquation ),
    !.

solution( Equation, SolvedEquation ) :-
    occurrences_of( x, Equation, N ),
    N > 1,
    attract( Equation, Equation1 ),
    solution( Equation1, SolvedEquation ),
    !.


/*  attract( Equation+, Equation1- ):
        Equation1 is the result of attracting x's in Equation.
*/
attract( Equation, Equation1 ) :-
    sub_expression( E, Equation ),
    attract_rewrite( E, E1 ),
    replace_sub_expression( E, Equation, E1, Equation1 ).


/*  attract_rewrite( Expression+, Expression1- ):
        Expression1 is the result of rewriting Expression
        via a rule that attracts x's.
*/
attract_rewrite( log(U)+log(V), log(U*V) ) :-
    occurrences_of( x, U, NU ),
    NU > 0,
    occurrences_of( x, V, NV ),
    NV > 0.


/*  collect( Equation+, Equation1- ):
        Equation1 is the result of collecting x's in Equation.
*/
collect( Equation, Equation1 ) :-
    sub_expression( E, Equation ),
    collect_rewrite( E, E1 ),
    replace_sub_expression( E, Equation, E1, Equation1 ).


/*  collect_rewrite( Expression+, Expression1- ):
        Expression1 is the result of rewriting Expression
        via a rule that collects x's.
*/
collect_rewrite( (x+N)*(x-N), (x^2-N_squared) ) :-
    N_squared is N^2.


/*  isolate( Equation+, Equation1- ):
        Equation1 is the result of isolating the one x on
        Equation's left-hand side.
*/
isolate( x=Rhs, x=Rhs ) :- !.

isolate( Equation, SolvedEquation ) :-
    isolate_rewrite( Equation, Equation1 ),
    isolate( Equation1, SolvedEquation ).


/*  isolate_rewrite( Expression+, Expression1- ):
        Expression1 is the result of rewriting Expression
        via a rule that isolates x's.
*/
isolate_rewrite( sin(A)=B, A=arcsin(B) ).
isolate_rewrite( log(A)=B, A=exp(B) ).
isolate_rewrite( A-X=B, A=X+B ).
isolate_rewrite( A^N=B, A=B^(1/N) ).


/*  occurrences_of( Atom?, Expr+, N? ):
        There are N occurrences of Atom in Expr.
*/
occurrences_of( A, A, 1 ) :- !.

occurrences_of( A, B, 0 ) :-
    atomic( B ),
    B \= A,
    !.

occurrences_of( A, S, N ) :-
    not( atomic(S) ),
    S =.. [ _ | Args ],
    occurrences_of_1( A, Args, N ).


occurrences_of_1( A, [], 0 ) :- !.

occurrences_of_1( A, [H|T], N ) :-
    occurrences_of( A, H, Nh ),
    occurrences_of_1( A, T, Nt ),
    N is Nh + Nt.


/*  sub_expression( SubExpr?, Expr+ ):
        SubExpr is a sub-expression of Expr.
*/
sub_expression( A, A ).

sub_expression( A, Equation ) :-
    not( atomic(Equation) ),
    Equation =.. [ _ | Args ],
    sub_expression_1( A, Args ).


sub_expression_1( A, [H|T] ) :-
    sub_expression( A, H ).

sub_expression_1( A, [H|T] ) :-
    sub_expression_1( A, T ).


/*    replace_sub_expression( SubExpr+, Expr+, SubExpr1+, Expr1- ):                 
        Expr1 is the result of replacing all SubExprs by SubExpr1
        in Expr.
*/
replace_sub_expression( A, A, B, B ) :- !.

replace_sub_expression( A, Equation, B, Equation ) :-
    atomic( Equation ),
    !.

replace_sub_expression( A, Equation, B, Equation1 ) :-
    not( atomic(Equation) ),
    Equation =.. [ F | Args ],
    replace_sub_expression_1( A, Args, B, Args1 ),
    Equation1 =.. [ F | Args1 ].


replace_sub_expression_1( A, [], B, [] ) :- !.                 

replace_sub_expression_1( A, [H|T], B, [H1|T1] ) :-
    replace_sub_expression( A, H, B, H1 ),
    replace_sub_expression_1( A, T, B, T1 ).


/*  test:
        Test it on a simple equation.
*/
test :-
    solution( log(x+1) + log(x-1) = c, S ),
    write( S ), nl.
