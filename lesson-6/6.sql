--
-- 2.Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

--

SELECT
	CONCAT(f_f_name, ' ', f_s_name, ' and ', t_f_name, ' ', t_s_name) as bff
FROM(
	SELECT 
		from_user_id,
		to_user_id,
		count(*) as msg_cnt,
		(SELECT firstname FROM `profile` WHERE user_id = from_user_id) as f_f_name,
		(SELECT lastname FROM `profile` WHERE user_id = from_user_id) as f_s_name,
		(SELECT firstname FROM `profile` WHERE user_id = to_user_id) as t_f_name,
		(SELECT lastname FROM `profile` WHERE user_id = to_user_id) as t_s_name
	FROM 
		message
	WHERE to_user_id = 50
	GROUP BY from_user_id
	ORDER BY msg_cnt DESC
	LIMIT 1) as result
	
--
-- 3.Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
--

-- Не очень мне нравится такой вариант, но пока ничего умнее не придумал
SELECT 
	SUM(cnt_likes) as `summa`
FROM (
	SELECT 
		* 
	FROM(
		SELECT
			-- user_id,
			(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM `profile` WHERE `profile`.user_id = `like`.user_id) as bd,
			COUNT(*) AS cnt_likes
		FROM 
			`like`
		GROUP BY user_id
		ORDER BY bd
		) AS prep_table
	WHERE bd != 0
	LIMIT 10
) as result

-- Есть еще вот такой вариант. Тут правильнее считается сортировка по возрату и, кажется, бстрее должно работать

SELECT 
	SUM(like_cnt) as sum
FROM(
SELECT
	-- user_id,
    COUNT(*) as like_cnt,
    (SELECT birthday FROM `profile` WHERE `profile`.user_id = `like`.user_id) as bd
FROM `like`
GROUP BY user_id
HAVING TIMESTAMPDIFF(YEAR, bd, NOW()) != 0
ORDER BY bd DESC
LIMIT 10) as result

--
-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
--

SELECT
	gender,
    SUM(cnt_likes) as likes
FROM(
	SELECT 
		user_id,
		(SELECT gender FROM `profile` WHERE `profile`.user_id = `like`.user_id) as gender,
		COUNT(*) as cnt_likes
	FROM `like`
	GROUP BY user_id
	ORDER BY user_id
) as counter
GROUP BY gender

--
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
--

SELECT
	user_id,
    user_name,
    -- (SELECT )
    com_cnt + adm_cnt + like_cnt + post_cnt + media_cnt + msg_cnt + friend_cnt AS points
FROM(
SELECT
	user_id,
    CONCAT(firstname, ' ', lastname) AS user_name,
    -- Колличество групп, в которых состоит (коэффициент - 0.5)
    IFNULL((SELECT COUNT(*) FROM user_community WHERE `user_community`.user_id = `profile`.user_id GROUP BY `user_community`.user_id), 0.0) * 0.5 AS com_cnt,
    -- Колличество групп, в которой он админ (коэффициент - 2 (ну он молодец же, правда))
    IFNULL((SELECT COUNT(*) FROM community WHERE `community`.admin_id = `profile`.user_id GROUP BY admin_id), 0.0) AS adm_cnt,
    -- Колличество лайков, который поставил пользователь (коэффициент - 0.3 (ну комментарий явно лучше, чем лайк))
    IFNULL((SELECT COUNT(*) FROM `like` WHERE `like`.user_id = `profile`.user_id GROUP BY `like`.user_id), 0.0) * 0.3 as like_cnt,
    -- Колличество постов, которые сделал персонаж в группе (коэффициент - 1 (молодец, но можно было бы и группу собрать))
    IFNULL((SELECT COUNT(*) FROM post WHERE post.user_id = `profile`.user_id GROUP BY post.user_id), 0.0) as post_cnt,
    -- Бонусы за медиа, которые есть у пользователя
    -- видео - 0.2, остальное - 0.1
	IFNULL((SELECT 
		cnt 
	FROM 
		(SELECT 
			user_id,
			SUM(ball_counter) as cnt
		FROM(
			SELECT 
				media_type_id, 
				user_id, 
				CASE (SELECT media_type.`name` FROM media_type WHERE id = media_type_id)
					WHEN 'video' THEN 0.2
					ELSE 0.1
				END AS ball_counter
			FROM vk.media
			)AS cnt_table
	GROUP BY user_id) AS smth
	WHERE `smth`.user_id = `profile`.user_id), 0.0) as media_cnt,
	-- Колличество сообщений - 0.1 (ну обычно их много, зачем дорого-богато ценить)
    IFNULL((SELECT COUNT(*) AS cnt FROM message WHERE from_user_id = user_id OR to_user_id = user_id), 0.0) * 0.1 as msg_cnt,
    -- Колличество друзей - 0.3
    (SELECT COUNT(IF(from_user_id = user_id, to_user_id, from_user_id)) FROM friend_request WHERE (from_user_id = user_id OR to_user_id = user_id) AND `status` = 1) * 0.3 AS friend_cnt
FROM
	`profile`) as input
ORDER BY points DESC
LIMIT 10