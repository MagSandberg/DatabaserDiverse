--USE everyloop;

--select * into Elements3 from Elements;


------------------------------------------


--1: Ta ut data (select) fr�n tabellen GameOfThrones p� s�dant s�tt 
--att ni f�r ut en kolumn �Title� med titeln samt en kolumn �Episode� 
--som visar episoder och s�songer i formatet �S01E01�, �S01E02�, 
--osv. Tips: kolla upp funktionen format()

--select Episode, Title from GameOfThrones;

--select FORMAT(Season, 'S0#') AS 'Season', FORMAT(Episode, 'E0#') AS 'Episode' from GameOfThrones;

--SELECT CONCAT('S0', Season, 'E0', EpisodeInSeason) as SeasonEpisode FROM GameOfThrones;

--SELECT Title,
--CASE
--    WHEN EpisodeInSeason < 10 THEN CONCAT(FORMAT(Season, 'S0#') ,FORMAT(EpisodeInSeason, 'E0#'))
--    WHEN EpisodeInSeason >= 10 THEN CONCAT(FORMAT(Season, 'S0#') ,FORMAT(EpisodeInSeason, 'E#'))
--END AS Episode
--FROM GameOfThrones;


------------------------------------------


--2: Uppdatera (kopia p�) tabellen user och s�tt username f�r alla anv�ndare 
--s� den blir de 2 f�rsta bokst�verna i f�rnamnet, och de 2 f�rsta i 
--efternamnet (ist�llet f�r 3+3 som det �r i orginalet). 
--Hela anv�ndarnamnet ska vara i sm� bokst�ver.

--SELECT LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2))) AS UserName
--FROM Users2;

--UPDATE Users2 
--SET UserName = LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)));


------------------------------------------


--3: Uppdatera (kopia p�) tabellen airports s� att alla null-v�rden i 
--kolumnerna Time och DST byts ut mot �-�

--UPDATE Airports2
--SET [Time] = '-'
--WHERE [Time] IS NULL;

--UPDATE Airports2
--SET [DST] = '-'
--WHERE [DST] IS NULL;

--SELECT * FROM Airports2;


------------------------------------------


--4: Ta bort de rader fr�n (kopia p�) tabellen Elements d�r �Name� �r n�gon 
--av f�ljande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', 
--samt alla rader d�r �Name� b�rjar p� n�gon av bokst�verna 
--d, k, m, o, eller u.

--DELETE FROM Elements2
-- WHERE [Name] IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium') or
-- [Name] LIKE 'd%' or [name] like 'k%' or [name] like 'm%' or [name] like 'o%' or [name] like'u%';

--SELECT * FROM Elements2;


------------------------------------------


--5: Skapa en ny tabell med alla rader fr�n tabellen Elements. 
--Den nya tabellen ska inneh�lla �Symbol� och �Name� fr�n orginalet, 
--samt en tredje kolumn med v�rdet �Yes� f�r de rader d�r �Name� b�rjar 
--med bokst�verna i �Symbol�, och �No� f�r de rader d�r de inte g�r det.

--Ex: �He� -> �Helium� -> �Yes�, �Mg� -> �Magnesium� -> �No�.

--SELECT Symbol, [Name], 
--    CASE 
--        WHEN SUBSTRING([Name], 1, 2) = Symbol AND LEN(Symbol) > 1 THEN 'Yes'
--        WHEN SUBSTRING([Name], 1, 1) = Symbol AND LEN(Symbol) < 2 THEN 'Yes'
--        ELSE 'No'
--END AS Yesno 
--INTO Elements4
--FROM Elements;

--SELECT * FROM Elements4;


------------------------------------------


--6: Kopiera tabellen Colors till Colors2, men skippa kolumnen �Code�. 
--G�r sedan en select fr�n Colors2 som ger samma resultat som du skulle f�tt 
--fr�n select * from Colors; (Dvs, �terskapa den saknade kolumnen fr�n 
--RGBv�rdena i resultatet).

--SELECT * INTO Colors2 FROM Colors;

