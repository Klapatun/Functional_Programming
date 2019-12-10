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
                      %read(NameBD),
                      consult("BD_Toys.txt"),
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
check_answer(n):- write("������"),nl.


%...............................................................................
%Delete

proccess(3):- nl,writeln("�������� �������."),nl,
              repeat,
              writeln("������� �������� �������: "),
              read(Name),
              remove_record(Name),
              findall((Name,Cost), toy(Name,Cost), ToysList),
              write_bd(ToysList),
              nl,writeln("������ ������� ��� ���-��? (y - ��; n - ���): "),
              read(Answ),nl,
              check_answer(Answ),!.

remove_record(Name):- findall((_,C),toy(Name,C),ListT),
                      write_elem(ListT).

write_elem([]):- nl,writeln("Sorry, but I can't to find it"),nl.
write_elem([(N,C)|[]]):- retract(toy(N,C)).
write_elem([(N,C)|T]):- retract(toy(N,C)),
                        write_elem(T),!.

%...............................................................................
%�������� ������� �������

proccess(4):- nl,writeln("�������� ������� �������:"),nl,
              most_expensive_toy(ToysList),
              nl,writeln("������ ������� ��� ���-��? (y - ��; n - ���): "),
              read(Answ),nl,
              check_answer(Answ),!.

most_expensive_toy(ToysList):- findall(C, toy(_,C), ToysListN),
                               msort(ToysListN, ToysListN2),
                               reverse(ToysListN2,ToysListN3),
                               nth0(0,ToysListN3,Max),
                               condition(ToysListN3, Max, _, _, ToysList),
                               write_bd(ToysList).
                                          
                                          
condition([], ToysList, _, ToysList):- !.
condition([H|T], Max, ToysListBefore, ToysListAfter, ToysList):- (Max-100)=< H,
                                  findall((Name,H), toy(Name,H), TmpList),
                                  append(ToysListBefore, TmpList, ToysListAfter),
                                  condition(T, Max, ToysListAfter, _, ToysList).
condition([_|T], _,ToysList,_,ToysList):- !.

                                        


