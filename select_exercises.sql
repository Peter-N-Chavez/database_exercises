USE albums_db;
SELECT *
FROM albums;
SELECT DISTINCT artist
FROM albums;
SHOW CREATE TABLE albums;
-- 3.
-- a) 31
-- b) 23
-- c) 'albums', 'CREATE TABLE `albums` (\n  `id` int unsigned NOT NULL AUTO_INCREMENT,\n  `artist` varchar(240) DEFAULT NULL,\n  `name` varchar(240) NOT NULL,\n  `release_date` int DEFAULT NULL,\n  `sales` float DEFAULT NULL,\n  `genre` varchar(240) DEFAULT NULL,\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1'
-- d) 1967 (Beatles/Sgt. Pepper's Lonely Hearts Club Band), 2011 (Adele/21)

SELECT DISTINCT name
FROM albums
WHERE artist = "Pink Floyd";

SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT genre
FROM albums
WHERE name = "Nevermind";

SELECT name
FROM albums
WHERE release_date BETWEEN 1989 AND 2000;

SELECT name
FROM albums
WHERE sales < 20000000;

SELECT name
FROM albums
WHERE genre = "Rock";
-- Query does not include other sub-genres of rock because the query did not search for any genre with the word "Rock" in it,
-- it searched specifically for "Rock" only.alter

