drop database if exists dz_2;
create database dz_2;
use dz_2;

/*
1. Используя операторы языка SQL, создайте табличку “sales”.
Заполните ее данными.
*/
drop table if exists sales;
-- создание таблицы
create table sales(
    id serial primary key,
    order_data date not null,
    count_product int
);
-- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
-- заполнение данными
insert into sales (order_data, count_product)
values
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

/*
2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
*/
select
    id as 'id заказа',
    case 
	when count_product < 100 then 'Маленький заказ'
        when count_product between 100 and 300 then 'Средний заказ'
        when count_product > 300 then 'Большой заказ'
	end as 'Тип заказа'
from sales;

/*
3. Создайте таблицу “orders”, заполните ее значениями
Выберите все заказы. В зависимости от поля order_status
выведите столбец full_order_status:
OPEN –«Order is in open state»; CLOSED -«Order is closed»;
CANCELLED -«Order is cancelled»
*/
drop table if exists orders;
-- создание таблицы
create table orders(
    id serial primary key,
    employee_id varchar(3) not null,
    amount decimal(5, 2),
    order_status varchar(9)
);
-- заполнение данными
insert into orders (employee_id, amount, order_status)
values
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');
select
    id as 'id заказа',
    case order_status
	when 'OPEN' then 'Order is in open state'
        when 'CLOSED' then 'Order is closed'
        when 'CANCELLED' then 'Order is cancelled'
	end as 'full_order_status'
from orders;

/*
4. Чем 0 отличается от NULL?
Поле с NULL указывает на отсутствие в поле значения.
Поле с 0 указывает, что значение поля равно 0.
*/
