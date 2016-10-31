%questao 1
ultimo(X,[X]).
ultimo(X,[_|As]):-ultimo(X,As).

truncamento([_],[]).
truncamento([A|As],[A|Bs]):-
	truncamento(As,Bs).

soma([],0).
soma([A|As],B):-
	soma(As,SomaAnterior),
	B is A+SomaAnterior.

somalista([],[]).
somalista(A,B):-
	truncamento(A,At),
	truncamento(B,Bt),
	ultimo(Bu,B),
	somalista(At,Bt),
	soma(A,Bu).

	
%questao 2
potencia(X,Y,Z):-
	spot(X,X,Y,Z).

spot(_,X,1,X):- true,!.
spot(Xi,X,Y,Z):-
	X2 is Xi*X,
	Y2 is Y-1,
	Y2>0,
	spot(Xi,X2,Y2,Z).


%questao 3
npertence(X, [Y|Z]) :- not(X=Y), npertence(X, Z).
npertence(_, []).
pertence(X, [Y|_]) :- X=Y.
pertence(X, [Z|Y]) :- not(X=Z), pertence(X, Y).

cont02([], _, X) :- X=0.
cont02([X|L1], L2, K) :- not([X] = []), npertence(X, L2), cont02(L1, L2, K1), K is K1.
cont02([X|L1], L2, K) :- pertence(X, L2), cont02(L1, L2, K1), K is K1+1.
cont02([X|L1], [Y|L2], K) :- not(X=Y), cont01(L1, L2, K1), K is K1.
cont01([], [], X) :- X=0.
cont01([X|L1], [Y|L2], K) :- not(X=Y), cont01(L1, L2, K1), K is K1.
cont01([X|L1], [Y|L2], K) :- X = Y, cont01(L1, L2, K1), K is K1+1.
p(L1, L2, X, Y) :- cont01(L1, L2, X), cont02(L1, L2, Z), Y is Z-X, !.

%questao 4
comeca_com([],_).
comeca_com([A|As],[A|Bs]):-
	comeca_com(As,Bs).

sublista([A|As],[B|Bs]):-
	comeca_com([A|As],[B|Bs]);
	sublista([A|As],Bs).

%questao 5
permut([A|As],[B|Bs]):-
	(A is B,permut(As,Bs)).
