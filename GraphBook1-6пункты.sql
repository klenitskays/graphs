
/*
В графовой базе данных хранится информация о книгах, библиотеках и районах. Каждая книга может быть отдана другому. Книги основное время находятся в районах, и могут находиться в библиотеках и сканироваться. 
Необходимо разработать графовую базу данных и написать запросы для решения следующих задач:
1.	Найти в какой библиотеке прописана книга.
2.	Найти книгу, которую отдали другому
3.	Найти место нахождение книга
4.	Найти библиотеку, где проходит сканирование книги

Библиотека
--Узлы: 
--Книга (Book)
--Библиотека (Library)
--Район (Region)

--Ребра:

--Отдали ли книгу (GaveFrom) 
--Прописка книги  (RegistrationIn)
--Нахождение книги (LocatedIn)
--Ксерокопия книги (Photocoped)

*/


Use master;
DROP DATABASE IF EXISTS GrafOfInfection;
CREATE DATABASE GrafOfInfection;


USE GrafOfInfection;



CREATE TABLE Book 
(
 id INT NOT NULL PRIMARY KEY,
 name NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE Region
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
street NVARCHAR(30) NOT NULL
) AS NODE;


CREATE TABLE Library
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL,
region NVARCHAR(30) NOT NULL
) AS NODE;


CREATE TABLE GaveFrom AS EDGE;
CREATE TABLE RegistrationIn AS EDGE;
CREATE TABLE LocatedIn AS EDGE;
CREATE TABLE Photocoped (photocoped INT) AS EDGE;


ALTER TABLE GaveFrom
ADD CONSTRAINT EC_GaveFrom CONNECTION (Book TO Book);

ALTER TABLE RegistrationIn
ADD CONSTRAINT EC_RegistrationIn CONNECTION (Book TO Region);
ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Library TO Region);
ALTER TABLE Photocoped
ADD CONSTRAINT EC_Photocoped CONNECTION (Book TO Library);
GO


INSERT INTO Book (id, name)
 
VALUES (1, N'Мастер и Маргарита'), 
       (2, N'Преступление и наказание'),
       (3, N'Война и мир'),
       (4, N'Анна Каренина'),
       (5, N'1984'),
	   (6, N'Горе от ума'), 
       (7, N'Герой нашего времени'),
       (8, N'Евгений Онегин'),
       (9, N'Маленький принц'),
       (10, N'Мертвые души');
GO
SELECT *
FROM Book;


INSERT INTO Region (id, name, street)
VALUES (1, N'Москва', N'Тверская улица'),
  (2, N'Санкт-Петербург', N'Невский проспект'),
  (3, N'Екатеринбург', N'Ленина улица'),
  (4, N'Новосибирск', N'Красный проспект'),
  (5, N'Казань', N'Кремлевская улица'),
  (6, N'Ростов-на-Дону', N'Большая Садовая улица'),
  (7, N'Самара', N'Куйбышева улица'),
  (8, N'Нижний Новгород', N'Горького улица'),
  (9, N'Волгоград', N'Площадь Ленина'),
  (10, N'Омск', N'Ленинградская улица');
GO
SELECT *
FROM Region;



INSERT INTO Library (id, name, region)
VALUES
 (1, N'Главная библиотека им. Ленина', N'Москва'),
  (2, N'Центральная библиотека им. Пушкина', N'Санкт-Петербург'),
  (3, N'Городская библиотека им. Горького', N'Нижний Новгород'),
  (4, N'Детская библиотека № 1', N'Екатеринбург'),
  (5, N'Библиотека им. Лермонтова', N'Самара'),
  (6, N'Научная библиотека им. Чайковского', N'Казань'),
  (7, N'Библиотека им. Чехова', N'Ростов-на-Дону'),
  (8, N'Краевая библиотека им. Пушкина', N'Новосибирск'),
  (9, N'Библиотека им. Маяковского', N'Волгоград'),
  (10, N'Городская библиотека № 3', N'Омск');
GO
SELECT *
FROM Library;



