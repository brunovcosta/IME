/*  B2.PL  */
:- prolog_memlim(20000000).
:- prolog_area_lim(50000).
:- library(log).
:- quietspy(on).
sp :- (spy), (nospy prolog_expand_term),
    (nospy prolog_user_goal),
    (nospy prolog_expand_goal).
 
/*  LIST PREDICATES.  */
 
/*  member(Element, List):
        Usual (backtracking) member.
*/
member(X, [X|_]).
member(X, [_|Y]) :-
      member(X, Y).
 
/* append(Left, Right, Leftright) */
 
append([], L, L):- !.
append(L, [], L):- !.
append( [H|T], In2, Out ) :- !,
        append( T, [H|In2], Out ).
 
/*  flatten( In, Out) iff Out is the flattened version of In: i.e.
    [ [a], [b,c], [[d],e] ] => [a,b,c,d,e] .
    In must be instantiated.
*/
flatten( In, Out ) :-
       flatten( In, [], Out ).
 
flatten( [], L, L ) :- !.
 
flatten( A, L, [A|L] ) :-
    (
        var( A )
    ;
        atomic( A )
    ;
        ( A \= [_|_] )
    ), !.
 
flatten( [H|T], Sofar, Result ) :-
    flatten( H, Sofar, Sofar1 ),
    flatten( T, Sofar1, Result ).
/*
        `subset_of( X, Y )' is true when X is a subset of Y.
*/
subset_of( [], _ ):- !.
 
subset_of( [H|T], [H_|T_] ) :-
         H = H_,
         subset_of( T, T_ ).
 
subset_of( [H|T], [H_|T_] ) :-
         po(H, H_),
         subset_of( [H|T], T_ ).
/*
        Reverse the order of elements in a list.
*/
reverse( X, Y ) :-
       reverse( X, [], Y ), !.
 
reverse( [XH|XT], Acc, Y ) :-
    !,
    reverse( XT, [XH|Acc], Y ).
 
reverse( [], Y, Y ).
 
/*  Sorting elements in a list. */
/*  sort_all(In_list, Out_list):
        iff Out_list is a sorting of In_list, saving duplicates. The
        Xing allows the use of keysort, which doesn't delete duplicates.
*/
sort_all(In, Out) :-
    sort_all_xit(In, Xed_list),
    keysort(Xed_list, Sorted_xed_list),
    de_xit( Sorted_xed_list, Outlist ),
    reverse( Outlist, Out ).
 
/*  sort_all_xit(List, Xed_list)
        iff each element of list is matched by an xed element in
        Xed_list.
*/
sort_all_xit(In, Xed_list):-
    sort_all_xit(In, [], Xed_list).
 
 
sort_all_xit([], Acc, Acc ) :-
    !.
 
sort_all_xit([Elem | In_rest], Acc, Out ) :-
    sort_all_xit(In_rest, [Elem-x|Acc], Out ).
 
 
de_xit( List, Outlist ):-
    de_xit( List, [], Outlist).
 
 
de_xit( [], Acc, Acc ):-
    !.
 
de_xit( [Elem-x|Rest], Acc, Outlist):-
    de_xit( Rest, [Elem|Acc], Outlist).
 
 
quicksort( Xs, Pred, Ys ) :-
    quicksort_dl( Xs, Pred, Ys/[] ).
 
quicksort_dl( [X|Xs], Pred, Ys/Zs ) :-
    !,
    partition_list( Xs, Pred, X, Littles, Bigs ),
    quicksort_dl( Littles, Pred, Ys/[X|Ys1] ),
    quicksort_dl( Bigs, Pred, Ys1/Zs ).
 
quicksort_dl( [], Pred, Xs/Xs ).
 
partition_list( [X|Xs], Pred, Y, Ls, [X|Bs] ) :-
    Goal =.. [ Pred, X, Y ],
    call( Goal ),
    !,
    partition_list( Xs, Pred, Y, Ls, Bs ).
 
partition_list( [X|Xs], Pred, Y, [X|Ls], Bs ) :-
    !,
    partition_list( Xs, Pred, Y, Ls, Bs ).
 
partition_list( [], Pred, Y, [], [] ).
 
general_sort( X, Pred, Y ) :-
    quicksort( X, Pred, Y ).
 
/*  All partitions of an integer.  */
partitions( N, L ) :-
    known_partitions( N, L ),
    !.
 
partitions( N, L ) :-
    NMinus1 is N - 1,
    partitions1( N, NMinus1, L_ ),
    sort( L_, L ),
    asserta( known_partitions(N,L) ).
 
partitions1( N, 0, [ [N] ] ) :- !.
 
partitions1( N, I, L ) :-
    partitions( I, P ),
    Diff is N - I,
    insertx( P, Diff, P_ ),
    sort( P_, P__ ),
    IMinus1 is I - 1,
    partitions1( N, IMinus1, L_ ),
    append( P__, L_, L ).
 
insertx( [], X, [] ) :- !.
 
insertx( [L|T], X, [XL|T_] ) :-
    sort_all( [X|L], XL ),
    insertx( T, X, T_ ).
 
partitions_of_length( N, 2, Ps ) :-
    N2 is N mod 2, N2 = 0,
    !,
    N1 is N div 2,
    Ps = [[N1, N1]].
 
partitions_of_length( N, 3, Ps ) :-
    N >= 3,
    !,
    N1 is N mod 3,
    N2 is N div 3,
    (
       N1 = 0
    -> Ps = [[N2, N2, N2]]
    ;  N3 is 2*N2,
       N4 is N-N3,
       Ps = [[N2, N2, N4]]
    ),
    write( partitions_of_length( N, 3, Ps ) ).
 
 
partitions_of_length( N, Length, Partitions ) :-
    partitions( N, Ps ),
    fast_setof( Partition,
                (
                 member( Partition, Ps ),
                 length( Partition, Length )
                ),
                Partitions
              ).
 
/*    VECTOR PREDICATES    */
/*
        To give a partial order for vectors
*/
posort( Vecs, SortedVecs ) :-
    map_ranks( Vecs, Ranked ),
    keysort( Ranked, Sorted ),
    dekey( Sorted, SortedVecs ).
 
posort_lists( [], [] ):- !.
 
posort_lists( [H|T], [H_|T_] ) :-
    posort( H, H_ ),
    posort_lists( T, T_ ).
 
map_ranks( [], [] ):- !.
map_ranks( [Vec|T], [Rank/Vec|TM] ) :-
    rank( Vec, Rank ),
    map_ranks( T, TM ).
 
dekey( [], [] ):- !.
dekey( [_/V|T], [V|TD] ) :-
     dekey( T, TD ).
 
multi_dekey( [], [] ):- !.
multi_dekey( [H|T], [DH|DT] ) :-
    dekey( H, DH ),
    multi_dekey( T, DT ).
 
po( w(X,Y), w(U,V) ) :-
    vsum( w(X,Y), w(-U,-V), w(R,R_) ),
    vm( R, w(2,1), w(P,P_) ),
    vm( R_, w(3,2), w(Q,Q_) ),
    vsum( w(P,P_) , w(Q,Q_ ), w( S,S_ ) ),
    S > 0, S_ > 0.
 
/* If alpha and beta are the fundamental roots and a weight is
    A(alpha) + B(beta), then we define the rank to be A+B.
*/
rank( w(X,Y), Rank ) :-
    vm( X, w(2,1), w(P,P_) ),
    vm( Y, w(3,2), w(Q,Q_) ),
    vsum( w(P,P_) , w(Q,Q_ ), w( S,S_ ) ),
    Rank is S + S_.
 
/*  Two definitions of the invalidity of a weight vector : the
    second, `inv' includes the positive roots.
*/
invalid( w(X,Y) ) :-
    X < 0 ; Y < 0 .
 
inv( w(X,Y) ) :-
    X < -3 ; Y < -1 .
 
/*   Here we change from a weight basis to a root basis.
*/
change_basis(Pt, N, P, K) :-
    linked(Pt, N, P, R),
    conv( R, K ).
 
conv( [], [] ) :- !.
conv( [H|T], [X|Y] ) :-
    recast( H, X ),
    conv( T, Y ).
 
recast( w(X,Y), w(U,V) ) :-
    vm( X, w(2,1), w(R,R_) ),
    vm( Y, w(3,2), w(Q,Q_) ),
    vsum( w(R,R_), w(Q,Q_), w(U,V) ).
 
/*  Addition and scalar multiplication of vectors defined.
    All vectors will be 2-dimensional and integer-valued.   */
vsum( w(X,Y), w(X_,Y_), w(X__,Y__) ) :-
    X__ is X+X_,
    Y__ is Y+Y_.
 
vm(C, w(X,Y), w(M,N)) :-
   M is C*X, N is C*Y.
 
/*   ARITHMETIC    */
 
/*  power( N+, X+, Y- )
        Calculate X to the power N.
        Note that the arguments are a silly way round, but that this will
        deter us from making groundless assumptions.
*/
power( 0, X, 1 ):-
    !.
power( N, 0, 0 ) :-
    !.
power( N, X, Y ) :-
    !,
    N_ is N-1,
    power( N_, X, Z ),
   Y is Z*X.
 
/*  p_adic_valn( X+, P+, Y- )
        Calculate the p-adic valuation of an integer X i.e. the highest
        power of p dividing X.
*/
p_adic_valn( X, P, 0 ) :-
    X < P,
    !.
p_adic_valn( X, P, Y ) :-
    X >= P,
    (
        X_ is X/P,
        integer( X_ )
    ->
        p_adic_valn( X_, P, Y_ ),
        Y is Y_+1
    ;
        Y = 0
    ).
 
/* OUTPUT */
:- op( 30, xf, ~ ).
:- op( 40, xfy, ~<> ).
:- op( 40, xfy, <> ).
:- op( 40, xfy, ... ).
 
output( V ) :-
    var( V ), !, write('Prolog variable '), write(V).
 
