/*

	SQL - Podstawowe zapytania

*/



USE AdventureWorks2017
GO




/*
	1. Podstawowe zapytania 
*/

-- NAZWA_SCHEMATU.NAZWA_TABELI
SELECT * FROM Production.Product

SELECT * FROM Person.Person

-- brakuje nazwy schematu
SELECT * FROM Person

SELECT * FROM dbo.DatabaseLog


-- schemat dbo to domyślny schemat
SELECT * FROM DatabaseLog




-- j.w. zaznaczenie kilku zapytań - wykonywanie wsadu



-- w tym przypadku nawiasy kwadratowe są opcjonalne
SELECT * FROM [Person].[Person]

-- zmiana nazwy na taką ze spacją
sp_rename 'HumanResources.JobCandidate', 'Job Candidate'

-- nawiasy kwadratowe - obowiązkowe
SELECT * FROM [HumanResources].[Job Candidate]

--!
SELECT * FROM HumanResources.Job Candidate


-- powrót do oryginalnej nazwy
sp_rename 'HumanResources.Job Candidate', 'JobCandidate'




-- wybieranie kolumn
SELECT ProductID, Name, Color, Size 
FROM Production.Product
-- ProductID = klucz główny (PRIMARY KEY, PK)

-- aliasy
SELECT ProductID AS ID, Name AS Nazwa, Color AS Kolor, Size AS Rozmiar
FROM Production.Product



/*
	2. Sortowanie danych
*/

-- domyślny porządek sortowania
SELECT * FROM Production.Product


-- wiersze posortowane ROSNĄCO wg zawartości kolumny Name
-- = produkty posortowanie wg nazwy
SELECT * FROM Production.Product
ORDER BY Name

-- porządek sortowania malejący
SELECT * FROM Production.Product
ORDER BY Name DESC

-- dwa poziomy sortowania
-- produkty posortowane wg koloru, a te które mają ten sam kolor - wg nazwy
SELECT * FROM Production.Product
ORDER BY Color, Name

-- malejąco wg koloru i rosnąco wg nazwy
SELECT * FROM Production.Product
ORDER BY Color DESC, Name



/*
	3. Filtrwanie danych
*/


SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID = 707

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID > 100

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID BETWEEN 13 AND 360



-- wartości tekstowe - w pojedynczych apostrofach
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Red'

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Size = 'M'




-- Operator LIKE
SELECT * FROM Production.Product 
WHERE Name LIKE 'B%'

-- % - dowolony znak w dowolnej liczbie
SELECT * FROM Production.Product 
WHERE Name LIKE '%Bike%'

-- _ dowolny pojedynczy znak
SELECT * FROM Production.Product
WHERE Name LIKE 'Mountain Bike Socks, _'

--! = zamiast LIKE
SELECT * FROM Production.Product 
WHERE Name = '%Bike%'





-- Operatory AND OR

-- produkty koloru czarnego, o rozmiarze M
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' AND Size = 'M'

-- produkty koloru czarnego, srebrnego i niebieskiego
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Silver' OR Color = 'Blue'
order by ProductID 
-- łączymy razem...
SELECT * FROM Production.Product 
WHERE Name LIKE '%Bike%' AND Color = 'White'



-- NULL

-- na początku w kolumnie kolor wartości nieokreślone
SELECT * FROM Production.Product
ORDER BY Color

--! czy na pewno nie ma takich wierszy
SELECT * FROM Production.Product
WHERE Color = NULL


SELECT * FROM Production.Product
WHERE Color IS NULL

SELECT * FROM Production.Product
WHERE Color IS NOT NULL


-- łączymy razem...
SELECT * FROM Production.Product 
WHERE Color = 'Black' AND Size IS NOT NULL AND Name LIKE '%Frame%'


-- nawiasy...
-- produkty koloru czarnego i rozmiarze M LUB czerwone produkty związane z szosą
SELECT * FROM Production.Product 
WHERE (Color = 'Black' AND Size = 'M') OR (Color = 'Red' AND Name LIKE '%Road%')

--! uwaga na warunki wykluczające się
SELECT * FROM Production.Product 
WHERE Color = 'Black' AND Color = 'Red'

-- zamiast tego...
SELECT * FROM Production.Product 
WHERE Color = 'Black' OR Color = 'Red'


-- zamiast tego...
SELECT * FROM Production.Product 
WHERE Color = 'Black' OR Color = 'Red'

SELECT * FROM Production.Product 
WHERE Color IN ('Black', 'Red')





/*
	4. Logiczna kolejność wykonywania zapytania
*/

--! odwołanie się do aliasu kolumny w WHERE nie zadziała
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
WHERE Kolor = 'Red'


-- odwołanie się do aliastu kolumny w ORDER BY - jest OK
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
ORDER BY Kolor 


-- kolejność wykonywania instrukcji SELECT
SELECT ProductID, Name, Color AS Kolor, Size	-- 2
FROM Production.Product							-- 1
ORDER BY Kolor									-- 3



-- bez aliastu też się uda
SELECT ProductID, Name, Color AS Kolor, Size 
FROM Production.Product
ORDER BY Color




/*
	5. Funkcje 
*/

-- skalarne
SELECT GETDATE()


SELECT GETDATE() AS CurrentDateTime



SELECT UPPER('Bardzo ładny rower') AS Nazwa, GETDATE() as CurrentDateTime

