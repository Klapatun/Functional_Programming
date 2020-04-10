% Автор: Клапатун Антон
% Дата: 12.12.2019

:-dynamic toy/2.

%...............................................................................


goal:- consult("BD_Toys.txt"),
       repeat,
       writeln("Выберите один из следующих пунктов меню:"),
       writeln("1 - Просмотреть содержимое динамической памяти;"),
       writeln("2 - Добавление записей;"),
       writeln("3 - Удаление записей;"),
       writeln("4 - Получение названия всех наиболее дорогих игрушек;"),
       writeln("5 - Выход (с сохранением)."),
       read(Choice),
       Choice < 6,
       proccess(Choice),
       Choice=5,!.


%...............................................................................

proccess(1):- %write("Введите имя базы данных: "),
                      %read(NameBD),
                      findall((Name,Cost), toy(Name,Cost), ToysList),
                      write_bd(ToysList).

proccess(2):- nl,writeln("Добавление элемента:"),
              repeat,
              write("Название игрушки"),
              read(Name),
              write("Стоимость"),
              read(Cost),
              assertz(toy(Name,Cost)),
              nl,writeln("Хотите добавить еще запись? (y - да; n - нет): "),
              read(Answ),nl,
              check_answer(Answ),!.

proccess(3):- nl,writeln("Удаление записей."),nl,
              repeat,
              writeln("Введите название удаляемой игрушки: "),
              read(Name),
              writeln("Введите стоимость удаляемой игрушки: "),
              read(Cost),
              remove_record(Name,Cost),
              findall((Name,Cost), toy(Name,Cost), ToysList),
              write_bd(ToysList),
              nl,writeln("Хотите удалить еще что-то? (y - да; n - нет): "),
              read(Answ),nl,
              check_answer(Answ),!.

proccess(4):- nl,writeln("Наиболее дорогие игрушки:"),nl,
              most_expensive_toy.

proccess(5):- findall((Name,Cost), toy(Name,Cost), ToysList),
              open("BD_Toys.txt", write, F),
              set_output(F),
              write_in_file(ToysList),
              close(F).

%...............................................................................
%1
write_bd([]):- !.
write_bd([H|T]):- writeln(H),
                 write_bd(T),!.

%...............................................................................
%2
%Add

check_answer(y):- fail.
check_answer(n):- write("Готово"),nl.


%...............................................................................
%3
%Delete

remove_record(Name, Cost):- findall((Name,Cost),toy(Name,Cost),ListT),
                      write_elem(ListT).

write_elem([]):- nl,writeln("Sorry, but I can't to find it"),nl.
write_elem([(N,C)|[]]):- retract(toy(N,C)).
write_elem([(N,C)|T]):- retract(toy(N,C)),
                        write_elem(T),!.

%...............................................................................
%4
%Наиболее дорогие игрушки

most_expensive_toy:- findall(C, toy(_,C), ToysListN),
                               msort(ToysListN, ToysListN2),
                               reverse(ToysListN2,ToysListN3),
                               remove_excess(ToysListN3, ToysListN4),
                               nth0(0,ToysListN4,Max),
                               condition(ToysListN4, Max, _, _, ToysList),
                               write_bd(ToysList),nl.


condition([],_, ToysList, _, ToysList):- !.
condition([H|T], Max, ToysListBefore, ToysListAfter, ToysList):- (Max-1000)=< H,
                                                                 findall((Name,H), toy(Name,H), TmpList),
                                                                 append(ToysListBefore, TmpList, ToysListAfter),
                                                                 condition(T, Max, ToysListAfter, _, ToysList),!.
condition([H|[H|T]], Max, ToysListBefore, _, ToysList):- condition(T, Max, ToysListBefore, _, ToysList),!.
condition([_|_], _,ToysList,_,ToysList):- !.




remove_excess([],_):-!.
remove_excess([H|[L|T]], ListNew):- H\=L,
                                    remove_excess(T,ListNew1),
                                    append([H,L],ListNew1, ListNew),
                                    !.
remove_excess([H|[_|T]],ListNew):- remove_excess(T,ListNew1),
                                   append([H],ListNew1, ListNew),
                                   !.


%...............................................................................
%5

write_in_file([]):- !.
write_in_file([(Name,Cost)|T]):- write('toy("'),write(Name),
                                 write('",'),write(Cost),
                                 write(').'),nl,
                                 write_in_file(T),!.