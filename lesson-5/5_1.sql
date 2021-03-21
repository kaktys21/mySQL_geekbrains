--
/*
Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
*/
--

--1.Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE shop.users SET
	created_at = NOW(),
	updated_at = NOW()
WHERE id > 0;

--
/*2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были 
заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/
--

ALTER TABLE `shop4`.`users` 
CHANGE COLUMN `created_at` `created_at` DATETIME NULL DEFAULT NOW() ,
CHANGE COLUMN `updated_at` `updated_at` DATETIME NULL DEFAULT NULL ;

--
/*3В таблице складских запасов storehouses_products в поле value могут встречаться самые 
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо 
отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех 
*/
--

SELECT `value` FROM (
	SELECT `value`, (`value` <= 0) as `sign` FROM shop4.storehouses_products
	ORDER BY `sign`, `value`
) as smth

--
/* 4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы 
в виде списка английских названий (may, august)
*/
--

--Если у нас отдельный стобец с месяцем
SELECT * FROM shop4.users
WHERE `birthday` IN ('may', 'august');

--Если нет
SELECT * FROM shop4.users
WHERE SUBSTRING(birthday_at, 6, 2) IN ('05', '08');

--
/*
(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.
*/
--

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);