output( A<>B ) :-
    !,
    output(A), output(B).
 
output( A...B ) :-
    !,
    output(A), output(' '), output(B).
 
output( A~ ) :-
    !,
    output( A ), nl.
 
output( A~<>B ) :-
    !,
    output( A ), nl, output( B ).
 
output( seplist([],Sep) ) :- !.
 
output( seplist([H],Sep) ) :-
    output( H ), !.
 
output( seplist([H|T],Sep) ) :-
    output( H ),
    output( Sep ),
    (
        T = [X]
    ->
        output( X )
    ;
        output( seplist(T,Sep) )
    ), !.
 
output( X ) :-
    write( X ).
 
to_file( File, Goal ) :-
    telling( COS ),
    tell( File ),
    call( Goal ),
    told,
    tell( COS ).
 
term_to_file( File, Term ) :-
    to_file( File, ( writeq(Term),writeq('.'),nl ) ).
 
term_from_file( File, Term ) :-
    seeing( CIS ),
    see( File ), seen,
    see( File ),
    read( Term ),
    seen,
    see( CIS ).
 
rowlist_to_file( [] ) :- !.
rowlist_to_file( [ Row | Rest ] ) :-
    row_to_file( Row ),
    rowlist_to_file( Rest ).
 
row_to_file( Vector+Row ) :-
    write_vec( Vector ), write(' '),
    array_to_list( Row, Cols ),
    rest_row_to_file(Cols ),
    nl.
 
rest_row_to_file( [] ) :- !.
rest_row_to_file( [ Vecs | RestCols ] ) :-
    output( '/ ' ),
    col_to_file( Vecs ),
    rest_row_to_file( RestCols ).
 
col_to_file( [] ) :- !.
col_to_file( [ Vec | T ] ) :-
    write_vec( Vec ), write(', '),
    col_to_file( T ).
 
write_vec( w(X,Y) ) :-
    alc_no( w(X, Y), N ), !,
    write( N ).
write_vec( V ) :-
    write( V ).
 
 
/*  The inner product for B2 ; < X , Y >  =  2( X , Y )/( Y ,Y ).
    The second argument is one of the four positive roots.  */
 
innp(w(0,0),X,0) :- !.
innp(w(X,0),w(2,-1),X) :- !.
innp(w(X,0),w(-2,2),0) :- !.
innp(w(X,0),w(0,1),X) :- !.
innp(w(X,0),w(2,0),X) :- !.
innp(w(0,X),w(2,-1),0) :- !.
innp(w(0,X),w(-2,2),X) :- !.
innp(w(0,X),w(0,1),Y) :- !, Y is 2*X.
innp(w(0,X),w(2,0),X) :- !.
innp(w(U,V),Z,R) :-
    innp(w(U,0),Z,S),
    innp(w(0,V),Z,T),
    R is S + T.
 
/*  Define reflection with respect to each of the 4 positive roots in turn */
 
sa(w(X,Y), M, P, R ) :-
    innp( w(X,Y), w(2,-1), S ),
    S_ is -1*S,
    vm( S_, w(2,-1), w(A,A_) ),
    vsum( w(X,Y), w(A,A_), w(X_,Y_) ),
    MP is M*P,
    vm( MP, w(2,-1), w(K,K_) ),
    vsum( w(K,K_), w(X_,Y_), R ).
 
sb(w(X,Y), M, P, R) :-
    innp( w(X,Y), w(-2,2), S ),
    S_ is -1*S,
    vm( S_, w(-2,2), w(A,A_) ),
    vsum( w(X,Y), w(A,A_), w(X_,Y_) ),
    MP is M*P,
    vm( MP, w(-2,2), w(K,K_) ),
    vsum( w(K,K_), w(X_,Y_), R ).
 
sc(w(X,Y), M, P, R ) :-
    innp( w(X,Y), w(0,1), S ),
    S_ is -1*S,
    vm( S_, w(0,1), w(A,A_) ),
    vsum( w(X,Y), w(A,A_), w(X_,Y_) ),
    MP is M*P,
    vm( MP, w(0,1), w(K,K_) ),
    vsum( w(K,K_), w(X_,Y_), R ).
 
sd(w(X,Y), M, P, R ) :-
    innp( w(X,Y), w(2,0), S ),
    S_ is -1*S,
    vm( S_, w(2,0), w(A,A_) ),
    vsum( w(X,Y), w(A,A_), w(X_,Y_) ),
    MP is M*P,
    vm( MP, w(2,0), w(K,K_) ),
    vsum( w(K,K_), w(X_,Y_), R ).
 
s( a, Pt, M, P, R ) :-
    !,
    sa( Pt, M, P, R ).
 
s( b, Pt, M, P, R ) :-
    !,
    sb( Pt, M, P, R ).
 
s( c, Pt, M, P, R ) :-
    !,
    sc( Pt, M, P, R ).
 
s( d, Pt, M, P, R ) :-
    !,
    sd( Pt, M, P, R ).
 
/*  Define Dot Action  */
 
sa_dot( w(X,Y), M, P, R ) :-
    vsum( w(X,Y), w(1,1), w(X_,Y_) ),
    sa( w(X_,Y_), M, P, R_ ),
    vsum( R_, w(-1,-1), R ).
 
sb_dot( w(X,Y), M, P, R ) :-
    vsum( w(X,Y), w(1,1), w(X_,Y_) ),
    sb( w(X_,Y_), M, P, R_ ),
    vsum( R_, w(-1,-1), R ).
 
sc_dot( w(X,Y), M, P, R ) :-
    vsum( w(X,Y), w(1,1), w(X_,Y_) ),
    sc( w(X_,Y_), M, P, R_ ),
    vsum( R_, w(-1,-1), R ).
 
sd_dot( w(X,Y), M, P, R ) :-
    vsum( w(X,Y), w(1,1), w(X_,Y_) ),
    sd( w(X_,Y_), M, P, R_ ),
    vsum( R_, w(-1,-1), R ).
 
sdot( a, w(X,Y), M, P, R ) :-  !, sa_dot( w(X,Y), M, P, R ).
sdot( b, w(X,Y), M, P, R ) :-  !, sb_dot( w(X,Y), M, P, R ).
sdot( c, w(X,Y), M, P, R ) :-  !, sc_dot( w(X,Y), M, P, R ).
sdot( d, w(X,Y), M, P, R ) :-  !, sd_dot( w(X,Y), M, P, R ).
 
/*   Calculate limits for the Jantzen sum formula  */
 
amod( w(X,Y), R ) :-
    X_ is X+1,
    Y_ is Y+1,
    innp( w(X_,Y_), w(2,-1), R ).
 
bmod( w(X,Y), R ) :-
    X_ is X+1,
    Y_ is Y+1,
    innp( w(X_,Y_), w(-2,2), R ).
 
cmod( w(X,Y), R ) :-
    X_ is X+1,
    Y_ is Y+1,
    innp( w(X_,Y_), w(0,1), R ).
 
dmod( w(X,Y), R ) :-
    X_ is X+1,
    Y_ is Y+1,
    innp( w(X_,Y_), w(2,0), R ).
 
amod( w(X,Y), P, R ) :-
    amod( w(X,Y), R_ ),
    R is R_ div P.
 
bmod( w(X,Y), P, R ) :-
    bmod( w(X,Y), R_ ),
    R is R_ div P.
 
cmod( w(X,Y), P, R ) :-
    cmod( w(X,Y), R_ ),
    R is R_ div P.
 
dmod( w(X,Y), P, R ) :-
    dmod( w(X,Y), R_ ),
    R is R_ div P.
 
allmod( Pt, P, L ) :-
    amod( Pt, P, R1 ),
    bmod( Pt, P, R2 ),
    cmod( Pt, P, R3 ),
    dmod( Pt, P, R4 ),
    L = [ R1, R2, R3, R4 ].
 
/*  Generate all weights in the p-squared region linked to an input weight.
    'rgenwts'  generates the four restricted weights linked to 'Pt' for
    given P, and also the weights in alcoves labelled 4, 6, 8 and 11.
    'allwt' generates the set  { (N_*P,N__*P) | 0 =< N_,N__ =< N }
    for the input N. 'lvsum' then adds all possible pairs of vectors from
    these two sets, thus giving all linked weights. In effect, alcoves 1, 2,
    3, 4, 5, 6, 8 and 11 have been translated about.
*/
linked( Pt, N, P, R ) :-
    rgenwts( Pt, P, R_ ),
    allwt( N, P, R__ ),
    lvsum( R_, R__, R___ ),
    posort( R___, R ), !.
 
rgenwts( Pt, P, R_ ) :-
    rgenwts( Pt, P, R, [Pt|R] ),
    R_ = [Pt|R].
 
rgenwts( Pt, P, R, [Pt|R] ) :-
    sc_dot( Pt, 1, P, R1 ),
    sd_dot( R1, 1, P, R2 ),
    sc_dot( R2, 2, P, R3 ),
    sa_dot( R2, 1, P, R4 ),
    sc_dot( R4, 2, P, R5 ),
    sd_dot( R5, 2, P, R6 ),
    sc_dot( R6, 3, P, R7 ),
    R = [R1,R2,R3,R4,R5,R6,R7].
 
allwt( N, P, R ) :-
     allwt( N, 0, 0, P, R ).
 
allwt( N, N_, N__, P, [] ) :-
    greater( w(N_,N__), N ),
    !.
 
allwt( N, N_, N__, P, [Elt|R_] ) :-
    step( w(N_,N__), w(N___,N____), N ),
    N_P is N_*P*2, N__P is N__*P,
    Elt = w( N_P, N__P ),
    allwt( N, N___, N____, P, R_ ).
 
greater( w(A,B), C ) :-
    A > C.
 
step( w(A,B), w(Ai,0), N ) :-
    B >= N,
    !,
    Ai is A + 1.
