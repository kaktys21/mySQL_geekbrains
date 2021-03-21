/*
Практическое задание теме «Агрегация данных»
*/

--
--1. Подсчитайте средний возраст пользователей в таблице users.
-- 

SELECT sum_age / people FROM(
	SELECT
		COUNT(*) AS people,
		SUM(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS sum_age
	FROM 
		shop4.users AS pre
) AS res;

--
/*
2.Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
--

SELECT 
	this_year,
    COUNT(this_year) as birthdays
FROM (
	SELECT
		`name`,
		birthday_at,
		DAYNAME(CONCAT(YEAR(NOW()), SUBSTRING(birthday_at, 5))) as this_year
	FROM
		shop4.users AS pre
) as result
GROUP BY this_year
ORDER BY birthdays DESC;

--
--3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
--
SELECT ROUND(exp(sum(ln(id))), 0) AS result FROM shop4.users 
WHERE id <= 5;
