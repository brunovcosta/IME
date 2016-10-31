/*  BITSTREAM.PL  */


/*
This program demonstrates how to use Prolog to simulate digital
circuits. In effect, this is a demonstration of how to implement another
logical system in Prolog.


Circuit layout is specified by naming the wires between components. In
the example below, these names are a, b, c, d, x, y.


The dynamic behaviour of a circuit is given by specifying the voltage
levels on the wires, as a series of clauses for 'spec':

    spec( W, Expression ):
        The voltage on wire W has the value given by Expression.


The syntax of expressions:
    Expression ::= Expression + Expression
    Expression ::= Expression - Expression
    Expression ::= Primitive

    Primitive ::= Number
    Primitive ::= Wire
    Primitive ::= Wire lag Time


A primitive which is a wire name denotes the voltage on that wire in
the current clock cycle. A primitive of the form (wire lag time) denotes
the voltage on that wire 'time' cycles ago. 'time' must be a number.


You can have conditional clauses of the form
    spec( W, Expression ) if Condition
When looking for a value for W, the system will evaluate Condition, and
only use the clause for spec if it is true. Make sure you have enough
conditions to cover all cases. The Condition is two Expressions compared
by one of =, \=, >, <, >=, =<.             



To specify initial values, use 'init':
    init( W, Time, Number )
means that wire W has voltage Number at time T.


To use the simulator, call
    eval_wire( W+, Time+, V- )
which will give the value on W at Time, or
    run( W+ )
which will display a sequence of values for W.


Note: it does not check for inconsistencies.
*/


/*
Define 'lag' and 'if' for the specification clauses.
*/
:- op( 10, xfx, lag ).
:- op( 255, xfx, if ).


/*  signal( W+, Time+, V- ):
        Succeeds if there is a spec clause for W at time T, in which
        case value is V. Otherwise fails.
*/
signal( Wire, _, V ) :-
    clause( spec( Wire, V ), true ),
    !.

signal( Wire, N, V ) :-
    clause( (spec( Wire, V ) if Cond), true ),
    eval_cond( Cond, N ),
    !.


/*  eval_cond( Cond+, Time+ ):
        Succeeds if Cond is true at Time, otherwise fails.
*/
eval_cond( A>B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA > VB.

eval_cond( A>=B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA >= VB.

eval_cond( A<B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA < VB.

eval_cond( A=<B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA =< VB.

eval_cond( A=B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA = VB.

eval_cond( A\=B, N ) :-
    !,
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    VA \= VB.


/*  eval_wire( W+, Time+, V- ):
        V is value of W at Time.
        Uses memo-clauses to avoid recomputing values.                  
*/
eval_wire( Wire, N, V ) :-
    clause( init( Wire, N, V ), true ),
    !.

eval_wire( Wire, N, V ) :-
    clause( memo( Wire, N, V ), true ),
    !.

eval_wire( Wire, N, V ) :-
    signal( Wire, N, Expr ),
    eval_expr( Expr, N, V ),
    asserta( memo(Wire,N,V) ).


/*  eval_expr( Expression+, Time+, V- ):
        V is value of Expression at Time.
*/
eval_expr( A, N, V ) :-
    atom( A ),
    !,
    eval_wire( A, N, V ).

eval_expr( IR, N, IR ) :-
    atomic( IR ),
    !.

eval_expr( A lag L, N, V ) :-
    !,
    NL is N - L,
    eval_expr( A, NL, V ).

eval_expr( A+B, N, V ) :-
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    V is VA + VB.

eval_expr( A-B, N, V ) :-
    eval_expr( A, N, VA ),
    eval_expr( B, N, VB ),
    V is VA - VB.


/*  go( W+ ):
        Display successive values on wire W.
*/
go( Wire ) :-
    retractall( memo(_,_,_) ),
    run( Wire, 1 ).


/*  run( W+, Time+ ):
        Display values on wire W from Time onwards.             
*/
run( Wire, N ) :-
    eval_wire( Wire, N, V ),
    write( Wire ), write( ' at ' ), write( N ), write( ' = ' ), write( V ), nl,
    Next is N + 1,
    run( Wire, Next ).


/*
Test data.
----------

Describes the bitstream circuit in Sony's Principles of Audio and
Compact Discs, 2nd edition, 1992.
*/


spec( x, 0.6 ).

spec( a, x-d ).

spec( b, a+(b lag 1) ).

spec( c, 1 ) if b > 0.
spec( c, 0 ) if b =< 0.

spec( y, c lag 1 ).

spec( d, 1 ) if y = 1.
spec( d, -1 ) if y = 0.


init( d, 1, 0 ).

init( b, 0, 0 ).


test :-
    go( c ).              
