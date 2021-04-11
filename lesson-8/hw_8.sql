-- Практическое задание по теме “Транзакции, переменные, представления”

-- 
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции
-- 

START TRANSACTION;
INSERT INTO sample.users 
SELECT * FROM shop4.users WHERE shop4.users.id = 1;
COMMIT

--
-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы 
-- products и соответствующее название каталога name из таблицы catalogs.
--

CREATE VIEW `prod` AS 
SELECT 
`name`, 
(SELECT catalogs.`name` FROM catalogs WHERE catalogs.`id` = catalog_id) as `type` 
FROM shop4.products;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `prod` AS
    SELECT 
        `products`.`name` AS `name`,
        (SELECT 
                `catalogs`.`name`
            FROM
                `catalogs`
            WHERE
                (`catalogs`.`id` = `products`.`catalog_id`)) AS `type`
    FROM
        `products`
		

-- 
-- 3.по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
-- календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте 
-- запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата 
-- присутствует в исходном таблице и 0, если она отсутствует.
--


SELECT 
	time_period.selected_date as `day`,
    (SELECT EXISTS(SELECT * FROM dates WHERE created_at = `day`)) as flag
FROM
(SELECT v.* FROM
	(SELECT ADDDATE('2018-08-01', t1.i * 10 + t0.i) as selected_date FROM
	(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) as t0,
	(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) as t1) as v
	WHERE selected_date BETWEEN '2018-08-01' and '2018-08-31'
	ORDER BY selected_date) as time_period
	
--
-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
--

DELETE FROM dates
WHERE created_at NOT IN (
SELECT * FROM (
	SELECT created_at
	FROM dates 
    ORDER BY created_at DESC 
	LIMIT 5) as foo) ORDER BY created_at DESC
	
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

--
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 
-- функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".
--

CREATE DEFINER=`root`@`localhost` PROCEDURE `hello`()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END

--
-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
--

CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END

