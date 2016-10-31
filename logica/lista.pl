conta([],0).
conta([_|B],N):- conta(B,Nb),N is Nb+1.


/*Remove Primeira ocorrencia*/
remove_primeiro(A,[A|L],L):-!.
remove_primeiro(A,[B|Bs],[B|Ls]):-
	remove_primeiro(A,Bs,Ls).

remove_um(A,[A|L],L).
	remove_um(A,[B|Bs],[B|Ls]):-
	remove_primeiro(A,Bs,Ls).

remove_todas(X,[],[]):-!.
remove_todas(X,[X|L],L1):-
	remove_todas(X,L,L1),!.
remove_todas(X,[Y|L],[Y|L1]):-
	remove_todas(X,L,L1),!.

rem2(X,[],[]).
rem2(X,[X|L],L1):-
	rem2(X,L,L1).
rem2(X,[Y|L],[Y|L1]):-
	rem2(X,L,L1).

ultimo(X,[X]).
ultimo(X,[_|As]):-ultimo(X,As).

primeiro(X,[X|_]).

membro(X,[X|_]).
membro(X,[_|Ys]):-membro(X,Ys).

truncamento([_],[]).
truncamento([A|As],[A|Bs]):-
	truncamento(As,Bs).

reverso([],[]).
reverso([A|As],B):-
	ultimo(A,B),
	truncamento(B,Bt),
	reverso(As,Bt),!.

diff_lista(A,[],A).
diff_lista(As,[B|Bs],C):-
	remove_primeiro(B,As,A2),!,
	diff_lista(A2,Bs,C).

diff(A,[],A).
diff(As,[B|Bs],C):-
	rem2(B,As,A2),!,
	diff(A2,Bs,C).

 
customfindall( X, Goal, Xlist)  :-
  call( Goal),                         % Find a solution
  assertz( queue(X) ),                 % Assert it
  fail;                                % Try to find more solutions
  assertz( queue(bottom) ),            % Mark end of solutions
  collect( Xlist).                     % Collect the solutions 
collect( L)  :-
  retract( queue(X) ), !,              % Retract next solution
  ( X == bottom, !, L = []             % End of solutions?
    ;
    L = [X | Rest], collect( Rest) ).  % Otherwise collect the rest

megadiff(A,B,C):-
	customfindall(X,(membro(X,A),\+ membro(X,B)),C).

eh_conjunto([],[]).
eh_conjunto([L|Ls],C):-
	remove_primeiro(L,C,C1),
	remove_todas(L,[L|Ls],L1),
	eh_conjunto(L1,C1).



divide(_,[],[],[]).
divide(X,[L|Ls],L1,L2):-
	(eh_conjunto([L|Ls],[L|Ls]),
		(
			L<X,
			remove_primeiro(L,L1,LL),
			divide(X,Ls,LL,L2)
		);(
			L>=X,
			remove_primeiro(L,L2,LL),
			divide(X,Ls,L1,LL)
		)
	);(
		list_to([L|Ls],LSet),
		divide(X,LSet,L1,L2)
	).



uniao([],X,X).
uniao([A|As],B,U):-
	uniao(As,[A|B],U).

intercecao_conjunto(A,B,I):-
	uniao(A,B,U),
	eh_conjunto(U,USet),
	diff(USet,A,Ua),
	diff(USet,B,Ub),
	uniao(Ua,Ub,Z),
	diff(USet,Z,I),
	write("U:"),write(U),nl,
	write("A:"),write(A),nl,
	write("B:"),write(B),nl,
	write("Ua:"),write(Ua),nl,
	write("Ub:"),write(Ub),nl,
	write("UUa:"),write(UUa),nl,
	write("UUb:"),write(UUb),nl.


intercecao_lista([],_,[]).
intercecao_lista(_,[],[]).
intercecao_lista([A|As],B,I):-
	(membro(A,B),
		remove_primeiro(A,B,B1),
		remove_primeiro(A,I,I1),
		intercecao_lista(As,B1,I1)
	);(
		intercecao_lista(As,B,I)
	),!.


aaa(X):-membro([1,2,3]).
