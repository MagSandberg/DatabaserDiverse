--CREATE DATABASE KlassenDb;

USE KlassenDb;

--DROP TABLE DjurTBL;
--DROP DATABASE DjurDB;

--CREATE TABLE PersonTbl (
--	[Id] int Primary Key, 
--	[F�rnamn] nvarchar(max) not null,
--	[Efternamn] nvarchar(max) not null,
--	[�lder] int,
--	[Hemort] nvarchar(max) not null
--);

--INSERT INTO PersonTbl ([Id], [F�rnamn], [Efternamn], [�lder], [Hemort])
--VALUES (5, 'Erik', 'Stur�n', 31, 'G�teborg');

UPDATE PersonTbl
SET Hemort = 'G�teborg'
WHERE Hemort = 'G�tebord';

SELECT * FROM PersonTbl;

