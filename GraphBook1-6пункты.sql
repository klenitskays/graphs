
/*
� �������� ���� ������ �������� ���������� � ������, ����������� � �������. ������ ����� ����� ���� ������ �������. ����� �������� ����� ��������� � �������, � ����� ���������� � ����������� � �������������. 
���������� ����������� �������� ���� ������ � �������� ������� ��� ������� ��������� �����:
1.	����� � ����� ���������� ��������� �����.
2.	����� �����, ������� ������ �������
3.	����� ����� ���������� �����
4.	����� ����������, ��� �������� ������������ �����

����������
--����: 
--����� (Book)
--���������� (Library)
--����� (Region)

--�����:

--������ �� ����� (GaveFrom) 
--�������� �����  (RegistrationIn)
--���������� ����� (LocatedIn)
--���������� ����� (Photocoped)

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
 
VALUES (1, N'������ � ���������'), 
       (2, N'������������ � ���������'),
       (3, N'����� � ���'),
       (4, N'���� ��������'),
       (5, N'1984'),
	   (6, N'���� �� ���'), 
       (7, N'����� ������ �������'),
       (8, N'������� ������'),
       (9, N'��������� �����'),
       (10, N'������� ����');
GO
SELECT *
FROM Book;


INSERT INTO Region (id, name, street)
VALUES (1, N'������', N'�������� �����'),
  (2, N'�����-���������', N'������� ��������'),
  (3, N'������������', N'������ �����'),
  (4, N'�����������', N'������� ��������'),
  (5, N'������', N'����������� �����'),
  (6, N'������-��-����', N'������� ������� �����'),
  (7, N'������', N'��������� �����'),
  (8, N'������ ��������', N'�������� �����'),
  (9, N'���������', N'������� ������'),
  (10, N'����', N'������������� �����');
GO
SELECT *
FROM Region;



INSERT INTO Library (id, name, region)
VALUES
 (1, N'������� ���������� ��. ������', N'������'),
  (2, N'����������� ���������� ��. �������', N'�����-���������'),
  (3, N'��������� ���������� ��. ��������', N'������ ��������'),
  (4, N'������� ���������� � 1', N'������������'),
  (5, N'���������� ��. ����������', N'������'),
  (6, N'������� ���������� ��. �����������', N'������'),
  (7, N'���������� ��. ������', N'������-��-����'),
  (8, N'������� ���������� ��. �������', N'�����������'),
  (9, N'���������� ��. �����������', N'���������'),
  (10, N'��������� ���������� � 3', N'����');
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
 AND Book1.name = N'���� � ����';

 SELECT Book1.name
 , Book2.name AS[book name]
FROM Book AS Book1
 INNER JOIN GaveFrom ON Book1.$node_id = GaveFrom.$from_id
 INNER JOIN Book AS Book2 ON Book2.$node_id =
GaveFrom.$to_id
WHERE Book1.name = N'������ � ���������'


--���� ���� ������ ����� "������ � ���������"
SELECT Book1.name + N' ����� ' + Book2.name AS Level1
 , Book2.name + N' ����� ' + Book3.name AS Level2
FROM Book AS Book1
 , GaveFrom AS GaveFrom1
 , Book AS Book2
 , GaveFrom AS GaveFrom2
 , Book AS Book3
WHERE MATCH(Book1-(GaveFrom1)->Book2-(GaveFrom2)->Book3)
 AND Book1.name = N'���� �� ���';

 
SELECT Book2.name AS book
 , Library.name AS library
 , Photocoped.photocoped
FROM Book AS book1
 , Book AS book2
 , Photocoped
 , GaveFrom
 , Library
WHERE MATCH(book1-(GaveFrom)->book2-(Photocoped)->Library)
 AND book1.name = N'����� � ���';

 
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
 AND Book1.name = N'����� � ���';


