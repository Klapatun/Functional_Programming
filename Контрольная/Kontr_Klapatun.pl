% Автор:
% Дата: 06.12.2019

:-dynamic toy/2.

%...............................................................................


goal:- repeat,
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

proccess(5).

%...............................................................................

proccess(1):- write("Введите имя базы данных: "),
                      read(NameBD),
                      consult(NameBD),
                      findall((Name,Cost), toy(Name,Cost), ToysList),
                      write_bd(ToysList).

write_bd([]):- !.
write_bd([H|T]):- writeln(H),
                 write_bd(T),!.

%...............................................................................
%Add

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

check_answer(y):- fail.
check_answer(n):- write("Записи добавлены"),nl.


%...............................................................................
%Delete

proccess(3):- nl,writeln("Удаление записей."),nl,
              repeat,
              writeln("Введите название игрушки: "),
              read(Name),
              remove_record(Name),
              nl,writeln("Хотите удалить еще что-то? (y - да; n - нет): "),
              read(Answ),nl,
              check_answer(Answ),!

remove_record(Name):- findall((N,C),toy(Name,C),ListT),

                      retract(toy(Name,_)).

%...............................................................................

%proccess(4,BD_open):- BD_open == 1.


