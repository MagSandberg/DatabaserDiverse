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

--SELECT * FROM Types2;
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

--SELECT COUNT(DISTINCT ProductId) as OrderIdCount, ShipCity
--FROM
--		company.orders 
--JOIN	company.order_details ON company.orders.Id = OrderId
--JOIN	company.products ON ProductId = company.products.Id
--GROUP BY ShipCity;

--3: Av de produkter som inte l�ngre finns I v�rat sortiment, hur mycket har vi s�lt f�r totalt till Tyskland?

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

--4: F�r vilken produktkategori har vi h�gst lagerv�rde

--SELECT categories.Id, categories.CategoryName, SUM(UnitsInStock) AS TotalUnits 
--FROM company.products
--JOIN company.categories ON company.products.CategoryId = company.categories.Id
--GROUP BY categories.Id, categories.CategoryName
--ORDER BY TotalUnits DESC;

--5: Fr�n vilken leverant�r har vi s�lt flest produkter totalt under sommaren 2013?

--SELECT top 1 CompanyName,  SUM(Quantity) AS SumProducts FROM company.orders 
--JOIN company.order_details ON company.orders.Id = OrderId
--JOIN company.products ON company.order_details.ProductId = company.products.Id
--JOIN company.suppliers ON company.products.SupplierId = company.suppliers.Id
--WHERE OrderDate >= '2013-06-01' AND OrderDate < '2013-09-01'
--GROUP BY CompanyName
--ORDER BY SumProducts DESC;

--Med tabellerna fr�n schema �music�, svara p� f�ljande fr�gor:

--1: Av alla audiosp�r, vilken artist har l�ngst total speltid?
--2: Vad �r den genomsnittliga speltiden p� den artistens l�tar?
--3: Vad �r den sammanlagda filstorleken f�r all video?
--4: Vilket �r det h�gsta antal artister som finns p� en enskild spellista?
--5. Vilket �r det genomsnittliga antalet artister per spellista?

--DECLARE @playlist VARCHAR(max) = 'Heavy Metal Classic';

--SELECT * INTO music.tracks2 FROM music.tracks;

--UPDATE music.tracks
--SET Composer = '-'
--WHERE Composer IS NULL; 

--SELECT genres.Name AS Genre, artists.Name AS Artist, albums.Title AS Album, tracks.Name AS Track, 
--RIGHT(CONVERT(CHAR(8),DATEADD(second, (Milliseconds / (1000)), 0),108),5) AS Length,
--CONCAT(ROUND(CONVERT(float, Bytes / CONVERT(float, 1048576)), 1), ' MiB') AS Size, Composer
--FROM music.tracks
--JOIN music.albums ON music.tracks.AlbumId = music.albums.AlbumId
--JOIN music.artists ON music.albums.Artistid = music.artists.ArtistId
--JOIN music.genres ON music.tracks.GenreId = music.genres.GenreId
--JOIN music.playlist_track ON music.tracks.TrackId = music.playlist_track.TrackId
--WHERE PlaylistId = 17;

--SELECT @playlist FROM music.playlists;
--SELECT * FROM music.playlists;
--SELECT * FROM music.playlist_track;
--SELECT * FROM music.tracks;
--SELECT * FROM music.albums;
--SELECT * FROM music.artists;

--1: Av alla audiosp�r, vilken artist har l�ngst total speltid?

--select artists.Name as arstist, sum(Milliseconds) as length 
--from music.tracks
--join music.albums on music.tracks.AlbumId = music.albums.AlbumId
--join music.artists on music.albums.ArtistId = music.artists.ArtistId
--join music.genres on music.tracks.GenreId = music.genres.GenreId
--where music.genres.Name not in ('Science Fiction', 'TV Shows', 'Sci Fi & Fantasy', 'Drama', 'Comedy')
--group by artists.Name
--order by length DESC

--2: Vad �r den genomsnittliga speltiden p� den artistens l�tar?

--SELECT art.Name, RIGHT(CONVERT(CHAR(8),DATEADD(second, (AVG(Milliseconds) / (1000)), 0),108),5) AS Length
--FROM music.tracks AS t
--JOIN music.albums AS a ON t.AlbumId = a.AlbumId
--JOIN music.artists AS art ON art.ArtistId = a.ArtistId
--WHERE art.Name LIKE 'Iron Maiden'
--GROUP BY art.Name

--3: Vad �r den sammanlagda filstorleken f�r all video?

--SELECT SUM(ROUND(CONVERT(float, Bytes / CONVERT(float, 1073741824)), 2)) AS SumSizeGiB 
--FROM music.tracks
--JOIN music.albums ON music.tracks.AlbumId = music.albums.AlbumId
--JOIN music.artists ON music.albums.ArtistId = music.artists.ArtistId
--WHERE music.tracks.MediaTypeId = 3;

--4: Vilket �r det h�gsta antal artister som finns p� en enskild spellista?

--SELECT PlaylistId, COUNT(DISTINCT music.artists.ArtistId) AS CountArtists 
--FROM music.tracks
--JOIN music.playlist_track ON music.tracks.TrackId = music.playlist_track.TrackId
--JOIN music.albums ON music.tracks.AlbumId = music.albums.AlbumId
--JOIN music.artists on music.albums.ArtistId = music.artists.ArtistId
--WHERE music.playlist_track.PlaylistId NOT IN (2, 3, 4, 6, 7, 9, 10)
--GROUP BY PlaylistId
--ORDER BY CountArtists DESC;

--5: Vilket �r det genomsnittliga antalet artister per spellista?

