USE albums_db;

SELECT * 
FROM albums;

SELECT * 
FROM albums 
WHERE artist = 'Pink Floyd'; 

SELECT release_date 
FROM albums 
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; 

SELECT genre , name
FROM albums 
WHERE name = 'Nevermind';

SELECT *
FROM albums 
WHERE release_date BETWEEN 1990 AND 1999;

SELECT * 
FROM albums 
WHERE sales < 20;

SELECT *
FROM albums
WHERE genre = 'rock';
# progressive rock or hard rock don't show up because they're not in quotes 