INSERT INTO GaveFrom ($from_id, $to_id)
VALUES((SELECT $node_id FROM Book WHERE id = 1),
 (SELECT $node_id FROM Book WHERE id = 2)),
 ((SELECT $node_id FROM Book WHERE id = 1),
 (SELECT $node_id FROM Book WHERE id = 5)),
 ((SELECT $node_id FROM Book WHERE id = 2),
 (SELECT $node_id FROM Book WHERE id = 3)),
 ((SELECT $node_id FROM Book WHERE id = 3),
 (SELECT $node_id FROM Book WHERE id = 1)),
 ((SELECT $node_id FROM Book WHERE id = 3),
 (SELECT $node_id FROM Book WHERE id = 6)),
 ((SELECT $node_id FROM Book WHERE id = 4),
 (SELECT $node_id FROM Book WHERE id = 2)),
 ((SELECT $node_id FROM Book WHERE id = 5),
 (SELECT $node_id FROM Book WHERE id = 4)),
 ((SELECT $node_id FROM Book WHERE id = 6),
 (SELECT $node_id FROM Book WHERE id = 7)),
 ((SELECT $node_id FROM Book WHERE id = 6),
 (SELECT $node_id FROM Book WHERE id = 8)),
 ((SELECT $node_id FROM Book WHERE id = 8),
 (SELECT $node_id FROM Book WHERE id = 3)),
 ((SELECT $node_id FROM Book WHERE id = 6), 
 (SELECT $node_id FROM Book WHERE id = 10)),
 ((SELECT $node_id FROM Book WHERE id = 7),
 (SELECT $node_id FROM Book WHERE id = 6)),
 ((SELECT $node_id FROM Book WHERE id = 5),
 (SELECT $node_id FROM Book WHERE id = 1)),
 ((SELECT $node_id FROM Book WHERE id = 7),
  (SELECT $node_id FROM Book WHERE id = 10)),
  ((SELECT $node_id FROM Book WHERE id = 10),
  (SELECT $node_id FROM Book WHERE id = 9)),
  ((SELECT $node_id FROM Book WHERE id = 9),
  (SELECT $node_id FROM Book WHERE id = 8));


GO
SELECT *
FROM GaveFrom;




INSERT INTO RegistrationIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Book WHERE ID = 1),
 (SELECT $node_id FROM Region WHERE ID = 1)),
 ((SELECT $node_id FROM Book WHERE ID = 5),
 (SELECT $node_id FROM Region WHERE ID = 1)),
 ((SELECT $node_id FROM Book WHERE ID = 8),
 (SELECT $node_id FROM Region WHERE ID = 1)),
 ((SELECT $node_id FROM Book WHERE ID = 2),
 (SELECT $node_id FROM Region WHERE ID = 2)),
 ((SELECT $node_id FROM Book WHERE ID = 3),
 (SELECT $node_id FROM Region WHERE ID = 3)),
 ((SELECT $node_id FROM Book WHERE ID = 4),
 (SELECT $node_id FROM Region WHERE ID = 3)),
 ((SELECT $node_id FROM Book WHERE ID = 6),
 (SELECT $node_id FROM Region WHERE ID = 4)),
 ((SELECT $node_id FROM Book WHERE ID = 7),
 (SELECT $node_id FROM Region WHERE ID = 4)),
 ((SELECT $node_id FROM Book WHERE ID = 6),
 (SELECT $node_id FROM Region WHERE ID = 5)),
 ((SELECT $node_id FROM Book WHERE ID = 8),
 (SELECT $node_id FROM Region WHERE ID = 9)),
  ((SELECT $node_id FROM Book WHERE ID = 10),
  (SELECT $node_id FROM Region WHERE ID = 6)),
  ((SELECT $node_id FROM Book WHERE ID = 5), 
 (SELECT $node_id FROM Region WHERE ID = 9)),
  ((SELECT $node_id FROM Book WHERE ID = 8),
   (SELECT $node_id FROM Region WHERE ID = 7));
       
   
