% Автор:
% Дата: 05.12.2019

go:- write("Введите имя файла: "),
       read(Name),
       read_file(Name, ListLengh,String),
       writeln(ListLengh),
       writeln(String),
       change_file(Name,ListLengh,String),
       writeln("Конец!").


%***********************************************

change_file(Filename,ListLength,String):- check_exist(Filename),
                                          atom_string(A,Filename),
                                         tell(A),
                                         write_all(ListLength,String),
                                         told.

write_all([HL|TL],[HS|TS]):- not(HL == -1),
                             add_tab(HL,HS),
                             write_all(TL,TS).

add_tab(-1,_):- !.
add_tab(Length,String):- Length > 40,
                    sub_string(String,0,40,(Length-40),String),
                    writeln(String).

add_tab(Length,String):- Ltub is (40-Length)//2,
                         tab(Ltub), writeln(String).
                         
%***********************************************

read_file(Filename,ListLengh,String):- check_exist(Filename),
                                open(Filename,read,F),
                                set_input(F),
                                read_all_lines(F,ListLengh,String),
                                close(F).

check_exist(Filename):-exists_file(Filename),!.
check_exist(_):-writeln('Такого файла нет'),
                fail.

num_lines(_,N,_):- at_end_of_stream,
                 N is -1,
                 !.
num_lines(F,N,L):- read_line_to_codes(F, L),
                 string_length(L,N).


read_all_lines(F,[HL|TL], [HS|TS]):- num_lines(F,N,L),
                          not(N == -1),
                         HL is N,
                         atom_string(HS,L),
                         read_all_lines(F,TL,TS).
read_all_lines(_,[-1],_):- !.


                         