--CREATE VIEW vAvgArtist
--AS
--SELECT PlaylistId, COUNT(DISTINCT music.artists.ArtistId) AS CountArtists 
--FROM music.tracks
--JOIN music.playlist_track ON music.tracks.TrackId = music.playlist_track.TrackId
--JOIN music.albums ON music.tracks.AlbumId = music.albums.AlbumId
--JOIN music.artists on music.albums.ArtistId = music.artists.ArtistId
--WHERE music.playlist_track.PlaylistId NOT IN (2, 3, 4, 6, 7, 9, 10)
--GROUP BY PlaylistId;

--SELECT AVG(CountArtists) FROM vAvgArtist;

-----------------------------------------------------------------------------------------------

--1: Ta ut (select) en rad f�r varje (unik) period i tabellen �Elements� med f�ljande kolumner: 
--�period�, �from� med l�gsta atomnumret i perioden, �to� med h�gsta atomnumret i perioden, 
--�average isotopes� med genomsnittligt antal isotoper visat med 2 decimaler, �symbols� 
--med en kommaseparerad lista av alla �mnen i perioden.

--SELECT 
--DISTINCT [Period], 
--MIN(Number) AS [from],
--MAX(Number) AS [to],
--ROUND(AVG(CONVERT(float, Stableisotopes)), 2) AS [average isotopes],
--STRING_AGG(Symbol, ', ') AS [symbols]
--FROM [Elements]
--GROUP BY Period;

--SELECT * FROM Elements;

--2: F�r varje stad som har 2 eller fler kunder i tabellen Customers, ta ut (select) f�ljande 
--kolumner: �Region�, �Country�, �City�, samt �Customers� som anger hur m�nga kunder som 
--finns i staden.

--SELECT Region, Country, City, COUNT(City) AS Customers
--FROM company.customers
--GROUP BY City, Region, Country
--HAVING COUNT(City) > 1;

--SELECT * 
--FROM company.customers
--ORDER BY City;

--3: Skapa en varchar-variabel och skriv en select-sats som s�tter v�rdet: 
--�S�song 1 s�ndes fr�n april till juni 2011. Totalt s�ndes 10 avsnitt, som i genomsnitt 
--s�gs av 2.5 miljoner m�nniskor i USA.�, f�ljt av radbyte/char(13), f�ljt av 
--�S�song 2 s�ndes �� osv. N�r du sedan skriver (print) variabeln till messages ska du 
--allts� f� en rad f�r varje s�song enligt ovan, med data sammanst�llt fr�n tabellen GameOfThrones. 
--Tips: Ange �sv� som tredje parameter i format() f�r svenska m�nader.

--DECLARE @GameOfThrones AS varchar(max)
--SELECT @GameOfThrones = ''

--SELECT 
--@GameOfThrones +=  
--'S�song ' + CONVERT(VARCHAR, Season) + ' s�ndes fr�n ' + 
--FORMAT(MIN([Original air date]), 'MMMM', 'sv') + ' till ' + 
--FORMAT(MAX([Original air date]), 'MMMM yyyy', 'sv') + '. Totalt s�ndes ' + 
--CONVERT(VARCHAR, MAX(EpisodeInSeason)) + ' avsnitt, som i genomsnitt s�gs av ' +
--CONVERT(VARCHAR, ROUND(AVG([U.S. viewers(millions)]), 2)) + ' miljoner m�nniskor i USA.' + CHAR(13)
--FROM GameOfThrones
--GROUP BY Season
--PRINT @GameOfThrones;

--4: Ta ut (select) alla anv�ndare i tabellen �Users� s� du f�r tre kolumner: �Namn� som har 
--fulla namnet; ��lder� som visar hur m�nga �r personen �r idag (ex. �45 �r�); �K�n� som visar 
--om det �r en man eller kvinna. Sortera raderna efter f�r- och efternamn.

--SELECT
--CONCAT(FirstName, ' ', LastName) AS Namn, 
--CONCAT(DATEDIFF(year, SUBSTRING([ID], 1, 6), GETDATE()), + ' �r') AS �lder, 
--CASE
--    WHEN SUBSTRING([ID], 10, 1) %2 = 0 THEN 'Kvinna'
--    ELSE 'Man'
--END AS K�n
--FROM Users
--ORDER BY FirstName, LastName

--5: Ta ut en lista �ver regioner i tabellen �Countries� d�r det f�r varje region framg�r 
--regionens namn, antal l�nder i regionen, totalt antal inv�nare, total area, befolkningst�theten 
--med 2 decimaler, samt sp�dbarnsd�dligheten per 100.000 f�dslar avrundat till heltal.

--SELECT 
--Region, 
--COUNT(Country) AS Countries, 
--SUM(CONVERT (bigint, [Population])) AS population,
--SUM([Area (sq# mi#)]) AS TotalArea,
--ROUND(AVG(CONVERT(float, REPLACE([Pop# Density (per sq# mi#)], ',', ''))) / 10, 2) AS Density,
--ROUND(AVG(CONVERT(float, REPLACE([Infant mortality (per 1000 births)], ',', ''))), 0) AS InfantMortality
--FROM Countries
--GROUP BY Region;

--6: Fr�n tabellen �Airports�, gruppera per land och ta ut kolumner som visar: land, 
--antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur m�nga procent av 
--flygplatserna i varje land som saknar ICAO-kod.


--SELECT
--SUBSTRING([Location served] , LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 3, LEN([Location served])) AS Country
--FROM Airports
--GROUP BY SUBSTRING([Location served] , LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 3, LEN([Location served]))

--SELECT * FROM Airports