step( w(A,B), w(A,Bi), N ) :-
    Bi is B + 1.
 
lvsum( L1, L2, R ) :-
    lvsum( L1, L2, [], R ).
 
lvsum( [], L, R, R ):- !.
lvsum( K, [], R, R ):- !.
/*
lvsum( [H|T], [H_|T_], R, [V|R__] ) :-
    vsum( H, H_, V ),
    lvsum( [H], T_, R, R_ ),
    lvsum( T, [H_|T_], R_, R__ ).
*/
lvsum( [H|T], List, Acc, R ):-
    one_elt_sum( H, List, Acc, Sum1 ), !,
    lvsum( T, List, Sum1, R ).
 
one_elt_sum( H, [H1|T], Acc, R ):-
    vsum( H, H1, S ), !,
    one_elt_sum( H, T, [S|Acc], R ).
 
one_elt_sum( H, [], Acc, Acc ).
/*  jsum( Pt, P, L )
        gives the summands appearing in the calculation of the Jantzen
        sum formula.
*/
jsum( Pt, P, L ) :-
    ajsum( Pt, P, L1 ),
    bjsum( Pt, P, L2 ),
    cjsum( Pt, P, L3 ),
    djsum( Pt, P, L4 ),
    L_ = [ L1, L2, L3, L4 ],
    flatten( L_, L ),
    !.
 
ajsum( Pt, P, L ) :-
    amod( Pt, D ),
    Na_ is D div P,
    (
        D mod P =:= 0
    ->
        Na is Na_-1
    ;
        Na = Na_
    ),
    ajsum( Pt, Pt, P, Na, [], L ).
 
 
ajsum( FirstPt, Pt, P, 0, Acc, Acc ):-
    !.
 
ajsum( FirstPt, Pt, P, Na, Acc, L ) :-
    sa_dot( FirstPt, Na, P, R1 ),
    xmod( R1,P, No, NextPt ),
    (
        invalid( NextPt )
    ->
        NextNa is Na-1,
        ajsum( FirstPt, NextPt, P, NextNa, Acc, L )
    ;
        NextNa is Na-1,
        coeff(  No, E_ ),
        p_adic_valn( Na, P, V_ ),
        V is V_+1,
        E is E_*V,
        NewAcc = [ E/NextPt | Acc ],
        ajsum( FirstPt, NextPt, P, NextNa, NewAcc, L )
    ).
 
 
bjsum( Pt, P, L ) :-
    bmod( Pt, D ),
    Nb_ is D div P,
    (
        D mod P =:= 0
    ->
        Nb is Nb_-1
    ;
        Nb = Nb_
    ),
    bjsum( Pt, Pt, P, Nb, [], L ).
 
 
bjsum( FirstPt, Pt, P, 0, Acc, Acc ):-
    !.
 
bjsum( FirstPt, Pt, P, Nb, Acc, L ) :-
    sb_dot( FirstPt, Nb, P, R1 ),
    xmod( R1,P, No, NextPt ),
    (
        invalid( NextPt )
    ->
        NextNb is Nb-1,
        bjsum( FirstPt, NextPt, P, NextNb, Acc, L )
    ;
        NextNb is Nb-1,
        coeff( No, E_ ),
        p_adic_valn( Nb, P, V_ ),
        V is V_+1,
        E is E_*V,
        NewAcc = [ E/NextPt | Acc ],
        bjsum( FirstPt, NextPt, P, NextNb, NewAcc, L )
        ).
 
 
cjsum( Pt, P, L ) :-
    cmod( Pt, D ),
    Nc_ is D div P,
    (
        D mod P =:= 0
    ->
        Nc is Nc_-1
    ;
        Nc = Nc_
    ),
    cjsum( Pt, Pt, P, Nc, [], L ).
 
 
cjsum( FirstPt, Pt, P, 0, Acc, Acc ):-
    !.
 
cjsum( FirstPt, Pt, P, Nc, Acc, L ) :-
    sc_dot( FirstPt, Nc, P, R1 ),
    xmod( R1, P, No, NextPt ),
    (
        invalid( NextPt )
    ->
        NextNc is Nc-1,
        cjsum( FirstPt, NextPt, P, NextNc, Acc, L )
    ;
        NextNc is Nc-1,
        coeff( No, E_ ),
        p_adic_valn( Nc, P, V_ ),
        V is V_+1,
        E is E_*V,
        NewAcc = [ E/NextPt | Acc ],
        cjsum( FirstPt, NextPt, P, NextNc, NewAcc, L )
    ).
 
 
djsum( Pt, P, L ) :-
    dmod( Pt, D ),
    Nd_ is D div P,
    (   D mod P =:= 0
    ->
        Nd is Nd_-1
    ;
        Nd = Nd_
    ),
    djsum( Pt, Pt, P, Nd, [], L ).
 
 
djsum( FirstPt, Pt, P, 0, Acc, Acc ):-
    !.
 
djsum( FirstPt, Pt, P, Nd, Acc, L ) :-
    sd_dot( FirstPt, Nd, P, R1 ),
    xmod( R1,P, No, NextPt ),
    (
        invalid( NextPt )
    ->
        NextNd is Nd-1,
        djsum( FirstPt, NextPt, P, NextNd, Acc, L )
    ;
        NextNd is Nd-1,
        coeff( No, E_ ),
        p_adic_valn( Nd, P, V_ ),
        V is V_+1,
        E is E_*V,
        NewAcc = [ E/NextPt | Acc ],
        djsum( FirstPt, NextPt, P, NextNd, NewAcc, L )
    ).
 
 
coeff( No, E ) :-
    power( No, -1, E ).
 
xmod( Pt, P, No, P_ ) :-
    amod( Pt, R1 ),
    bmod( Pt, R2 ),
    cmod( Pt, R3 ),
    dmod( Pt, R4 ),
    R_ = [ R1/a, R2/b, R3/c, R4/d ],
    keysort( R_, R ),
    reverse( R, R__ ),
    negs( R__, No ),
    inref( Pt, P, No, P_ ).
 
inref( Pt, P, No, P_ ) :-
    amod( Pt, R1 ),
    R1 > 0,
    !,
    S = [ 3/d, 2/c, 1/b ],
    inref( S, Pt, P, No, P_ ).
 
inref( Pt, P, No, P_ ) :-
    amod( Pt, R1 ),
    R1 < 0,
    !,
    inref( [ 4/b, 3/c, 2/d, 1/a ], Pt, P, No, P_ ).
 
inref( Pt, P, No, P_ ) :-
    amod( Pt, R1 ),
    R1 = 0,
    !,
    sc_dot(Pt, 0, P, P_ ).
 
inref( [/(Int, Root) | T], Pt, P, No, P_ ) :-
    Int > No,
    !,
    inref( T, Pt, P, No, P_ ).
 
inref( [], Pt, P, No, Pt ):-
    !.
 
inref( [/(Int, Root)| T ], Pt, P, No, P_ ) :-
    sdot( Root , Pt, 0, P, P1 ),
    inref( T, P1, P, No, P_ ).
 
/* `negs' counts the no. of negative numbers in a list.
*/
negs( [/(Int,Root)|T ], C ) :-
    Int < 0,
    !,
    negs( T, C_ ),
    C is C_+1.
 
negs( [/(Int,Root)|T], C ) :-
   Int >= 0,
   !,
   negs( T, C ).
 
negs( [], 0 ):-
   !.
/*
    This section takes the sequence of highest weight vectors of
    Weyl modules calculated by `jsum' , expands into a sum of
    simples and does any necessary cancelling.
*/
/*  DATA STRUCTURES:
Hvector     : 2-vector w(X,Y), the highest weight vector of a
         Weyl module.
hvector     : 2-vector w(X,Y), the highest weight vector of a
         simple module appearing in the expansion of a Weyl module.
Table assertions: facts:
                  v( Hvector, Array ).
Patterns        : List of elements, each of the form Coeff/hvector,
        where Coeff = +1 or -1.
Arrays          : implemented by ARRAYS.PL.
                  Used to store V's.
                  Map an index in 1..10 to a list of hvectors,
                  representing elements of the same multiplicity
                  as the index.
Sorted bags     : ordered by @<.
                  Used during cancelling.
Multiplicity lists:
                  list of elements, each of form count(N,L) where
                  N > 0, and L is an hvector.
                  Need not be sorted, but no hvector may appear more
                  than once.
Run lists       : list of elements, each an hvector.
                  Identical hvectors may occur more than once:
                  if they do, they must be in the same run.
*/
/*  ARRAYS  */
array_length(Array+_, Length) :-
     functor(Array, array, Length).
array_to_list(Array+_, List) :-
     Array =.. [array|Wrapped],
     un_wrap(Wrapped, List).
 
un_wrap([History|Histories], [Element|Elements]) :-
    get_last(History, Element),
    !,
    un_wrap(Histories, Elements).
un_wrap([], []).
 
fetch(Index, Array+_, Element) :-
    arg(Index, Array, History),
    get_last(History, Element).
 
get_last([Head|Tail], Element) :-
    var(Tail),
    !,
    Element = Head.
get_last([_|Tail], Element) :-
    get_last(Tail, Element).
 
list_to_array(List, Array+0) :-
    wrap_up(List, Wrapped),
    Array =.. [array|Wrapped].
 
wrap_up([Element|Elements], [[Element|_]|Wrapped]) :-
    !,
    wrap_up(Elements, Wrapped).
wrap_up([], []).
 
store(Index, Array+Updates, Element, NewArray+NewUpdates) :-
    functor(Array, array, Length),
    arg(Index, Array, History),
    put_last(History, Element),
    K is Updates+1,     !,
    store(Length, K, NewUpdates, Array, NewArray).
 
store(N, N, 0, Old, New) :-
    !,
    Old =.. [array|OldList],
    un_wrap(OldList, MidList),
    !,
    wrap_up(MidList, NewList),
    New =.. [array|NewList].
 
