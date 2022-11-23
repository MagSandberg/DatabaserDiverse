--USE everyloop;

--select * into Elements3 from Elements;


------------------------------------------


--1: Ta ut data (select) från tabellen GameOfThrones på sådant sätt 
--att ni får ut en kolumn ’Title’ med titeln samt en kolumn ’Episode’ 
--som visar episoder och säsonger i formatet ”S01E01”, ”S01E02”, 
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


--2: Uppdatera (kopia på) tabellen user och sätt username för alla användare 
--så den blir de 2 första bokstäverna i förnamnet, och de 2 första i 
--efternamnet (istället för 3+3 som det är i orginalet). 
--Hela användarnamnet ska vara i små bokstäver.

--SELECT LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2))) AS UserName
--FROM Users2;

--UPDATE Users2 
--SET UserName = LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)));


------------------------------------------


--3: Uppdatera (kopia på) tabellen airports så att alla null-värden i 
--kolumnerna Time och DST byts ut mot ’-’

--UPDATE Airports2
--SET [Time] = '-'
--WHERE [Time] IS NULL;

--UPDATE Airports2
--SET [DST] = '-'
--WHERE [DST] IS NULL;

--SELECT * FROM Airports2;


------------------------------------------


--4: Ta bort de rader från (kopia på) tabellen Elements där ”Name” är någon 
--av följande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', 
--samt alla rader där ”Name” börjar på någon av bokstäverna 
--d, k, m, o, eller u.

--DELETE FROM Elements2
-- WHERE [Name] IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium') or
-- [Name] LIKE 'd%' or [name] like 'k%' or [name] like 'm%' or [name] like 'o%' or [name] like'u%';

--SELECT * FROM Elements2;


------------------------------------------


--5: Skapa en ny tabell med alla rader från tabellen Elements. 
--Den nya tabellen ska innehålla ”Symbol” och ”Name” från orginalet, 
--samt en tredje kolumn med värdet ’Yes’ för de rader där ”Name” börjar 
--med bokstäverna i ”Symbol”, och ’No’ för de rader där de inte gör det.

--Ex: ’He’ -> ’Helium’ -> ’Yes’, ’Mg’ -> ’Magnesium’ -> ’No’.

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


--6: Kopiera tabellen Colors till Colors2, men skippa kolumnen ”Code”. 
--Gör sedan en select från Colors2 som ger samma resultat som du skulle fått 
--från select * from Colors; (Dvs, återskapa den saknade kolumnen från 
--RGBvärdena i resultatet).

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

--7: Kopiera kolumnerna ”Integer” och ”String” från tabellen ”Types” till en ny tabell. 
--Gör sedan en select från den nya tabellen som ger samma resultat som du skulle 
--fått från select * from types;

--SELECT [Integer], [String] INTO Types2 FROM Types;

--DECLARE @time time(7) = '09:01:00.0000000';
--DECLARE @increment int = 0;

--SELECT [Integer], [Integer]*0.01 AS [Float], 
--[String], DATEADD(MI, @increment + 1, @time) AS [DateTime],
--CASE 
--    WHEN [Integer]%2 = 0 THEN 0
--    ELSE 1
--END AS [Bool] FROM Types2;

--SELECT * FROM Types2;
--SELECT * FROM Types;

--ÖVNINGAR 2

--1: Företagets totala produktkatalog består av 77 unika produkter. 
--Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London?

--SELECT * FROM company.orders ORDER BY ShipCity ASC;
--SELECT * FROM company.order_details;

--SELECT CONVERT(float, COUNT(DISTINCT ProductId)) / CONVERT(float, 77) * 100 as Antal
--FROM
--		company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--WHERE ShipCity = 'London';


--2: Till vilken stad har vi levererat flest unika produkter?

--SELECT COUNT(DISTINCT ProductId) as OrderIdCount, ShipCity
--FROM
--		company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--GROUP BY ShipCity;

--3: Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland?

--SELECT	OrderId, ShipName, ShipCountry, ProductId, order_details.Quantity, order_details.UnitPrice,
--		ProductName, Quantity * order_details.UnitPrice as QtyTimesPrice, 
--		company.order_details.Discount,
--CASE
--	WHEN company.order_details.Discount > 0
--	THEN Quantity * company.products.UnitPrice - Quantity * company.products.UnitPrice * company.order_details.Discount
--	ELSE Quantity * company.products.UnitPrice
--END AS 
--	OrderTotal
--FROM	
--	company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--WHERE	Discontinued = 1 AND ShipCountry LIKE 'Germany'
--GROUP BY OrderId, ShipName, Quantity, order_details.UnitPrice, ProductId, ProductName, company.products.UnitPrice, company.order_details.Discount, ShipCountry
--ORDER BY ProductId ASC;

--4: För vilken produktkategori har vi högst lagervärde

--SELECT categories.Id, categories.CategoryName, SUM(UnitsInStock) AS TotalUnits 
--FROM company.products
--JOIN company.categories ON company.products.CategoryId = company.categories.Id
--GROUP BY categories.Id, categories.CategoryName
--ORDER BY TotalUnits DESC;

--5: Från vilken leverantör har vi sålt flest produkter totalt under sommaren 2013?

--SELECT top 1 CompanyName,  SUM(Quantity) AS SumProducts FROM company.orders 
--JOIN company.order_details ON company.orders.Id = OrderId
--JOIN company.products ON company.order_details.ProductId = company.products.Id
--JOIN company.suppliers ON company.products.SupplierId = company.suppliers.Id
--WHERE OrderDate >= '2013-06-01' AND OrderDate < '2013-09-01'
--GROUP BY CompanyName
--ORDER BY SumProducts DESC;

--Med tabellerna från schema “music”, svara på följande frågor:

--1: Av alla audiospår, vilken artist har längst total speltid?
--2: Vad är den genomsnittliga speltiden på den artistens låtar?
--3: Vad är den sammanlagda filstorleken för all video?
--4: Vilket är det högsta antal artister som finns på en enskild spellista?
--5. Vilket är det genomsnittliga antalet artister per spellista?

DECLARE @playlist VARCHAR(max) = 'Heavy Metal Classic';

SELECT @playlist FROM music.playlists;
SELECT * FROM music.playlists;
SELECT * FROM music.playlist_track;
SELECT * FROM music.tracks;
SELECT * FROM music.albums;
SELECT * FROM music.artists;
--Genre	Artist	Album	Track	Length	Size	Composer

--SELECT * INTO music.tracks2 FROM music.tracks;

--UPDATE music.tracks
--SET Composer = '-'
--WHERE Composer IS NULL; 

SELECT genres.Name AS Genre, artists.Name AS Artist, albums.Title AS Album, tracks.Name AS Track, 
RIGHT(CONVERT(CHAR(8),DATEADD(second, (Milliseconds / (1000)), 0),108),5) AS Length,
CONCAT(ROUND(CONVERT(float, Bytes / CONVERT(float, 1048576)), 1), ' MiB') AS Size, Composer
FROM music.tracks
JOIN music.albums ON music.tracks.AlbumId = music.albums.AlbumId
JOIN music.artists ON music.albums.Artistid = music.artists.ArtistId
JOIN music.genres ON music.tracks.GenreId = music.genres.GenreId
JOIN music.playlist_track ON music.tracks.TrackId = music.playlist_track.TrackId
WHERE PlaylistId = 17;

