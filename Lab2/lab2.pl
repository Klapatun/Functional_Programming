goal:-
    writeln('������� ������'),
    read(L),
    writeln('������� N'),
    read(N),
    shift(L,N).

shift(L, 0):-write(L), !.
shift([_|T], N) :- N1 is N-1, L1 = T, shift(L1, N1).