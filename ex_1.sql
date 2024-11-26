-- Trouvez les utilisateurs qui ont commenté leurs propres posts.

SELECT
    u.username,
    p.post_id,
    c.comment_id
    FROM users u
    INNER JOIN posts p ON p.user_id = u.user_id
    INNER JOIN comments c ON c.post_id = p.post_id AND u.user_id = c.user_id

