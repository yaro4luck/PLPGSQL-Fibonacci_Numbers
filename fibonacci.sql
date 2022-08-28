/* --------------------------
 *    Fibonacci Function
 *
 *  Author: Yaroslav Kozlov
 *    Date: 27.08.2022
 */--------------------------

\echo
\echo '                                ╔═════════════════════════════════════════╗'
\echo '                                ║                                         ║'
\echo '                                ║    F I B O N A C C I   N U M B E R S    ║'
\echo '                                ║                                         ║'
\echo '                                ╚═════════════════════════════════════════╝'
\echo


drop function if exists фибоначчи(int, bool);

-- Числа Фибоначчи
create function фибоначчи(

    порядковый_номер_числа 	int, 
    вывести_все            	bool	default false
    
    ) returns text

as $body$
declare

    f1 		numeric = -1;
    f2 		numeric = 1;
    fтекущее 	numeric = 0;
    fформат 	text;

begin	
    
    if вывести_все then 
	
	-- Шапка вывода
	raise notice '  Числа Фибоначчи';
	raise notice '-------------------';
	raise notice '       N  F(N)';
    
    end if;
    
    for i in 1..порядковый_номер_числа
    loop		
	
	f1 = f2;
	f2 = fтекущее;
	fтекущее = f1 + f2;
	
	-- Вставка пробелов между троек разрядов
	fформат = trim(reverse(regexp_replace(reverse(fтекущее::text), '(\d{3})', '\1 ', 'g')));
    
	if вывести_все 
	    then raise notice '%: %', format('%8s', i), fформат;
	end if;
		
    end loop;

    return fформат;

end;
$body$ language plpgsql;


\echo
\df "фибоначчи"

\echo
\echo 1. Пример вызова функции с распечаткой всех значений:
\echo
\echo '         ┌─────────────────────────────────┐'
\echo '         │                                 │'
\echo '         │   select фибоначчи(32, true);   │'
\echo '         │                                 │'
\echo '         └─────────────────────────────────┘' 
\echo
select фибоначчи(32, true) "Число Фибоначчи для N = 32";

\echo
\echo 2. Пример вызова функции без вывода всех значений:
\echo
\echo '           ┌──────────────────────────┐'
\echo '           │                          │'
\echo '           │   select фибоначчи(9);   │'
\echo '           │                          │'
\echo '           └──────────────────────────┘' 
\echo
select фибоначчи(9) "Число Фибоначчи для N = 9";