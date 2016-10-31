/*  SKIER.PL  */


/*  I shall use this knowledge base to illustrate how Prolog
    inference works.
*/


/*10*/   suits(Skier, st_sartre) :-
            is_a(Skier, beginner),
            wants(Skier, fun).

/*20*/   suits(Skier, schloss_heidegger) :-
            is_a(Skier, beginner),
            wants(Skier, serious).

/*30*/   suits(Skier, chateau_derrida) :-
            is_a(Skier, advanced),
            wants(Skier, serious).

/*40*/   suits(Skier, wittgenstein_gladbach) :-
            is_a(Skier, advanced),
            wants(Skier, fun).

/*50*/   is_a(Skier, beginner) :-
            had_lessons(Skier, L),
            L < 30.

/*60*/   is_a(Skier, beginner) :-
            had_lessons(Skier, L),
            L >= 30,
            has_fitness(Skier, poor).

/*70*/   is_a(Skier, advanced) :-
            had_lessons(Skier, L),
            L >= 30,
            has_fitness(Skier, good).

/*80*/   has_fitness(Skier, poor) :-
            max_pressups(Skier, P),
            P < 10.

/*90*/   has_fitness(Skier, good) :-
            max_pressups(Skier, P),
            P >= 10.

wants(eddie,fun).
max_pressups(eddie,170).
had_lessons(eddie,78).