--ALTER TABLE Colors2
--DROP COLUMN Code;

--SELECT 
--CONVERT(VARBINARY(1), Red), 
--CONVERT(VARBINARY(1), Green), 
--CONVERT(VARBINARY(1), Blue) FROM Colors2;

--SELECT CONVERT(VARBINARY(8), Red, Green, Blue) FROM Colors2; 

--SELECT
--	CONVERT(Varbinary(1), Red)+ 
--	CONVERT(Varbinary(1), Green)+ 
--	CONVERT(Varbinary(1), Blue) AS Code
--FROM Colors2;

--SELECT
--	CASE 
--		WHEN 
--			FORMAT(Red, 'X') = '0' THEN '00' +
--			FORMAT(Green, 'X') = '0' THEN '00' +
--			FORMAT(Blue, 'X') = '0' THEN '00'
--		ELSE 
--			FORMAT(Red, 'X')+
--			FORMAT(Green, 'X')+
--			FORMAT(Blue, 'X')
--	END AS Code
--FROM Colors2;

--SELECT [Name], CONVERT(Varbinary(1), Red)+ CONVERT(Varbinary(1), Green) + CONVERT(Varbinary(1), Blue) as code, Red, Green, Blue
--INTO Colors6 
--FROM Colors;

--SELECT [Name], CONCAT('#', CONVERT(VARCHAR(max), code, 2)) AS newCode, Red, Green, Blue FROM Colors6;

--SELECT * FROM Colors;


------------------------------------------
--use everyloop;

--7: Kopiera kolumnerna �Integer� och �String� fr�n tabellen �Types� till en ny tabell. 
--G�r sedan en select fr�n den nya tabellen som ger samma resultat som du skulle 
--f�tt fr�n select * from types;

--SELECT [Integer], [String] INTO Types2 FROM Types;

--DECLARE @time time(7) = '09:01:00.0000000';
--DECLARE @increment int = 0;

--SELECT [Integer], [Integer]*0.01 AS [Float], 
--[String], DATEADD(MI, @increment + 1, @time) AS [DateTime],
--CASE 
--    WHEN [Integer]%2 = 0 THEN 0
--    ELSE 1
--END AS [Bool] FROM Types2;

----SELECT * FROM Types2;
--SELECT * FROM Types;

--�VNINGAR 2

--1: F�retagets totala produktkatalog best�r av 77 unika produkter. 
--Om vi kollar bland v�ra ordrar, hur stor andel av dessa produkter har vi n�gon g�ng leverarat till London?

--SELECT * FROM company.orders ORDER BY ShipCity ASC;
--SELECT * FROM company.order_details;

--SELECT CONVERT(float, COUNT(DISTINCT ProductId)) / CONVERT(float, 77) * 100 as Antal
--FROM
--		company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--WHERE ShipCity = 'London';

--2: Till vilken stad har vi levererat flest unika produkter?

--SELECT COUNT(DISTINCT OrderId) as OrderIdCount, ShipCity
--FROM
--		company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--GROUP BY ShipCity;

--3: Av de produkter som inte l�ngre finns I v�rat sortiment, hur mycket har vi s�lt f�r totalt till Tyskland?

SELECT ProductId, ProductName, COUNT(ProductId) * company.products.UnitPrice as QtyTimesPrice, company.order_details.Discount,
CASE
	WHEN company.order_details.Discount > 0
	THEN COUNT(ProductId) * company.products.UnitPrice - COUNT(ProductId) * company.products.UnitPrice * company.order_details.Discount
	ELSE COUNT(ProductId) * company.products.UnitPrice
	END AS OrderTotal 
FROM
		company.orders 
JOIN	company.order_details ON company.orders.ShipCountry LIKE 'Germany'
JOIN	company.products ON ProductId = company.products.Id
WHERE	ReorderLevel = 0
GROUP BY ProductId, ProductName, company.products.UnitPrice, company.order_details.Discount
ORDER BY ProductName ASC;

SELECT * FROM company.order_details;