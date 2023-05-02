use dz_4;

/*
1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол),
которые не старше 20 лет.
*/
create or replace view users_young as
select
	concat(u.firstname, ' ', u.lastname) as 'user',
	p.hometown,
	case 
		when p.gender = 'f' then 'Женщина'
		when p.gender = 'm' then 'Мужчина'
	end as gender
from users u, profiles p
where u.id = p.user_id and timestampdiff(day, p.birthday, now())< 20*365;
select * from users_young;

/*
2. Найдите кол-во, отправленных сообщений каждым пользователем
и выведите ранжированный список пользователей, указав имя и фамилию пользователя,
количество отправленных сообщений и место в рейтинге
(первое место у пользователя с максимальным количеством сообщений). (используйте DENSE_RANK)
*/
select 
	concat(firstname, ' ', lastname) as 'user',
    count(from_user_id) as 'total_msg',
    dense_rank() over (order by count(from_user_id) desc) as 'Ранг'
from users u
join messages m on u.id = m.from_user_id
group by u.id;

/*
3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
и найдите разницу дат отправления между соседними сообщениями, получившегося списка.
(используйте LEAD или LAG)
*/
select *,
timestampdiff(second, created_at, lag(created_at) over (order by created_at)) as diff_lag,
timestampdiff(second, created_at, lead(created_at) over (order by created_at)) as diff_lead
from messages;
