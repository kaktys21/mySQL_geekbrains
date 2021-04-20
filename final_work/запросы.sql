-- Создание таблицы покупок

CREATE TABLE `wildberries`.`buying_act` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buyer` INT NOT NULL,
  `seller` INT NOT NULL,
  `product` INT NOT NULL,
  `cnt` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ba_buyer_idx` (`buyer` ASC) VISIBLE,
  INDEX `fk_ba_shop_idx` (`seller` ASC) VISIBLE,
  INDEX `fk_ba_product_idx` (`product` ASC) VISIBLE,
  CONSTRAINT `fk_ba_buyer`
    FOREIGN KEY (`buyer`)
    REFERENCES `wildberries`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ba_shop`
    FOREIGN KEY (`seller`)
    REFERENCES `wildberries`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ba_product`
    FOREIGN KEY (`product`)
    REFERENCES `wildberries`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Триггер на AFTER INSERT

DROP TRIGGER IF EXISTS `wildberries`.`buying_act_AFTER_INSERT`;

DELIMITER $$
USE `wildberries`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `buying_act_AFTER_INSERT` AFTER INSERT ON `buying_act` FOR EACH ROW BEGIN
	UPDATE prod_page
    SET `left` = `left` - NEW.cnt
    WHERE prod_page.product_id = NEW.produc;
END$$
DELIMITER ;

-- Добавили данные в таблицу

INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('1', '1', '1', '5');
INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('3', '2', '4', '10');
INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('3', '1', '16', '100');
INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('6', '1', '14', '7');
INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('25', '3', '4', '5');
INSERT INTO `wildberries`.`buying_act` (`buyer`, `seller`, `product`, `cnt`) VALUES ('3', '3', '5', '77');

-- Представления

-- 1. Представление прибыли магазина, ранжированное по прибыли

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `comp_profit` AS
    SELECT 
        `all_prof`.`id` AS `id`,
        `all_prof`.`company` AS `company`,
        SUM(`all_prof`.`profit`) AS `profit`
    FROM
        (SELECT 
            (SELECT 
                        `shop`.`name`
                    FROM
                        `shop`
                    WHERE
                        (`shop`.`id` = `buying_act`.`seller`)) AS `company`,
                `buying_act`.`cnt` AS `cnt`,
                (`pp`.`cost` * `buying_act`.`cnt`) AS `profit`,
                `buying_act`.`seller` AS `id`
        FROM
            (`buying_act`
        JOIN `prod_page` `pp` ON ((`pp`.`product_id` = `buying_act`.`product`)))) `all_prof`
    GROUP BY `all_prof`.`company`
    ORDER BY `profit`;

-- 2. Подсчет колчества позиций на складе у магазина

USE `wildberries`;
CREATE  OR REPLACE VIEW `stor_cnt` AS
SELECT 
pp.id,
pp.name,
pp.storage,
SUM(`left`) as `left`
FROM
prod_page JOIN (
SELECT shop.id, name, catalogue, (SELECT `name` FROM `storage` WHERE `storage`.id = `storage`) `storage`, prod_id FROM wildberries.shop 
JOIN catalogue ON catalogue.id = catalogue) as pp ON product_id = prod_id
GROUP BY pp.name
ORDER BY id;;


-- Примеры запросов к БД

--
-- 1. Пример составления каталога для магазина по id
--

SELECT
	pp.product_id,
    pp.page_name,
    pp.img,
    pp.spec,
    (SELECT `type` FROM `types` WHERE `types`.id = pp.`type`) as `type`,
    (SELECT `season` FROM `season` WHERE `season`.id = pp.`season`) as `season`,
    (SELECT `color` FROM `color` WHERE `color`.id = pp.`color`) as `color`,
    (SELECT `size` FROM `size` WHERE `size`.id = pp.`size`) as `size`,
    pp.cost
FROM 
	catalogue RIGHT JOIN prod_page pp ON product_id = prod_id
WHERE id = 1
ORDER BY product_id;

--
-- 2. Выборка зимних товаров
--

SELECT
	product_id,
    page_name,
    (SELECT season FROM season WHERE prod_page.season = season.id) as season,
    cost
FROM wildberries.prod_page JOIN products p ON product_id = id
WHERE season IN (2, 6, 10);