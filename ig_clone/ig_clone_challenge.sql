/* To view the data in the tables */
-- select * from comments;
-- select * from likes;
-- select * from follows;
-- select * from photo_tags;
-- select * from photos;
-- select * from tags;
-- select * from users;

/*sql_challenges*/

/*We  want to reward our users who have been around the longest.
Find the 5 oldest users. */
SELECT * FROM users 
ORDER BY created_at
LIMIT 5;

/*What day of the week do most users register on.
We need to figure out when to schedule an ad campaign*/
SELECT date_format(created_at,'%W') AS day ,COUNT(*) AS total 
FROM users
GROUP BY day
ORDER BY total DESC 
LIMIT 2;

/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo */

SELECT username
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE photos.id IS NULL;

/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON?!!*/
SELECT username,count(likes.user_id) AS total_likes
FROM users 
JOIN photos ON photos.user_id = users.id 
JOIN likes ON likes.photo_id = photos.id 
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/
SELECT ROUND((SELECT COUNT(*) FROM photos)/ (SELECT COUNT(*) FROM users),2);

/*user ranking by postings higher to lower*/
SELECT users.username, count(photos.image_url) as total_postings
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.username
ORDER BY total_postings DESC;

/*Total Posts by users (longer versionof SELECT COUNT(*) FROM photos) */
SELECT SUM(total_postings) 
FROM (SELECT users.username, count(photos.image_url) as total_postings
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.username) AS user_posts;

/*total number of users who have posted at least one time */
SELECT COUNT(distinct(username)) FROM (SELECT users.username , count(photos.image_url) as total_posts_per_user
FROM users
JOIN photos ON photos.user_id = users.id
GROUP BY users.username 
ORDER BY total_posts_per_user) AS posts;
-- OR 
SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN  photos ON users.id = photos.user_id;
/*A brand wants to know which hashtags to use in a post.
What are the tops 5 most commonly used hashtags? */
SELECT tag_name,count(*) AS total
FROM tags
GROUP BY tag_name
ORDER BY total DESC 
LIMIT 5;

/*We have a small problem with bots on our sites.
Find users who have liked every single photo on the site*/
SELECT  users.id,username ,count(users.id) AS total_likes_by_user
FROM  users 
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user  =
(SELECT count(*)
  FROM photos);
  
  /*We also have a problem with celebrities
  Find users who have never commented on a photo*/
 SELECT count(*)
 FROM users
 LEFT JOIN comments ON comments.user_id = users.id
 WHERE comments.comment_text IS NULL;
 
/*Mega challenges
Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented on a photo or have commented on every photo */
SELECT 
tableA.total_A AS 'Number of User who never commented',
(tableA.total_A /  (SELECT COUNT(*) FROM users )) * 100 AS '%' ,
tableB.total_B AS 'Number of Users who likes every photos',
(tableB.total_B/(SELECT COUNT(*) FROM users))*100 AS '%'
FROM 
	(	SELECT COUNT(*) AS total_A FROM (SELECT username, comment_text
										FROM users
                                        LEFT JOIN comments ON comments.user_id = users.id
                                        WHERE comment_text IS NULL) AS total_number_of_users_without_comments) 
		 AS tableA
         JOIN 
         (
			SELECT COUNT(*) AS total_B FROM 
				(SELECT users.id, username , COUNT(users.id) AS total_likes_by_user
                FROM users
                LEFT JOIN likes ON users.id = likes.user_id
                GROUP BY users.id
                HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos)) AS total_number_users_likes_every_photo)
			 AS tableB;
                
                
	/*Find users who have ever commented on a photo*/
    SELECT username,comment_text
    FROM users
    LEFT JOIN comments ON comments.user_id = users.id
    WHERE comment_text IS NOT NULL;
    
    -- Find their aggregate number
    SELECT COUNT(*) FROM
    (SELECT username,comment_text
    FROM users
    LEFT JOIN comments ON comments.user_id = users.id
    WHERE comment_text IS NOT NULL) AS total_number_users_without_comments;
    

    /*Are we overrun with bots and celebrity accounts?
    Find the percentage of our users who have either never commented on a photo or have commented on photos before */
SELECT tableA.total_A AS 'Number of Users who never commented',
				(tableA.total_A/ (SELECT COUNT(*) FROM users))*100 AS '%',
                tableB.total_B AS 'Number of Users who commented on photos',
                (tableB.total_B / (SELECT COUNT(*) FROM users))* 100 AS '%'
FROM 
		(
			SELECT COUNT(*) AS total_A FROM 
					(SELECT username, comment_text
						FROM users
                        LEFT JOIN comments ON comments.user_id = users.id
                        WHERE comment_text IS NULL) AS total_number_users_without_comments)
					AS tableA
                    JOIN
                    (
						SELECT COUNT(*) AS total_B FROM 
							(SELECT username, comment_text
									FROM users
                                    LEFT JOIN comments ON comments.user_id = users.id
                                    WHERE comment_text IS NOT NULL) AS total_number_users_with_comments)
						AS tableB;
   
                














 