store(_, U, U, Array, Array).
 
put_last(History, Element) :-
     var(History),     !,
     History = [Element|_].
 
put_last([_|History], Element) :-
     put_last(History, Element).
 
/*  ERROR REPORTING  */
moan( Message ) :-
    !,
    output( Message<>'.' ), nl.
 
moan( Message, pattern(Here) ) :-
    !,
    output( Message...'at'...Here...'in pattern:' ), nl,
    current_pattern( P ),
    output( seplist(P,'') ), nl.
 
moan( Message, pattern ) :-
    !,
    output( Message...'in pattern:' ), nl,
    current_pattern( P ),
    output( seplist(P,'') ), nl.
 
moan( Message, pattern_line(Line) ) :-
    !,
    output( Message...'in pattern:' ), nl,
    output( seplist(Line,'') ), nl.
 
/*  DISPLAY TABLE  */
 
show_row( N ) :-
    v( N, VM ),
    array_to_list( VM, L ),
    write( L ), nl.
 
table_to_file( File ) :-
    telling( COS ),
    tell( File ),
    table_to_file,
    told,
    tell( COS ).
 
table_to_file :-
    fast_setof( Vector+Row, v(Vector,Row), Rows ),
    general_sort( Rows, po_row, Rows_ ),
    rowlist_to_file( Rows_ ).
 
po_row( Vector1+Row1, Vector2+Row2 ) :-
    po( Vector1, Vector2 ).
 
/*  CALCULATING NEW V'S FROM PATTERNS  */
 
v_if_unknown( Vector, Prime, Row ) :-
    jsum( Vector, Prime, R ),
    v_for( Vector, R, Prime, Row ).
 
/*  v_for( Vector+, Pattern+, Prime+, VM- ):
        Vector:  a vector.
        Pattern: the pattern calculated by `jsum' for Vector.
        VM:      an array.
        VM is the array formed by expanding Pattern.
        Errors are reported using Pattern, stored as fact
        `current_pattern(_)'. Intermediate stages in the calculation
        are displayed to COS ( if required ).
        As a side-effect, `v_for' adds a table assertion for the
        Vector/VM pair it's calculated.
*/
v_for( Vector, Pattern, P, VM ) :-
     asserta( current_pattern(Pattern) ),
     make_extra_copies( Pattern, [], Pattern_ ),
     expand_vectors( Pattern_, [], [], P, Pluses, Minuses ),
     cancel( Pluses, Minuses, [], V ),
     to_mult( V, VM ),
     amend_row_if_necessary( Vector, VM, P, NewVM ),
     update_table( Vector, NewVM ),
     term_from_file( 'FILTNS13', F ),
     term_to_file( 'FILTNS13', [v(Vector,NewVM)|F] ),
     array_to_list( NewVM, VM_ ),
     output( 'Array for '...Vector~ ),
     output( '    :'...VM_~),
     retract( current_pattern( Pattern ) ), !.
 
/*  update_table( Vector+, VM+ ):
        Vector:   a vector.
        VM   :   the corresponding array.
        Add a table assertion for that vector/array pair,
        deleting one if already present.
*/
update_table( Vector, VM ) :-
    retractall( v(Vector,_) ),
    asserta( v(Vector,VM) ).
 
/*  make_extra_copies :-
        converts a vector with coefficient +-X into a string of |X|
        vectors, each with coefficient +-1
*/
make_extra_copies( [], Acc, L ):-
    reverse( Acc, L ),
    !.
make_extra_copies( [X/W|T], Acc, L ) :-
    X > 0, !,
    X1 is X - 1,
    make_extra_copies( [X1/W|T], [1/W|Acc], L ).
 
make_extra_copies( [X/W|T], Acc, L ) :-
    X < 0, !,
    X1 is X + 1,
    make_extra_copies( [X1/W|T], [-1/W|Acc], L ).
 
make_extra_copies( [0/W|T], Acc, L ) :-
    make_extra_copies( T, Acc, L ).
 
/*  expand_vectors(P+, Pluses+, Minuses+, Prime+, Pluses_-, Minuses_-)
        P       : a pattern.
        Pluses  : bag of vectors.
        Minuses : bag of vectors.
        Pluses_ : sorted bag of vectors.
        Minuses_: sorted bag of vectors.
        Pluses_ is formed by sorting ( E appended to Pluses ), retaining
        duplicates,
        where E is the result of taking each positive vector L in P,
        and replacing it by the set of vectors in the array for
        the table assertion for L.
        Minuses_ is formed from Minuses and P in the same way, but
        for negative vectors.
*/
expand_vectors( [], Pluses, Minuses, P, Pluses_, Minuses_ ) :-
    !,
    sort_all( Pluses, Pluses_ ),
    sort_all( Minuses, Minuses_ ).
 
expand_vectors( [ 1/V | Rest ], Pluses, Minuses, P, Pluses__,
                Minuses__ ) :-
    !,
    add_vs( V, P, Pluses, Pluses_ ),
    expand_vectors( Rest, Pluses_, Minuses, P, Pluses__, Minuses__ ).
 
expand_vectors( [ -1/V | Rest ], Pluses, Minuses, P, Pluses__,
                Minuses__ ) :-
    !,
    add_vs( V, P, Minuses, Minuses_ ),
    expand_vectors( Rest, Pluses, Minuses_, P, Pluses__, Minuses__ ).
 
expand_vectors([ H | Rest ], Pluses, Minuses, P, Pluses, Minuses) :-
    moan('Coefficient of +1 or -1 expected in pattern', pattern(H)).
 
 
/*  add_vs( Vector+, Prime+, E+, E_- ):
        Vector:  a vector.
        E    :  a list of vectors.
        E_   :  a list of vectors.
        E_ is the result of taking the array for table assertion Vector,
        and appending its elements to E.
*/
add_vs( Vector, P, L, L_ ) :-
    not( v(Vector,_) ),
    !,
    moan( 'Warning: row for vector about to be calculated'
         ...Vector, pattern ),
    v_if_unknown( Vector, P, _ ),
    add_vs( Vector, P, L, L_ ).
 
add_vs( Vector, P, L, L_ ) :-
    Vector = w(_,_),    !,
    v( Vector, VM ),
    array_to_list( VM, VL ),
    flatten( VL, V ),
    append( [Vector|V], L, L_ ).
 
add_vs( Vector, P, L, L ) :-
    !,
    moan( 'Vector expected in pattern', pattern(Vector) ).
 
/*  cancel( P+, M+, Accumulator, C- ):
        P:  Sorted bag.
        M:  Sorted bag.
        C-: Sorted bag, to be treated as a run list.
        C is the result of cancelling every element in M from P.
        M must not contain more of any element than P.
*/
cancel( Pluses, [], Acc, Pluses_ ) :-
    !,
    append( Acc, Pluses, Pluses__ ),
    sort_all( Pluses__, Pluses_ ).
 
cancel( [], Minuses, Acc, Acc ) :-
    !,
    moan( 'There are no pluses left', pattern ).
 
cancel( [H|Pluses_N], [H|Minuses_N], Acc, Pluses_ ) :-
    !,
    cancel( Pluses_N, Minuses_N, Acc, Pluses_ ).
 
cancel( [Plus|Pluses_N], [Minus|Minuses_N], Acc, Pluses_ ) :-
    Plus @< Minus,    !,
    cancel( Pluses_N, [Minus|Minuses_N], [Plus|Acc], Pluses_ ).
 
cancel( [Plus|Pluses_N], [Minus|Minuses_N], Acc, Pluses_ ) :-
    Plus @> Minus,
    !,
    moan( 'Unmatched minus found', pattern(Minus) ),
    cancel( [Plus|Pluses_N], Minuses_N, Acc, Pluses_ ).
 
/*  to_mult( V+, VM- ):
        V:  Run list.
            No run must be length > 10.
        VM: Array.
        VM counts the elements in V.
*/
to_mult( V, VM ) :-
    to_counted( V, VC, break ),
    list_to_array( [ [], [], [], [],
                     [], [], [], [], [], [] ], VM_Initial ),
    counted_to_mult( VC, VM_Initial, VM ).
 
/*  to_counted( L+, M-, State+ ):
        L+:     Run list.
        M-:     Multiplicity list.
        State:  `break' or `count(N,H)', N > 0.
                Should be `break' for the first call.
        M counts all elements of L.
*/
to_counted( [], [], break ) :- !.
 
to_counted( [], [count(N,H)], count(N,H) ) :- !.
 
to_counted( [H|T], L, break ) :-
    !,
    to_counted( T, L, count(1,H) ).
 
to_counted( [H|T], L, count(N,H) ) :-
    !,
    Ni is N + 1,
    to_counted( T, L, count(Ni,H) ).
 
to_counted( [H1|T], [count(N,H2)|L], count(N,H2) ) :-
    H1 \= H2,
    !,
    to_counted( [H1|T], L, break ).
 
/*  counted_to_mult( L+, VM-, VM_- ):
        L   : Multiplicity list.
        VM  : Array in.
        VM_ : Array out:
        VM_ is VM updated with L.
*/
counted_to_mult( [], VM, VM ) :- !.
 
counted_to_mult( [count(N,H)|T], VM, VM ) :-
    N > 10,
    !,
    moan( 'Multiplicity'...N<>'> 10 (for'...H...') generated',
           pattern ).
 
counted_to_mult( [count(N,H)|T], VM, VM__ ) :-
    !,
    fetch( N, VM, Mult_sub_N ),
    store( N, VM, [H|Mult_sub_N], VM_ ),
    counted_to_mult( T, VM_, VM__ ).
 
/* `filtration' takes all weights linked to an input weight in a
    finite region ( determined by an input integer N ) and
    calculates the Jantzen filtration for each.
    If Stop \= 'end', the calculation will end after calcfilns
    encounters weight Stop.
*/
filtration( Pt, N, P, Stop ) :-
    linked( Pt, N, P, L ),
    term_to_file( 'SCRATCH', L ),
    term_to_file( 'SOLNS', T ),
    fail.
