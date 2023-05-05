use dz_4;

/*
1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру,
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old.
(использование транзакции с выбором commit или rollback – обязательно).
*/
-- создание таблицы users_old
drop table if exists users_old;
create table users_old (
	id serial primary key,
    firstname varchar(50),
    lastname varchar(50) comment 'Фамилия',
    email varchar(120) unique
);
-- создание процедуры
drop procedure if exists add_user;
delimiter //
create procedure add_user(
num bigint, out tran_result varchar(100))
begin
	declare `_rollback` bit default b'0';
	declare code varchar(100);
	declare error_string varchar(100); 
	declare continue handler for sqlexception
	begin
 		set `_rollback` = b'1';
 		get stacked diagnostics condition 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	end;

	start transaction;
		insert into users_old (firstname, lastname, email)
			select firstname, lastname, email 
			from users
				where id = num;
		delete from users 
			where id = num;
	
	if `_rollback` then
		set tran_result = CONCAT('Error: ', code, ' Error text: ', error_string);
		rollback;
	else
		set tran_result = 'O K';
		commit;
	end if;
end//
delimiter ;
-- вызов процедуры
call add_user(6, @tran_result); 
select @tran_result;

/*
2. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
с 00:00 до 6:00 — "Доброй ночи".
*/
delimiter //
create function hello() 
	returns varchar(25)
begin
	declare result_text varchar(25);
	select case 
		when current_time >= '06:00:00' and  current_time < '12:00:00' then 'Good morning'
		when current_time >= '12:00:00' and  current_time < '18:00:00' then 'Good day'
		when current_time >= '18:00:00' and  current_time < '00:00:00' then 'Good evening'
		else 'Good night'
end into result_text;
return result_text;
end//

delimiter ;

select hello();