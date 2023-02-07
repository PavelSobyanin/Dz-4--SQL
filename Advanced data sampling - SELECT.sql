--1.количество исполнителей в каждом жанре;

SELECT g.name, count(artist) FROM artists_genres ag
LEFT JOIN genres g ON g.id = ag.genre
GROUP BY g.name;


--2.количество треков, вошедших в альбомы 2019-2020 годов;

SELECT a.name, count(t.name) FROM tracks t
LEFT JOIN albums a ON t.album = a.id
WHERE YEAR BETWEEN 2019 AND 2020
GROUP BY a.name;

--3.средняя продолжительность треков по каждому альбому;

SELECT a.name, avg(t.length) FROM tracks t 
LEFT JOIN albums a ON t.album = a.id
GROUP BY a.name;

--4.все исполнители, которые не выпустили альбомы в 2020 году;

SELECT a.name, year FROM artists a  
LEFT JOIN albums_artists aa  ON a.id = aa.artist
LEFT JOIN albums al ON aa.album = al.id 
WHERE year != 2020;

--5.названия сборников, в которых присутствует конкретный исполнитель (выберите сами);

SELECT DISTINCT c.name FROM collections c
LEFT JOIN collections_tracks ct ON ct.collection = c.id 
LEFT JOIN tracks t ON ct.track = t.id 
LEFT JOIN albums a ON t.id = a.id 
LEFT JOIN albums_artists aa ON a.id = aa.album
LEFT JOIN artists a2  ON a2.id = aa.artist
WHERE a2.name LIKE 'DDT';

-- 6. название альбомов, в которых присутствуют исполнители более 1 жанра;

SELECT ag.artist, count(ag.genre) FROM albums a 
LEFT JOIN albums_artists aa ON a.id = aa.album 
LEFT JOIN artists a2  ON a2.id = aa.id
LEFT JOIN artists_genres ag ON ag.id = a2.id 
GROUP BY ag.id;

SELECT a.name  FROM albums a
LEFT JOIN albums_artists aa ON a.id = a.id 
LEFT JOIN artists a2  ON a2.id = aa.artist  
LEFT JOIN artists_genres ag  ON ag.artist  = a2.id 
LEFT JOIN genres g ON g.id = ag.genre  
GROUP BY a.name 
HAVING count(DISTINCT g.name) > 1;

--7. наименование треков, которые не входят в сборники;
SELECT t.name, ct.track FROM tracks t  
LEFT JOIN collections_tracks ct  ON ct.track = t.id 
WHERE ct.collection IS NULL;

--8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
-- SELECT min(song_duration) FROM songs s

SELECT a2.name FROM tracks t 
LEFT JOIN albums a ON t.album = a.id 
LEFT JOIN albums_artists aa  ON a.id = aa.album 
LEFT JOIN artists a2  ON a2.id = aa.artist 
WHERE t.length = (SELECT min(length) FROM tracks t);

--9. название альбомов, содержащих наименьшее количество треков.
SELECT a.name, count(*) FROM albums a
LEFT JOIN tracks t ON t.album = a.id 
GROUP BY a.name
HAVING count(*) = 
				(SELECT count(*) FROM albums a
				LEFT JOIN tracks t2 ON t2.album = a.id 
				GROUP BY a.name
				ORDER BY count(*) 
				LIMIT 1);