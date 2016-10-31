  /*---------------------------------------------------------*/
  /*                                                         */
  /*                       'SYMDIFF'                         */
  /*                                                         */
  /*  Symbolic Differentiation and Algebraic Simplification  */
  /*                                                         */
  /*    The declarative semantics of Prolog are a powerful   */
  /*  tool for problems involving symbolic manipulation.     */
  /*    In this example the rules for differentiation are    */
  /*  expressed as a set of clauses, where, provided that    */
  /*  the head matches the expression in question, the body  */
  /*  furnishes the appropriate result. This result in turn  */
  /*  is passed to the simplifying clauses which operate on  */
  /*  the same principle, but obviously correspond to a      */
  /*  different set of (simplifying) rules.                  */
  /*                                                         */
  /*---------------------------------------------------------*/


/*  This is the main predicate. */         

symdiff :-
   nl,
   write('SYMDIFF : Symbolic Differentiation and '),
   write('Algebraic Simplification. Version 1.0'), nl,
   symdiff1.


  /*  symdiff1 controls the main processing; It prompts  */
  /*  the user for data, differentiates the input,       */
  /*  simplifies the result and then displays it on      */
  /*  the terminal.                                      */

symdiff1  :-
   write('Enter a symbolic expression, or "stop" '),
   read(Exp),
   process( Exp ).


process( stop ) :- !.

process( Exp ) :-
   write('Differentiate w.r.t. :'),
   read(Wrt),
   d( Exp, Wrt, Diff ),
   simp( Diff, Sdiff ), nl,
   write('Differential w.r.t '), write(Wrt),
   write(' is '),
   write(Sdiff), nl, nl,
   symdiff1.



  /*  The following clauses constitute the differentiation   */
  /*  rules, some of which are recursive. Note too the use   */
  /*  of the cut which ensures that once a special case has  */
  /*  been identified, backtracking will not attempt to find */
  /*  an alternative solution.                               */

d( X, X, 1 ):- !.                  /* d(X) w.r.t. X is 1      */

d( C, X, 0 ):- atomic(C).          /* If C is a constant then */
                                   /* d(C)/dX is 0            */

d( U+V, X, A+B ):-                 /* d(U+V)/dX = A+B where   */
   d( U, X, A ),                   /* A = d(U)/dX and         */
   d( V, X, B ).                   /* B = d(V)/dX             */

d( U-V, X, A-B ):-                 /* d(U-V)/dX = A-B where   */
   d( U, X, A ),                   /* A = d(U)/dX and         */
   d( V, X, B ).                   /* B = d(V)/dX             */

d( C*U, X, C*A ):-               /* d(C*U)/dX = C*A where     */
   atomic(C),                    /* C is a number or variable */
   C \= X,                       /* not equal to X and        */
   d( U, X, A ), !.              /* A = d(U)/dX               */

d( U*V, X, B*U+A*V ):-           /* d(U*V)/dX = B*U+A*V where */
   d( U, X, A ),                 /* A = d(U)/dX and           */
   d( V, X, B ).                 /* B = d(V)/dX               */

d( U/V, X, (A*V-B*U)/(V*V) ):- /* d(U/V)/dX = (A*V-B*U)/(V*V) */
   d( U, X, A),                /* where A = d(U)/dX and       */
   d( V, X, B).                /*       B = d(V)/dX           */

d( U^C, X, C*A*U^(C-1) ):-       /* d(U^C)/dX = C*A*U^(C-1)   */
   atomic(C),                    /* where C is a number or    */
   C\=X,                         /* variable not equal to X   */
   d( U, X, A ).                 /* and d(U)/dX = A           */

d( U^C, X, C*A*U^(C-1) ):-       /* d(U^C)/dX = C*A*U^(C-1)   */
   C = -(C1), atomic(C1),        /* where C is a negated number or  */
   C1\=X,                        /* variable not equal to X   */
   d( U, X, A ).                 /* and d(U)/dX = A           */

d( sin(W), X, Z*cos(W) ):-       /* d(sin(W))/dX = Z*cos(W)   */
   d( W, X, Z).                  /* where Z = d(W)/dX         */