filtration( Pt, N, P, Stop ) :-
    term_from_file( 'SCRATCH', L ),
    calcfilns( L, P, Stop ).
 
/*  filtration_of_2(N) :-
        works only for the prime 2. N determines the region of the
        calculation as before.
*/
filtration_of_2(N) :-
     T = [],
     term_to_file('SOLNS', T ),
     S = [w(0,0), w(1,0), w(0,1), w(1,1)],
     filtration_of_p( S, N, 2 ).
 
/*  filtration_of_3(N) :-
        only for the prime 3.
*/
filtration_of_3( N ) :-
     S = [w(0,0), w(1,0), w(0,1), w(1,1), w(0,2), w(1,2), w(2,2)],
     filtration_of_p( S, N, 3 ).
 
filtration_of_p( S, N, P ) :-
     allwt( N, P, R_ ),
     lvsum( S, R_, R__ ),
     posort( R__, R ),
     term_to_file( 'SCRATCH2', R ),
     fail.
 
filtration_of_p( S, N, P ) :-
     term_from_file( 'SCRATCH2', R ),
     calcfilns( R, P, end ).
 
calcfilns( [], _, _ ) :- !.
calcfilns( [H|T], P, Stop ):-
    v( H, VM ), !,
    calcfilns( T, P, Stop ).
 
calcfilns( [H|T], P, Stop ) :-
   ( H \= end, H = Stop
    ->
    jsum( H, P, L ),
    v_for( H, L, P, J ),
    true
    ;
    jsum( H, P, L ),
    v_for( H, L, P, J ),  nl,
    fail ).
calcfilns( [H|T], P, Stop ) :-
    trimcore,
    calcfilns( T, P, Stop ).
/*
        The calculation which gives the dimension of the Weyl module
        with highest weight w(X,Y), followed by the one giving the simple dim.
*/
wdim( w(X,Y), D ) :-
    D is ((X+1)*(Y+1)*(X+Y+2)*(X+(2*Y)+3))/6.
 
in_restricted_region( w(X,Y), P ) :-
    X < P, Y < P.
 
sdim( W, P, SDim ) :-
    known_sdim( W, P, SDim ),
    !.
 
sdim( w(X,Y), P, SDim ) :-
    not( in_restricted_region( w(X,Y), P ) ),
    !,
    XmodP is X mod P,
    YmodP is Y mod P,
    XdivP is X div P,
    YdivP is Y div P,
    sdim( w(XmodP,YmodP), P, SDim_mod ),
    sdim( w(XdivP,YdivP), P, SDim_div ),
    SDim is SDim_mod * SDim_div,
    asserta( known_sdim(w(X,Y),P,SDim) ).
 
sdim( W, P, SDim ) :-
    rsdim( W, P, SDim ).
 
rsdim( W, P, SDim ) :-
    wdim( W, WDim ),
    ( v( W, Row ) -> true ; v_if_unknown( W, P, Row ) ),
    array_to_list( Row, RowAsNestedList ),
    flatten( RowAsNestedList, RowList ),
    sum_sdims( W, RowList, P, SumSDims ),
    SDim is WDim - SumSDims.
 
sum_sdims( W, RowList, P, SDim ) :-
    known_sum_sdims( W, P, SDim ),
    !.
    /*  This clause will probably never succeed, since sum_sdims
        shouldn't be called more than once for the same W.  */
 
sum_sdims( W, RowList, P, SDim ) :-
    sum_sdims( W, RowList, P, 0, SDim ),
    asserta( known_sum_sdims(W,P,SDim) ).
 
sum_sdims( W, [], P, Sum, Sum ) :- !.
 
sum_sdims( W, [W1|W_rest], P, SumSoFar, Sum ) :-
    !,
    sdim( W1, P, SDim ),
    NewSum is SDim + SumSoFar,
    sum_sdims( W, W_rest, P, NewSum, Sum ).
 
sum_sdims1( [], P, Sum, Sum ):-
    !.
 
sum_sdims1( [H|T], P, AccSum, Sum ):-
    sdim( H, P, HS ),
    NewAccSum is AccSum + HS,
    sum_sdims1( T, P, NewAccSum, Sum ).
/*  check_dims:
        calculates for each Weyl module its dimension, the dimension of
        its top composition factor, the sum of the dimensions of its
        other composition factors, and the difference between this
        latter number and the Weyl dimension (to be called the `error').
*/
check_dims( P ) :-
    fast_setof( Vec, v( Vec, Row ), Vecs ),
    posort( Vecs, SortedVecs ),
    do_vecs( SortedVecs, P ).
 
do_vecs( [], P ) :- !.
do_vecs( [ Vec | T ], P ) :-
    !,
    v( Vec, Row ),
    check_dim( Vec, P, Row ),
    do_vecs( T, P ).
 
check_dim( Vec, P, Row ) :-
    wdim( Vec, D ),
    sdim( Vec, P, D_ ),
    array_to_list( Row, L ),
    flatten( L, L_ ),
    sum_sdims( Vec, L_, P, D__ ),
    D___ is D-(D__+D_),
    (
      alc_no( Vec, N )
    ->
      asserta( d( Vec, N, D_, D, D__, D___) )
    ;
      asserta( d1( Vec, D_, D, D__, D___) )
    ),
    write('.').
 
calc_error( Vec, Row, P, Error ) :-
    wdim( Vec, D ),
    sdim( Vec, P, D_ ),
    array_to_list( Row, L ),
    flatten( L, L_ ),
    sum_sdims( Vec, L_, P, D__ ),
    Error is D-(D__+D_).
/*
     Adjust filtration by taking into account Steinberg's theorem. Used only
     if there are simples appearing with multiplicity > 1 : the latter case
     is determined by dimension calculations.
*/
/*  multiple_elts_only:
        take a list (to be the output of 'comp_factors') and retain only
        those elements appearing in the list more than once.
*/
multiple_elts_only( [], Acc, Acc ):-
    !.
 
multiple_elts_only( [H|T], Acc, Mults ):-
    (
        member( H, T )
    ->
        multiple_elts_only( T, [H|Acc], Mults )
    ;
        multiple_elts_only( T, Acc, Mults )
    ).
 
amend_row_if_necessary( Vec, OldRow, P, OldRow ) :-
    in_restricted_region( Vec, P ),
    !.
     /*  Note that if calc_dim is called from amend_row_if_necessary
         to check points in the restricted region, it will cause
         an infinite loop, as predicates called by calc_dim assume
         that the table entry for Vec is already asserted.
    */
amend_row_if_necessary( Vec, OldRow, P, AmendedRow ) :-
    calc_error( Vec, OldRow, P, Error ),
    (
        Error < 0
    ->
        moan('amend_row: error is negative, so old row kept.'),
        AmendedRow = OldRow
    ;
        Error = 0
    ->
        AmendedRow = OldRow
    ;
        amend_row( Vec, OldRow, Error, P, AmendedRow )
    ),
    retractall( known_sum_sdims( Vec, P, _ ) ).
 
 
amend_row( Vec, OldRow, Error, P, AmendedRow ) :-
    comp_factors( Vec, P, Factors),
    multiple_elts_only( Factors, [], Solution ),
    move_amongst_layers( Solution, OldRow, AmendedRow ).
 
/*  move_amongst_layers( Solution+, OldRow+, AmendedRow- ):
        The solution is given by Steinberg's theorem.
*/
move_amongst_layers( [], Row, Row ) :- !.
 
move_amongst_layers( [ Vec | RestVecs ], OldRow, AmendedRow ) :-
    find_layer_number_of( Vec, OldRow, LayerNumber ),
    number_of_occurrences( Vec, RestVecs, OccurrencesMinus1 ),
    OccurrencesPlus1 is OccurrencesMinus1 + 2,
    partitions_of_length( LayerNumber, OccurrencesPlus1, Partitions ),
    (
        length( Partitions, L ), L > 1
    ->
        moan('move_amongst_layers: more than 1 partition, so 1st one used.'),
        [ Partition | _ ] = Partitions
    ;
        [ Partition ] = Partitions
    ),
    delete( RestVecs, Vec, RestOfSolution ),
    insert_into_layers( OldRow, Vec, Partition, Row_ ),
    delete_from_old_layer( Row_, Vec, LayerNumber, Row__ ),
    move_amongst_layers( RestOfSolution, Row__, AmendedRow ).
 
insert_into_layers( Row, Vec, [], Row ) :- !.
 
insert_into_layers( Row, Vec, [LayerNo|RestLayerNos], NewRow ) :-
    fetch( LayerNo, Row, Layer ),
    store( LayerNo, Row, [Vec|Layer], Row_ ),
    insert_into_layers( Row_, Vec, RestLayerNos, NewRow ).
 
delete_from_old_layer( Row, Vec, LayerNumber, NewRow ) :-
    fetch( LayerNumber, Row, Layer ),
    delete( Layer, Vec, NewLayer ),
    store( LayerNumber, Row, NewLayer, NewRow ).
 
number_of_occurrences( _, [], 0 ) :- !.
 
number_of_occurrences( X, [X|T], N ) :-
    !,
    number_of_occurrences( X, T, NMinus1 ),
    N is NMinus1 + 1.
 
number_of_occurrences( X, [_|T], N ) :-
    number_of_occurrences( X, T, N ).
 
find_layer_number_of( Vec, Row, LayerNumber ) :-
    find_layer_number_of( Vec, Row, 1, LayerNumber ).
 
find_layer_number_of( Vec, Row, 11, 1 ) :-
    moan('find_layer_number_of: vector '<>Vec<>' not found.').
 
find_layer_number_of( Vec, Row, N, LayerNumber ) :-
    fetch( N, Row, Layer ),
    (
        member( Vec, Layer )
    ->
        LayerNumber = N
    ;
        NextN is N + 1,
        find_layer_number_of( Vec, Row, NextN, LayerNumber )
    ).
 
