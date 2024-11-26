-- Trois utilisateurs les + actifs en nombre de like sur leurs posts

SELECT
    u.username,
    COUNT(l.post_id) AS total_likes,
    ROW_NUMBER() OVER (ORDER BY COUNT(l.post_id) desc)
    FROM posts p
    INNER JOIN likes l ON l.post_id = p.post_id
    INNER JOIN users u ON p.user_id = u.user_id
	GROUP BY u.user_id
	ORDER BY total_likes desc
	LIMIT 4

