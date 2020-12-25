USE albums_db;

SELECT database();

SHOW tables;

DESCRIBE albums;

SELECT *
FROM albums 
LIMIT 5;

SELECT DISTINCT genre
from albums;

SELECT name as 'albums by Pink Floyd'
FROM albums WHERE artist = 'Pink Floyd';

SELECT *
FROM albums 
WHERE name = 'sgt. pepper\'s lonely hearts club band';

SELECT genre AS 'Genre for Nevermind'
FROM albums
WHERE name = 'nevermind';

SELECT artist, 
	name AS 'Albums Released in the 1990s'
FROM albums
WHERE release_date like '199%';

SELECT * 
FROM albums 
WHERE sales < 20;

SELECT *
FROM albums 
WHERE genre = 'rock';

SELECT *
FROM albums 
WHERE genre like '%rock%';