/*        Delete all occurrences of a given weight from a list.
*/
delete( [H|T], H, T_ ) :-
    !,
    delete( T, H, T_ ).
 
delete( [H|T], X, [H|T_] ) :-
    X \= H,
    !,
    delete( T, X, T_ ).
 
delete( [], H, [] ) :- !.
 
/*----------------------------------------------------------------------
           NEW BITS ------  where the problems are bound to be.
  --------------------------------------------------------------------*/
/*  all_wts( Wt+, Allwts- ):
        finds all weights of a Weyl module of highest weight Wt, the
        multiplicity of each, and outputs a list, each weight appearing
        its multiplicity number of times.
*/
all_wts( Wt, Allwts ) :-
    find_wts( Wt, L ),
    list_of_ccls( L, Clist ),
    ranked_list_of_ccls( Clist, [H|T] ),
    mult1_to_high_wt( H, Acc ),
    mults_to_ccls( Wt, T, Acc, Wtswithmults ),
    make_extra_copies( Wtswithmults, [], Wtswithmults_ ),
    dekey( Wtswithmults_, Allwts ).
 
/*  find_wts(Wt+, List-):
        finds all weights of a Weyl module of highest weight Wt and
        outputs them in a list L, where L is a list of weights sorted
        according to the rank p.o. The multiplicity of each weight has
        yet to be found at this stage.
*/
find_wts( Wt, L ) :-
    sa( Wt, 0, 0, Wt1 ),
    string( w(2, -1), Wt1, L1 ),
    sd( Wt1, 0, 0, Wt2 ),
    string( w(2, 0), Wt2, L2 ),
    cstring( L2, [], L3 ),
    cstring( L1, [], L4 ),
    sb( Wt, 0, 0, Wt3 ),
    string( w(-2, 2), Wt3, L5 ),
    cstring( L5, [], L6 ),
    L_ = [ L3, L4, L6 ],
    flatten( L_, L__ ),
    no_copies( L__, L___ ),
    posort( L___, L ).
 
/*  string( Root+, Weight+, List- ):
        finds the root-string in the positive Root direction and outputs
        in a list.
*/
string( Root, Wt, L ) :-
    innp( Wt, Root, N_ ),
    N is -1*N_,
    string( Root, Wt, N, [], L ).
 
string( Root, Wt, 0, Acc, [Wt|Acc] ):-
    !.
 
string( Root, Wt, N, Acc, L ) :-
    vsum( Wt, Root, Wt1 ),
    N1 is N-1, N1 >= 0,
    string( Root, Wt1, N1, [Wt|Acc], L ).
 
/*  cstring( List+, List- )
        finds the string in the c direction from each weight in the
        input list.
*/
cstring ( [], Acc, Acc ):-
    !.
 
cstring( [H|T], Acc, R ) :-
    innp( H, w(0, 1), N ),
    string( w(0, -1), H, N, [], L ),
    cstring( T, [L|Acc], R ).
 
/*  no_copies( List+, List- )
        removes extra copies of elements in a list. Shouldn't be needed really
        in find_wts. But better safe than incorrect.
*/
no_copies( L, L_ ) :-
    no_copies( L, [], L_ ).
 
no_copies( [], Acc, Acc ):- !.
 
no_copies( [H|T], Acc, R ) :-
    (
        member( H, Acc )
    ->
        no_copies( T, Acc, R )
    ;
        no_copies( T, [H|Acc], R )
    ).
 
/*  w_conjs( Wt+, List-):
        finds all weights conjugate to Wt under the action of the Weyl
        group. For some Wt's there won't be eight distinct conjugates,
        so we delete copies. This series of reflections will work only
        when Wt is of the form w(X,Y), X >= 0, Y>=0. No problem, since
        every weight is conjugate to something like that. "reverse" is
        used to keep Wt as the first element in the list of conjugates
        (no_copies would put it last).
*/
w_conjs( w( X, Y ), L ) :-
    X >= 0, Y >= 0,
    sa( w(X, Y), 0, 0, Wt1 ),
    sd( Wt1, 0, 0, Wt2 ),
    sc( Wt2, 0, 0, Wt3 ),
    sb( Wt3, 0, 0, Wt4 ),
    sa( Wt4, 0, 0, Wt5 ),
    sd( Wt5, 0, 0, Wt6 ),
    sc( Wt6, 0, 0, Wt7 ),
    L_ = [ w(X, Y), Wt1, Wt2, Wt3, Wt4, Wt5, Wt6, Wt7 ],
    no_copies( L_, L__ ),
    reverse( L__, L ).
 
/*  list_of_ccls( List+, ListOfClasses:List of lists- ):
        takes an input list of weights and reforms it as a list of
        conjugacy classes. All conjugate weights should be in the input
        list. Output is a list of lists, and should include every elt.
        of the original list.
*/
list_of_ccls( L, Clist ) :-
    list_of_ccls( L, L, [], Clist).
 
list_of_ccls( [], [], Acc, Acc ):-
    !.
 
list_of_ccls( [w(X, Y)|T], List, Acc, Clist ) :-
    (
        X >= 0, Y >= 0
    ->
        w_conjs( w(X, Y), Hconjs ),
        delete_sublist_from_list( List, Hconjs, NewList ),
        list_of_ccls( NewList, NewList, [Hconjs|Acc], Clist )
    ;
        list_of_ccls( T, T, Acc, Clist )
    ).
 
/*  delete_sublist_from_list( List+, Sublist+, Newlist- )
        self-explanatory. Uses 'delete\3' from old part of program.
*/
delete_sublist_from_list( L, [], L ).
 
delete_sublist_from_list( L, [H|T], NewL ) :-
    delete( L, H, NewL1 ),
    delete_sublist_from_list( NewL1, T, NewL ).
 
/*  ranked_list_of_ccls( List+, RankedList- ):
        The calculation of the multiplicities (one for each conj. class)
        must be done in a certain sequence, beginning far from the
        origin and working back - reverse induction? I think the usual
        ranking on weights will be enough to give a well-defined order
        in which to proceed. However, we must have the ranked list in
        {\it decreasing} order. 'posort_lists' uses 'keysort', and
        'keysort' sorts to increasing order.
*/
ranked_list_of_ccls( [H|T], L ) :-
    ranked_list_of_ccls( H, T, [], L_ ),
    keysort( L_, L1 ),
    dekey( L1, L__ ),
    reverse( L__, L ).
 
ranked_list_of_ccls( [], [], Acc, Acc ):-
    !.
 
ranked_list_of_ccls( [H|T], [H1|T1], Acc, L ) :-
    !,
    rank( H, Hrank ),
    ranked_list_of_ccls( H1, T1, [Hrank/[H|T]|Acc], L ).
 
ranked_list_of_ccls( [H|T], [], Acc, L ) :-
    rank( H, Hrank ),
    L = [Hrank/[H|T]|Acc].
 
/*  map_mult( Int+, List+, Accumulator, Listof WeightsWithIntAttached- )
    mult1_to_high_weight attaches the multiplicity 1 to each elt. in the
       conjugacy class of weights containing the highest weight -
       classes appear as lists of vectors.
*/
mult1_to_high_wt( L, L_ ) :-
    map_mult( 1, L, [], L_ ).
 
map_mult( M, [], Acc, Acc ):- !.
 
map_mult( M, [H|T], Acc, Mapped ) :-
    map_mult( M, T, [M/H|Acc], Mapped ).
 
/* mults_to_ccls( Vector+, ListofLists+, Acc+, List-)
      takes a list of lists (conj. classes), calculates the multiplicity
      of each ( using
        mult_of_ccl( Vector+, List+, Accumulator:List+, Multiplicity:Integer-)
      ) attaches the mult. of each class to each elt. of that class, and
     outputs a flattened list consisting of all elt.s of all classes with their
     respective multiplicities attached.
mult_of_ccl  takes a list (one conj. class), takes the first elt. of that list
             and uses it to find the mult. common to each elt. in the class.
             It expects the first elt. to be positive i.e. of the form
            w(X, Y), X>=0, Y>=0. The predicate 'reverse/2' in 'w_conjs/2'
            should have ensured this.
*/
 
mults_to_ccls( Lambda, [], Acc, Acc ):-
    !.
 
mults_to_ccls( Lambda, [H|T], Acc, L ) :-
    !,
    mult_of_ccl( Lambda, H, Acc, M ),
    map_mult( M, H, [], HM ),
    append( HM, Acc, NewAcc ),
    mults_to_ccls( Lambda, T, NewAcc, L ).
 
mult_of_ccl( Lambda, [Wt|T], Acc, M ) :-
    vsum( Lambda, w(1, 1), Lambda1 ),
    length_sqd( Lambda1, Length1 ),
    vsum( Wt, w(1, 1), Wt1 ),
    length_sqd( Wt1, Length2 ),
    Lhs is Length1-Length2,
    sum_on_rhs( Wt, Acc, S ),
    M is S/Lhs.
 
length_sqd( w(X, Y), L ):-
    X2 is X*X,
    Y_ is 2*Y,
    Sy is X+Y_,
    Sy2 is Sy*Sy,
    L is X2 + Sy2.
 
/* sum_on_rhs( WeightVector+, AccumulatedList+, Integer-)
       uses a list of (previously calculated) weights with mults. attached
       to find the mult. of the input weight vector.
*/
sum_on_rhs( Wt, Acc, S ) :-
    wts_in_dira( Wt, Acc, Ma ),
    wts_in_dirb( Wt, Acc, Mb ),
    wts_in_dirc( Wt, Acc, Mc ),
    wts_in_dird( Wt, Acc, Md ),
    S is 2*(Ma+Mb+Mc+Md).
 
wts_in_dira( Wt, Acc, Ma ) :-
    wts_in_dira( Wt, Acc, 0, Ma ).
 