d( exp(W), X, Z*exp(W) ):-       /* d(exp(W))/dX = Z*exp(W)   */
   d( W, X, Z).                  /* where Z = d(W)/dX         */

d( log(W), X, Z/W ):-            /* d(log(W))/dX = Z/W        */
   d( W, X, Z).                  /* where Z = d(W)/dX         */

d( cos(W), X, -(Z*sin(W)) ):-    /* d(cos(W))/dX = Z*sin(W)   */
   d( W, X, Z).                  /* where Z = d(W)/dX         */



  /*  The following clauses are rules for the simplification  */
  /*  of the result of the differentiation process. For       */
  /*  example, multiples of zero are dropped, terms gathered  */
  /*  together where possible and factorisation is attempted. */
  /*  (It should be noted that in this program only adjacent  */
  /*  terms are candidates for simplification.)               */

simp( X, X ):-          /* an atom or number is simplified */
   atomic(X), !.

simp( X+0, Y ):-        /* terms of value zero are dropped  */
   simp( X, Y ).

simp( 0+X, Y ):-        /* terms of value zero are dropped  */
   simp( X, Y ).

simp( X-0, Y ):-        /* terms of value zero are dropped  */
   simp( X, Y ).

simp( 0-X, -(Y) ):-     /* terms of value zero are dropped  */
   simp( X, Y ).

simp( A+B, C ):-        /* sum numbers */
   numeric(A),
   numeric(B),
   C is A+B.

simp( A-A, 0 ).         /* evaluate differences */

simp( A-B, C ):-        /* evaluate differences */
   numeric(A),
   numeric(B),
   C is A-B.

simp( X*0, 0 ).         /* multiples of zero are zero */

simp( 0*X, 0 ).         /* multiples of zero are zero */

simp( 0/X, 0 ).         /* numerators evaluating to zero are zero */

simp( X*1, X ).         /* one is the identity for multiplication */

simp( 1*X, X ).         /* one is the identity for multiplication */

simp( X/1, X ).         /* divisors of one evaluate to the numerator */

simp( X/X, 1 ) :- !.

simp( X^1, X ) :- !.

simp( X^0, 1 ) :- !.

simp( X*X, X^2 ) :- !.

simp( X*X^A, Y ) :-
   simp( X^(A+1), Y ), !.

simp( X^A*X, Y ) :-
   simp( X^(A+1), Y ), !.

simp( A*B, X ) :-       /* do evaluation if both are numbers  */
   numeric( A ),
   numeric( B ),
   X is A*B.

simp( A*X+B*X, Z ):-    /* factorisation and recursive */
   A\=X, B\=X,          /* simplification              */
   simp( (A+B)*X, Z ).

simp( (A+B)*(A-B), X^2-Y^2 ):-   /* difference of two squares */
   simp( A, X ),
   simp( B, Y ).

simp( X^A/X^B, X^C ):-     /* quotient of numeric powers of X */
   numeric(A), numeric(B),
   C is A-B.

simp( A/B, X ) :-       /* do evaluation if both are numbers  */
   numeric( A ),
   numeric( B ),
   X is A/B.

simp( A^B, X ) :-       /* do evaluation if both are numbers  */
   numeric( A ),
   numeric( B ),
   X is A^B.

simp( W+X, Q ):-        /* catchall */
   simp( W, Y ),
   simp( X, Z ),
   ( W \== Y ; X \== Z ), /* ensure some simplification has taken place */
   simp( Y+Z, Q ).

simp( W-X, Q ):-        /* catchall */
   simp( W, Y ),
   simp( X, Z ),
   ( W \== Y ; X \== Z ), /* ensure some simplification has taken place */
   simp( Y-Z, Q ).

simp( W*X, Q ):-        /* catchall */
   simp( W, Y ),
   simp( X, Z ),
   ( W \== Y  ; X \== Z ), /* ensure some simplificaion has taken place */
   simp( Y*Z, Q ).

simp( A/B, C ) :-
   simp( A, X ),
   simp( B, Y ),
   ( A \== X ; B \== Y ),
   simp( X/Y, C ).

simp( X^A, C ) :-
   simp( A, B ),
   A \== B,
   simp( X^B, C).

simp( X, X ).           /* if all else fails... */              


numeric(A) :- integer(A).

numeric(A) :- real(A).
