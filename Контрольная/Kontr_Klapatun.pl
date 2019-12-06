% �����:
% ����: 06.12.2019

:-dynamic toy/2.

%...............................................................................


goal:- repeat,
       writeln("�������� ���� �� ��������� ������� ����:"),
       writeln("1 - ����������� ���������� ������������ ������;"),
       writeln("2 - ���������� �������;"),
       writeln("3 - �������� �������;"),
       writeln("4 - ��������� �������� ���� �������� ������� �������;"),
       writeln("5 - ����� (� �����������)."),
       read(Choice),
       Choice < 6,
       proccess(Choice),
       Choice=5,!.


%...............................................................................

proccess(5).

%...............................................................................

proccess(1):- write("������� ��� ���� ������: "),
                      read(NameBD),
                      consult(NameBD),
                      findall((Name,Cost), toy(Name,Cost), ToysList),
                      write_bd(ToysList).

write_bd([]):- !.
write_bd([H|T]):- writeln(H),
                 write_bd(T),!.

%...............................................................................
%Add

proccess(2):- nl,writeln("���������� ��������:"),
              repeat,
              write("�������� �������"),
              read(Name),
              write("���������"),
              read(Cost),
              assertz(toy(Name,Cost)),
              nl,writeln("������ �������� ��� ������? (y - ��; n - ���): "),
              read(Answ),nl,
              check_answer(Answ),!.

check_answer(y):- fail.
check_answer(n):- write("������ ���������"),nl.


%...............................................................................
%Delete

proccess(3):- nl,writeln("�������� �������."),nl,
              repeat,
              writeln("������� �������� �������: "),
              read(Name),
              remove_record(Name),
              nl,writeln("������ ������� ��� ���-��? (y - ��; n - ���): "),
              read(Answ),nl,
              check_answer(Answ),!.

remove_record(Name):- findall((_,C),toy(Name,C),ListT),
                      write_elem(ListT).

write_elem([]):- nl,wreteln("Sorry, but I can't to find it :("),nl.
write_elem([(N,C)|[]]):- retract(toy(N,C)).
write_elem([(N,C)|T]):- retract(toy(N,C)),
                        write_elem(T),!.

%...............................................................................

%proccess(4,BD_open):- BD_open == 1.