wts_in_dira( Wt, Acc, N, Ma ) :-
    vsum( Wt, w(2, -1), w(X, Y) ),
    (
        member( Ma1/w(X, Y), Acc )
    ->
        componenta( w(X, Y), C ),
        NewN is N+(C*Ma1),
        wts_in_dira( w(X, Y), Acc, NewN, Ma )
    ;   Ma = N
    ).
 
wts_in_dirb( Wt, Acc, Mb ) :-
    wts_in_dirb( Wt, Acc, 0, Mb ).
 
wts_in_dirb( Wt, Acc, N, Mb ) :-
    vsum( Wt, w(-2, 2), w(X, Y) ),
    (
        member( Mb1/w(X, Y), Acc )
    ->
        componentb( w(X, Y), C ),
        NewN is N+(C*Mb1),
        wts_in_dirb( w(X, Y), Acc, NewN, Mb )
    ;   Mb = N
    ).
 
wts_in_dirc( Wt, Acc, Mc ) :-
    wts_in_dirc( Wt, Acc, 0, Mc ).
 
wts_in_dirc( Wt, Acc, N, Mc ) :-
    vsum( Wt, w(0, 1), w(X, Y) ),
    (
        member( Mc1/w(X, Y), Acc )
    ->
        componentc( w(X, Y), C ),
        NewN is N+(C*Mc1),
        wts_in_dirc( w(X, Y), Acc, NewN, Mc )
    ;   Mc = N
    ).
 
wts_in_dird( Wt, Acc, Md ) :-
    wts_in_dird( Wt, Acc, 0, Md ).
 
wts_in_dird( Wt, Acc, N, Md ) :-
    vsum( Wt, w(2, 0), w(X, Y) ),
    (
        member( Md1/w(X, Y), Acc )
    ->
        componentd(w(X, Y), C ),
        NewN is N+(C*Md1),
        wts_in_dird( w(X, Y), Acc, NewN, Md )
    ;   Md = N
    ).
 
componenta( w(X, Y), C ):-
    C is 2*X.
 
componentb( w(X, Y), C ):-
    C is 4*Y.
 
componentc( w(X, Y), C ):-
    Y_ is 2*Y,
    C_ is X + Y_,
    C is 2*C_.
 
componentd( w(X, Y), C ):-
    C_ is X + Y,
    C is 4*C_.
/*
        The Steinberg decomposition of a weight.
         stein_decomp( Wt+, Prime+, ListofWeights-).
         highest_power( Int+, Prime+, H-),
         where H is the greatest integer such that P~H <= Int.
*/
stein_decomp( w(X, Y), P, Decomp ) :-
    highest_power( X, P, N1 ),
    highest_power( Y, P, N2 ),
    greater( N1, N2, N ),
    stein_decomp( w(X, Y), P, N, [], Decomp ),
    asserta( known_stein_decomp( w(X, Y), Decomp ) ).
 
highest_power( X, P, 0 ):-
    X < P,
    !.
 
highest_power( X, P, N ):-
    X1 is X div P,
    highest_power( X1, P, N1 ),
    N is N1 + 1.
 
greater( X, Y, X ) :-
    X >= Y, !.
greater( X, Y, Y ) :-
    Y > X, !.
 
stein_decomp( w(X, Y), P, N, Acc, Decomp ) :-
    known_stein_decomp( w(X, Y), Decomp ),
    !.
 
stein_decomp( w(X, Y), P, N, Acc, Decomp ) :-
    (
       N > 0
    ->
       power( N, P, PN ),
       Xmodpn is X mod PN,
       Ymodpn is Y mod PN,
       Xdivpn is X div PN,
       Ydivpn is Y div PN,
       N1 is N-1,
       stein_decomp( w(Xmodpn, Ymodpn), P, N1,
                  [PN/w(Xdivpn, Ydivpn)|Acc],
                  Decomp)
    ;  Decomp = [1/w(X, Y)|Acc]
    ).
/*
        In which alcove of the restricted region is a Weight?
        Here's the answer. We assume that 'Wt' is in the region to begin
        with i.e. 'Wt' is of the form w(X, Y), 0 <= X,Y < P.
*/
which_alcove( Wt, P, 1 ) :-
        cmod( Wt, C ), C =< P, !.
 
which_alcove( Wt, P, 2 ) :-
        cmod( Wt, C ), C > P,
        dmod( Wt, D ), D =< P, !.
 
which_alcove( Wt, P, 3 ) :-
        cmod( Wt, C ), L is 2*P, C =< L,
        dmod( Wt, D ), D > P, !.
 
which_alcove( Wt, P, 5 ) :-
        cmod( Wt, C ), L is 2*P, C > L, !.
 
/*   simple_wts( Wt+, Prime+, Wts:List of weights- )
        Here we determine the weights of the simple module at weight Wt.
        I've put cuts in, in the belief that they help.
*/
simple_wts( Wt, P, Wts ) :-
    s_wts( Wt, Wts ),
    !.
 
simple_wts( Wt, P, Wts ) :-
    which_alcove( Wt, P, 1),
    !,
    all_wts( Wt, Wts_),
    sort_all( Wts_, Wts),
    asserta( s_wts( Wt, Wts)).
 
simple_wts( Wt, P, Wts ) :-
    which_alcove( Wt, P, 2 ), !,
    all_wts( Wt, Wts_ ),
    (
        dmod( Wt, D ),
        D = P
    ->
        sort_all( Wts_, Wts )
    ;
        sc_dot( Wt, 1, P, Wt1 ),
        simple_wts( Wt1, P, Wts1 ),
        sort_all( Wts_, Wts__ ),
        cancel( Wts__, Wts1, [], Wts )
    ),
    asserta( s_wts( Wt, Wts ) ).
 
simple_wts( Wt, P, Wts ) :-
    which_alcove( Wt, P, 3 ), !,
    all_wts( Wt, Wts_ ),
    (
        ( C is 2*P, cmod( Wt, C )
         ; amod ( Wt, A ), A = P )
    ->
        sort_all( Wts_, Wts )
    ;
        sd_dot( Wt, 1, P, Wt1 ),
        sort_all( Wts_, Wts__ ),
        simple_wts( Wt1, P, Wts1 ),
        cancel( Wts__, Wts1, [], Wts )
    ),
    asserta( s_wts( Wt, Wts ) ).
 
simple_wts( Wt, P, Wts ) :-
    which_alcove( Wt, P, 5 ),
    !,
    all_wts( Wt, Wts_ ),
    (
     bmod( Wt, B ), B = P
    ->
     sort_all( Wts_, Wts )
    ;
     sc_dot( Wt, 2, P, Wt1 ),
     sort_all( Wts_, Wts__ ),
     simple_wts( Wt1, P, Wts1 ),
     cancel( Wts__, Wts1, [], Wts )
    ),
    asserta( s_wts( Wt, Wts )).
 
/*   char( Wt+, AlcoveNumberForWt+, ListofPlus-, ListofMinus- )
        Give the character of a Weyl mod. in rest'd region.
*/
char( Wt, 1, P, [Wt], [] ):-
    !.
 
char( Wt, 2, P, [Wt], [] ) :-
    dmod( Wt, N ),
    N = P,
    !.
 
char( Wt, 2, P, [Wt], [R] ) :-
    dmod( Wt, L ), L \= P,
    !,
    sc_dot( Wt, 1, P, R ).
 
char( Wt, 3, P, [Wt], [] ) :-
    (
        cmod( Wt, L_ ),
        L is 2*P,
        L_ = L
    ;
        amod( Wt, N ),
        N = P
    ),
    !.
 
char( Wt, 3, P, [Wt, Wt1], [Wt2] ) :-
    sd_dot( Wt, 1, P, Wt2 ), not(invalid( Wt2 )),
    sc_dot( Wt2, 1, P, Wt1 ),
    !.
 
char( Wt, 5, P, [Wt], [Wt2] ) :-
    (
        amod( Wt, N ), N = P,
        bmod( Wt, M ), M \= P
    ;
        amod( Wt, M ), M \= P,
        bmod( Wt, N ), N = P
    ),
    !,
    sc_dot( Wt, 2, P, Wt2 ).
 
char( Wt, 5, P, [Wt], [] ):-
    amod( Wt, N ),
    bmod( Wt, N ), N = P,
    !.
 
char( w(X, Y), 5, P, [w(X, Y), Wt2], [Wt3, Wt1] ) :-
    sc_dot( w(X, Y), 2, P, Wt3 ),
    sd_dot( Wt3, 1, P, Wt2 ),
    sc_dot( Wt2, 1, P, Wt1 ).
 
/* 'xmod_list( List+, P+, Out:List- )':
        does 'xmod' for a list of vectors (brings each one into the
        positive region if necessary).
*/
xmod_list( List, P, Out ):-
    xmod_list( List, P, [], Out).
 
xmod_list( [], P, Acc, Acc ):-
    !.
xmod_list( [H|T], P, Acc, Out ) :-
    xmod( H, P, No, H_ ),
    coeff( No, E ),!,
    xmod_list( T, P, [E/H_|Acc], Out ).
 
/* 'wts_in_tensor':
        takes each wt in the tensor decomposition (input as a list of weights)
        finds the weights of
        the simple mod. at that weight, and multiplies by the
        appropriate power of p i.e. does the Frobenius Twist, and outputs a
        list of new weights.
*/
wts_in_tensor( [], P, Acc, Acc ):-
    !.
wts_in_tensor( [N/H|T], P, Acc, All ) :-
    simple_wts( H, P, HWts ),
    multiply_all( N, HWts, NHWts ),!,
    wts_in_tensor( T, P, [NHWts|Acc], All ).
 
multiply_all( N, HWts, NHWts ):-
    multiply_all( N, HWts, [], NHWts ).
 
multiply_all( _, [], Acc, Acc ):-
    !.
