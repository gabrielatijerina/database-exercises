USE albums_db;

SHOW tables;

DESCRIBE albums;

SELECT *
FROM albums WHERE artist = 'Pink Floyd';

SELECT release_date as "Sgt Pepper\'s Release Date"
FROM albums 
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT genre as 'Genre for Nevermind'
FROM albums 
WHERE name = 'Nevermind';

SELECT artist,
	name as 'Albums Released in 1990s'
FROM albums 
WHERE release_date BETWEEN 1990 AND 1999;

SELECT name as 'Album Sales Less Than 20 million'
from albums
WHERE sales < 20;

SELECT * 
FROM albums 
WHERE genre = 'Rock';

SELECT * 
FROM albums 
WHERE genre like '%rock%';

