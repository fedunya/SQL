create schema dz_1;
use dz_1;
/* Задача 1
Создайте таблицу с мобильными телефонами, используя графический интерфейс.
Заполните БД данными (поля и наполнение см. в презентации)
*/
-- создание таблиц
create table mobile_phones(
	id int auto_increment not null primary key,
    product_name varchar(45) not null,
    manufacturer varchar(45) not null,
    product_count int not null,
    price bigint not null
);
-- наполнение нужными данными
insert into mobile_phones(product_name, manufacturer, product_count, price)
values
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

/* Задача 2
Выведите название, производителя и цену для товаров, количество которых превышает 2
*/
-- выборка данных
select product_name, manufacturer, price
from mobile_phones
where product_count > 2;

/* Задача 3
Выведите весь ассортимент товаров марки “Samsung”
*/
-- выборка данных
select id, product_name, manufacturer, product_count, price
from mobile_phones
where manufacturer = 'Samsung';

/* Задача 4
С помощью регулярных выражений найти:
*/
-- товары, в которых есть упоминание "iPhone"
select id, product_name, manufacturer, product_count, price
from mobile_phones
where product_name like '%iPhone%';

-- товары, в которых есть упоминание "Samsung"
select id, product_name, manufacturer, product_count, price
from mobile_phones
where manufacturer like '%Samsung%';

-- товары, в которых есть ЦИФРЫ
select id, product_name, manufacturer, product_count, price
from mobile_phones
where product_name rlike '[0-9]';

-- товары, в которых есть ЦИФРА "8"
select id, product_name, manufacturer, product_count, price
from mobile_phones
where product_name rlike '8';
