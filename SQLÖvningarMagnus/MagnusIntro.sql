--CREATE DATABASE KlassenDb;

USE KlassenDb;

--DROP TABLE DjurTBL;
--DROP DATABASE DjurDB;

--CREATE TABLE PersonTbl (
--	[Id] int Primary Key, 
--	[Förnamn] nvarchar(max) not null,
--	[Efternamn] nvarchar(max) not null,
--	[Ålder] int,
--	[Hemort] nvarchar(max) not null
--);

--INSERT INTO PersonTbl ([Id], [Förnamn], [Efternamn], [Ålder], [Hemort])
--VALUES (5, 'Erik', 'Sturén', 31, 'Göteborg');

UPDATE PersonTbl
SET Hemort = 'Göteborg'
WHERE Hemort = 'Götebord';

SELECT * FROM PersonTbl;