INSERT INTO Photocoped ($from_id, $to_id, Photocoped)
VALUES ((SELECT $node_id FROM Book WHERE ID = 1),
 (SELECT $node_id FROM Library WHERE ID = 1), 10),
 ((SELECT $node_id FROM Book WHERE ID = 8),
 (SELECT $node_id FROM Library WHERE ID = 1), 9),
 ((SELECT $node_id FROM Book WHERE ID = 2),
 (SELECT $node_id FROM Library WHERE ID = 2), 8),
 ((SELECT $node_id FROM Book WHERE ID = 3),
 (SELECT $node_id FROM Library WHERE ID = 3), 9),
 ((SELECT $node_id FROM Book WHERE ID = 4),
 (SELECT $node_id FROM Library WHERE ID = 3), 7),
 ((SELECT $node_id FROM Book WHERE ID = 5),
 (SELECT $node_id FROM Library WHERE ID = 6), 9),
 ((SELECT $node_id FROM Book WHERE ID = 6),
 (SELECT $node_id FROM Library WHERE ID = 4), 10),
 ((SELECT $node_id FROM Book WHERE ID = 8),
 (SELECT $node_id FROM Library WHERE ID = 4), 9),
 ((SELECT $node_id FROM Book WHERE ID = 1),
 (SELECT $node_id FROM Library WHERE ID = 7), 7),
 ((SELECT $node_id FROM Book WHERE ID = 8),
 (SELECT $node_id FROM Library WHERE ID = 9), 2),
 ((SELECT $node_id FROM Book WHERE ID = 2),
 (SELECT $node_id FROM Library WHERE ID = 5), 8),
 ((SELECT $node_id FROM Book WHERE ID = 9),
 (SELECT $node_id FROM Library WHERE ID = 6), 3),
 ((SELECT $node_id FROM Book WHERE ID = 7),
 (SELECT $node_id FROM Library WHERE ID = 8), 7),
 ((SELECT $node_id FROM Book WHERE ID = 10),
 (SELECT $node_id FROM Library WHERE ID = 10), 9);


 
 SELECT Book1.name
 , Book2.name AS [book name]
FROM Book AS Book1
 , GaveFrom
 , Book AS Book2
WHERE MATCH(Book1-(GaveFrom)->Book2)
 AND Book1.name = N'Отцы и дети';

 SELECT Book1.name
 , Book2.name AS[book name]
FROM Book AS Book1
 INNER JOIN GaveFrom ON Book1.$node_id = GaveFrom.$from_id
 INNER JOIN Book AS Book2 ON Book2.$node_id =
GaveFrom.$to_id
WHERE Book1.name = N'Мастер и Маргарита'


--кому была отдана книга "Мастер и Маргарита"
SELECT Book1.name + N' отдал ' + Book2.name AS Level1
 , Book2.name + N' отдал ' + Book3.name AS Level2
FROM Book AS Book1
 , GaveFrom AS GaveFrom1
 , Book AS Book2
 , GaveFrom AS GaveFrom2
 , Book AS Book3
WHERE MATCH(Book1-(GaveFrom1)->Book2-(GaveFrom2)->Book3)
 AND Book1.name = N'Горе от ума';

 
SELECT Book2.name AS book
 , Library.name AS library
 , Photocoped.photocoped
FROM Book AS book1
 , Book AS book2
 , Photocoped
 , GaveFrom
 , Library
WHERE MATCH(book1-(GaveFrom)->book2-(Photocoped)->Library)
 AND book1.name = N'Война и мир';

 
 SELECT Book2.id AS book
 , Library.id AS library
 , Photocoped.photocoped
FROM Book AS book1
 , Book AS book2
 , Photocoped
 , GaveFrom
 , Library
WHERE MATCH(book1-(GaveFrom)->book2-(Photocoped)->Library)
 AND book1.id = 8;



 
 SELECT book1.name AS BookName
 , STRING_AGG(Book2.name, '->') WITHIN GROUP (GRAPH PATH)
AS BOOK
FROM Book AS Book1
 , GaveFrom FOR PATH AS Gave
 , Book FOR PATH AS Book2
WHERE MATCH(SHORTEST_PATH(Book1(-(Gave)->Book2)+))
 AND Book1.name = N'1984';

   SELECT Book1.name AS BookName
 , STRING_AGG(Library.name, '->') WITHIN GROUP (GRAPH PATH)
AS BOOK
FROM Book AS Book1
 , Photocoped FOR PATH AS photocoped
 , Library FOR PATH AS library
WHERE MATCH(SHORTEST_PATH(Book1(-(photocoped)->library)+))
 AND Book1.name = N'Война и мир';