multiply_all( N, [H|T], Acc, Done ) :-
    vm( N, H, NH ),
    multiply_all( N, T, [NH|Acc], Done ).
 
/* 'lvsum_list':
    takes a list of lists and adds each elt. of each list to each elt.
    of every other list. If you see what I mean.
*/
lvsum_list( [], [] ):-
    !.
lvsum_list( [H|T], Sums ) :-
    lvsum_list( T, H, Sums ).
 
lvsum_list( [], Sums, Sums ):-
    !.
lvsum_list( [H|T], Acc, Sums ):-
    lvsum( H, Acc, NewAcc ),
    lvsum_list( T, NewAcc, Sums).
 
/* 'comp_factors'.
    Finally here's what we want. A list of the composition factors of a
    Weyl module, omitting the top factor. This will go into the main
    program in 'gen_solns', and should result in just one soln being
    found.
*/
comp_factors( Wt, P, Factors ) :-
    stein_decomp( Wt, P, [H|T] ),
    wts_in_tensor( T, P, [], All ),
    (
     Wt = w(20, 20)
    ->
      write( wts_in_tensor( T, P, [], All ) ), nl
    ;
      true
    ),
    lvsum_list( All, Sums_ ),
    flatten( Sums_, Sums ),
    dekey1( H, H_ ),
    which_alcove( H_, P, Alc ),
    char( H_, Alc, P, Plus, Minus ),
    (
     Wt = w(20, 20)
    ->
      write( char( H_, Alc, P, Plus, Minus ) ), nl
    ;
      true
    ),
    lvsum( Sums, Plus, Plus_ ),
    lvsum( Sums, Minus, Minus_ ),
    xmod_list( Plus_, P, Plus__ ),
    delete( Plus__, 1/Wt, Lus ),
    xmod_list( Minus_, P, Minus__ ),
    by_minus1( Minus__, [], Minus1 ),
    append( Lus, Minus1, Chars ),
    (
      Wt = w(20, 20)
    ->
      write( Chars ), nl
    ;
      true
    ),
    expand_vectors( Chars, [], [], P, Pluses, Minuses ),
    cancel( Minuses, Pluses, [], Factors ).

dekey1( H, H_ ) :-
    dekey( H, H_ ),
    !.
 
dekey1( H, H_ ) :-
    dekey( [H], [H_] ).
 
by_minus1( [], Acc, Acc ):- !.
 
by_minus1( [C/Vec|T], Acc, B ):-
    D is -1*C, !,
    by_minus1( T, [D/Vec|Acc], B ).
 
/*
------------------------------------------------------------------------------
--------    Alcove Numbering --------------
------------------------------------------------------------------------*/
 
 
number_the_alcoves_list( P, N, Weights ):-
    number_the_alcoves_list( P, 0, N, [], Weights ).
 
number_the_alcoves_list( P, M, 0, Acc, Weights ):-
    reverse(Acc, Weights),
    !.
 
number_the_alcoves_list( P, L, M, Acc, Wts ):-
    Lby2 is L*2,
    LbyP is L*P,
    power( 2, Lby2, X ),
    Lplus1 is L + 1,
    Number1 is Lby2 + X + 1,
    seq1_in_a_list( w(0, LbyP), Number1, P, Lplus1, Acc, Acc1 ),
    LbyPplus4 is LbyP + (P-3),
    Lby2plus1 is Lby2 + 1,
    power( 2, Lby2plus1, Y ),
    Y1 is Y + 1,
    seq1_in_a_list( w(0, LbyPplus4), Y1, P, Lplus1, Acc1, Acc2 ),
    Number2 is Y + Lby2 + 2,
    seq2_in_a_list( w(2, LbyPplus4), Number2, P, Lplus1, Acc2, Acc3 ),
    LbyPplus5 is LbyP + (P-2),
    Lby2plus2 is Lby2 + 2,
    power( 2, Lby2plus2, Z ),
    Z1 is Z + 1,
    seq2_in_a_list( w(2, LbyPplus5), Z1, P, Lplus1, Acc3, Acc4 ),
    Mminus1 is M - 1,
    number_the_alcoves_list( P, Lplus1, Mminus1, Acc4, Wts ).
 
seq1_in_a_list( Wt, N, P, C, Acc, NewAcc ):-
    asserta( alc_no( Wt, N ) ),
    Acc1 = [Wt|Acc],
    C1 is C - 1,
    (
        C1 > 0
    ->  X is (2*P)-2,
        Y is -1*(P-1),
        vsum( Wt, w(X, Y), Wt1 ),
        N1 is N + 1,
        asserta( alc_no( Wt1, N1 ) ),
        Acc2 = [Wt1|Acc1],
        vsum( Wt1, w(2, -1), Wt2 ),
        N2 is N1 + 1,
        seq1_in_a_list( Wt2, N2, P, C1, Acc2, NewAcc )
    ;
        NewAcc = Acc1
    ).
 
seq2_in_a_list( Wt, N, P, C, Acc, NewAcc ):-
    asserta( alc_no( Wt, N ) ),
    Acc1 = [Wt|Acc],
    X is (2*P)-6,
    Y is -1*(P-3),
    vsum( Wt, w(X, Y), Wt1 ),
    N1 is N + 1,
    asserta( alc_no( Wt1, N1 ) ),
    Acc2 = [Wt1|Acc1],
    C1 is C - 1,
    (
        C1 > 0
    ->  vsum( Wt1, w(6, -3), Wt2 ),
        N2 is N1 + 1,
        seq2_in_a_list( Wt2, N2, P, C1, Acc2, NewAcc )
    ;
        NewAcc = Acc2
    ).
 
number_the_alcoves( P, N ):-
    number_the_alcoves( P, 0, N ).
 
number_the_alcoves( P, N, 0 ):-
    !, true.
 
number_the_alcoves( P, L, M ):-
    Lby2 is L*2,
    LbyP is L*P,
    power( 2, Lby2, X ),
    Lplus1 is L + 1,
    Number1 is Lby2 + X + 1,
    seq1_in_a( w(0, LbyP), Number1, P, Lplus1 ),
    LbyPplus4 is LbyP + (P-3),
    Lby2plus1 is Lby2 + 1,
    power( 2, Lby2plus1, Y ),
    Y1 is Y + 1,
    seq1_in_a( w(0, LbyPplus4), Y1, P, Lplus1 ),
    Number2 is Y + Lby2 + 2,
    seq2_in_a( w(2, LbyPplus4), Number2, P, Lplus1 ),
    LbyPplus5 is LbyP + (P-2),
    Lby2plus2 is Lby2 + 2,
    power( 2, Lby2plus2, Z ),
    Z1 is Z + 1,
    seq2_in_a( w(2, LbyPplus5), Z1, P, Lplus1 ),
    Mminus1 is M - 1,
    number_the_alcoves( P, Lplus1, Mminus1 ).
 
seq1_in_a( Wt, N, P, C ):-
    asserta( alc_no( Wt, N ) ),
    C1 is C - 1,
    (
        C1 > 0
    ->  X is (2*P)-2,
        Y is -1*(P-1),
        vsum( Wt, w(X, Y), Wt1 ),
        N1 is N + 1,
        asserta( alc_no( Wt1, N1 ) ),
        vsum( Wt1, w(2, -1), Wt2 ),
        N2 is N1 + 1,
        seq1_in_a( Wt2, N2, P, C1 )
    ;
        true
    ).
 
seq2_in_a( Wt, N, P, C ):-
    asserta( alc_no( Wt, N ) ),
    X is (2*P)-6,
    Y is -1*(P-3),
    vsum( Wt, w(X, Y), Wt1 ),
    N1 is N + 1,
    asserta( alc_no( Wt1, N1 ) ),
    C1 is C - 1,
    (
        C1 > 0
    ->  vsum( Wt1, w(6, -3), Wt2 ),
        N2 is N1 + 1,
        seq2_in_a( Wt2, N2, P, C1 )
    ;
        true
    ).
 
filtn1( P, N ):-
    number_the_alcoves_list( P, N, List ),
    F = [],
    term_to_file( 'FILTNS13', F ),
    calcfilns( List, P, end ).
 
filtn1_restart( P, N ):-
    number_the_alcoves_list( P, N, L ),
    term_from_file( 'FILTNS13', F ),
    assert_all( F ),
    calcfilns( L, P, end ).
 
debug1( Wt, P ):-
    term_from_file( 'FILTNS13', F ),
    assert_all( F ),
    calcfilns( [Wt], P, end ).
 
assert_all( [] ):-
    !.
assert_all( [H|T] ):-
    asserta( H ),
    assert_all( T ).
 
/*------------ Rewrite--------*/
rewrite_file( File, P, N ):-
    number_the_alcoves( P, N ),
    term_from_file( File, F ),
    write_filtns( F ).
 
write_filtns( [] ):-
    !, true.
 
write_filtns( [H|T] ):-
    H = v( Vec, VM ),
    write_vec( Vec ), nl,
    write_filtns1( VM, 1 ),
    write_filtns( T ).
 
write_filtns1( _, 8 ):-
    !, true.
 
write_filtns1( VM, N ):-
    fetch( N, VM, LayerN ),
    write('**'),
    write_layer( LayerN ), nl,
    N1 is N+1,
    write_filtns1( VM, N1 ).
 
write_layer( [] ):-
    !, true.
 
write_layer( [H|T] ):-
    write_vec( H ),
    write(','),
    write_layer( T ).
 
/*
Joss, Here I am again with good old B2. Could you please do a run for the
prime 13? I need a little elbow room. We know that  nothing can go wrong this
time. It goes
filtn1( 13, 7).
filtn1_restart( 13, 7).
:
(repeat until a command end, rather than a machine-time end, is reached)
:
(Begin logging)
rewrite('FILTNS13', 13, 7 ).
(end logging)
Send logfile to me.
There's no urgency about this request.
Any scandal?
john
*/