-- godziny/ miesiace/ lata.... , OD KIEDY, DO KIEDY
SELECT DATEDIFF(HOUR, '20190801 12:15', '20190801 15:15')

SELECT DATEDIFF(MONTH, '20190801', '20201201')

SELECT DATEDIFF(YEAR, '20190801', '20201201')



SELECT DATEDIFF(YEAR, GETDATE(), '20401201')

SELECT DATEDIFF(DAY, GETDATE(), '20401201')
SELECT DATEDIFF(HOUR, GETDATE(), '20401201')


-- nazwy produktów wielkimi literami
SELECT ProductID, UPPER(Name) AS Name, Color AS Kolor, Size 
FROM Production.Product

select SellStartDate from Production.Product
-- ile dni upłynęło od początku sprzedaży
SELECT ProductID, Name, Color AS Kolor, Size,SellStartDate ,DATEDIFF(DAY, SellStartDate, GETDATE()) 
FROM Production.Product



-- Funkcje agregujące
SELECT COUNT(*) AS FnCount FROM Production.Product
where Color = 'Black'

SELECT SUM(ListPrice) AS FnSum FROM Production.Product

SELECT MIN(ListPrice) AS FnMIN FROM Production.Product
where Color = 'Black'




/*
	6. Grupowanie danych
*/

SELECT COUNT(*) AS Cnt FROM Production.Product

-- liczba produktów koloru czerwonego
SELECT COUNT(*) AS Cnt FROM Production.Product
WHERE Color = 'Red'

-- liczba produktów poszczególnych kolorów
SELECT Color, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color

--! nie możemy wyświetlać kolumn, po których nie pogrupowaliśmy 
SELECT Color, Size, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color


-- ... chyba, że po nich również pogrupujemy
SELECT Color, Size, COUNT(*) AS Cnt 
FROM Production.Product
GROUP BY Color, Size


/*
	7. Łączenie tabel
*/


SELECT * FROM Production.Product


SELECT * FROM Production.ProductSubcategory



SELECT * 
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID

--! obie tabele zawierają kolumnę Name
SELECT ProductID, Name, Color, Size, Name
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID


SELECT ProductID, Production.Product.Name, Color, Size, Production.ProductSubcategory.Name
FROM Production.Product
JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID


-- aliasy tabel
SELECT ProductID, p.Name, Color, Size, ps.Name, p.ProductSubcategoryID, ps.ProductSubcategoryID
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID




/*
Przykłady
USE AdventureWorks2017


*/

/*
-- 1. Wyświetl wszystkie produkty koloru czerwonego i niebieskiego, których nazwa zaczyna się 
-- na 'L', posortowane wg rozmiaru malejąco i ceny rosnąco
*/
select * from Production.Product 
where Production.Product.Color IN ('Red','Blue') and Production.Product.Name like 'L%'
order by Size desc, ListPrice asc

/*
-- 2. Wyświetl wszystkie produkty (tabela Production.Product) koloru czarnego,
-- posortowane malejąco wg ceny (ListPrice)
*/
select * from Production.Product
where Color ='Black'
order by ListPrice desc

/*
-- 3. Wyświetl wiersze z tabeli Sales.SalesTerritory, przypisane do Europy, posortowane wg nazwy kraju
-- podpowiedź: Group jest słowem zastrzezonym w SQL Server, 
--   posługując się kolumną o tej nazwie w zapytaniach powinieneś więc używać nawiasow kwadratowych
*/
select * from Sales.SalesTerritory
where [Group] ='Europe'
order by name

/*
-- 4. Wyświetl wiersze z tabeli Sales.SalesTerritory, 
-- posortowane wg grupy regionów (kontynentów) malejąco i nazwy kraju rosnąco
*/
select * from Sales.SalesTerritory
order by [Group] desc, [name] asc

/*
-- 5. Wyświetl zamówienia przypisane do obszarów o ID 7,8,9
*/
select * from Sales.SalesOrderHeader
where TerritoryID in (7,8,9)

/*
-- 6. Wyświetl 10 ostatnich zamówień,
-- przypisanych do obszarów o ID 7,8,9 o 
-- wartości (kolumna SubTotal) mniejszej niż 100
*/
select top 10 *from Sales.SalesOrderHeader
where TerritoryID in (7,8,9) and SubTotal < 100 
order by OrderDate desc


/*
-- 7. Wyświetl 10 zamówień na najwyższą kwotę, przypisanych do obszaru 7
*/
select top 10 * from Sales.SalesOrderHeader
where TerritoryID = 7
order by SubTotal desc

/*
-- 8. Wyświetl zamówienia przypisanych do obszaru 7, 
-- bez przypisanego numeru kardy kredytowej (kolumna CreditCardID)
*/
select * from Sales.SalesOrderHeader
where TerritoryID = 7 and CreditCardID is null

/* 
-- 9. Wyświetl zamówienia przypisanych do obszaru 7, z przypisanym numerem kardy kredytowej
*/
select * from Sales.SalesOrderHeader
where TerritoryID = 7 and CreditCardID is not null

/*
-- 10. Wyświetl zamówienia z roku 2011, posortuj wg daty zamówienia
*/
select * from Sales.SalesOrderHeader
where OrderDate between '20110101' and '20111231'
order by OrderDate
