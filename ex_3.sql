Calculez le nombre total de posts et de commentaires créés par chaque utilisateur. Affichez :

user_id : l'ID de l'utilisateur (peut être NULL pour les totaux globaux)
content_type : 'Post', 'Comment' ou NULL pour les totaux globaux
total_count : le nombre total de contenus créés pour ce groupe.

WITH total_posts AS (
	SELECT
    u.user_id,
    COUNT(p.post_id) AS total_count
	FROM users u
    INNER JOIN posts p ON u.user_id = p.user_id
	GROUP BY u.user_id 
	ORDER BY u.user_id
),

total_comments AS (
	SELECT
    u.user_id,
    COUNT(c.comment_id) AS total_count
	FROM users u
    INNER JOIN comments c ON u.user_id = c.user_id
	GROUP BY u.user_id 
	ORDER BY u.user_id
)

SELECT
    u.user_id,
	tc.total_count AS total_comments,
	tp.total_count AS total_posts,
    (tc.total_count + tp.total_count) AS total_count
	
	FROM users u
    INNER JOIN posts p ON u.user_id = p.user_id
	INNER JOIN comments c ON u.user_id = c.user_id
	LEFT JOIN total_posts tp ON tp.user_id = u.user_id
	LEFT JOIN total_comments tc ON tc.user_id = u.user_id
	GROUP BY ROLLUP(u.user_id,  tc.total_count, tp.total_count)
	ORDER BY u.user_id