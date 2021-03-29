--
-- 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
--

SELECT * FROM shop4.users
WHERE EXISTS (SELECT * FROM shop4.orders WHERE orders.user_id = users.id);

--
-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
--

SELECT 
	id,
	`name`,
    `description`,
    price,
    (SELECT `name` FROM shop4.catalogs WHERE catalogs.id = products.catalog_id) as catalogue,
    created_at,
    updated_at
FROM 
	shop4.products;

--
/* 3.(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/
--

SELECT 
	id,
    (SELECT `name` FROM cities WHERE label = `from`) as `from`,
    (SELECT `name` FROM cities WHERE label = `to`) as `to`
FROM flights;
	