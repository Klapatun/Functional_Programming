goal:-
    writeln('¬ведите список'),
    read(L),
    writeln('¬ведите N'),
    read(N),
    shift(L,N).

shift(L, 0):- write(L),!.
shift([H|T], N) :- N1 is N-1, append(T,[H],L1), shift(L1, N1).

