USE AdventureWorks2017
GO


SELECT * FROM HumanResources.Employee
GO


SELECT  * FROM Person.Person
GO


SELECT *
FROM HumanResources.Employee AS e
JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID

-- 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID

SELECT * from Production.Product
select * from Production.ProductSubcategory

select p.Name, p.Color, s.Name from Production.Product as P 
JOIN Production.ProductSubcategory as s on p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT COUNT(*) FROM HumanResources.Employee
SELECT COUNT(*) FROM Person.Person


-- RIGHT JOIN 19 972 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
RIGHT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID

-- LEFT JOIN 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
LEFT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID




SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM HumanResources.Employee AS e
RIGHT JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
-- taki sam wynik
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID


SELECT * FROM HumanResources.Department


SELECT * FROM  HumanResources.EmployeeDepartmentHistory ORDER BY BusinessEntityID

-- aktywne przypisanie pracowników
SELECT * FROM  HumanResources.EmployeeDepartmentHistory 
WHERE EndDate IS NULL


-- 296 wierszy!!
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle, d.Name AS DepartmenName
FROM Person.Person AS p
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID


-- 290 wierszy
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.LoginID, e.JobTitle, d.Name AS DepartmenName
FROM Person.Person AS p
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL



SELECT d.Name, count(*)
-- FROM Person.Person AS p -- niepotrzebna tabela
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL
GROUP BY d.Name


SELECT d.Name, e.JobTitle, count(*)
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeeDepartmentHistory AS dh ON dh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department AS d ON d.DepartmentID = dh.DepartmentID
WHERE dh.EndDate IS NULL
GROUP BY d.Name, e.JobTitle
ORDER BY d.Name, e.JobTitle



/*
    ZADANIA
*/

-- pracownicy
SELECT * FROM HumanResources.Employee

-- dane osobowe
SELECT * FROM Person.Person

-- adresy
SELECT * FROM  Person.Address

-- powiązanie osób z adresami
SELECT * FROM  Person.BusinessEntityAddress


-- 1/ ranking imion - zlicz osoby o poszczególnych imionach
SELECT FirstName, COUNT(*) FROM Person.Person
GROUP by FirstName
ORDER by COUNT(*) DESC

-- 2/ połącz tabelę z danymi osobymi z tabelą z adresami (w sumie3 tabele)
--      wyświetl imię, nazwisko, nazwę stanowiska i miasto
select FirstName, LastName, ad.City FROM
Person.Person as p 
JOIN Person.BusinessEntityAddress as ba on ba.BusinessEntityID = p.BusinessEntityID
join Person.Address as ad on ad.AddressID = ba.AddressID



-- 3/ ZLICZ pracowników mieszkających w poszczególnych miastach

select ad.City, COUNT(*) FROM
Person.Person as p 
JOIN Person.BusinessEntityAddress as ba on ba.BusinessEntityID = p.BusinessEntityID
join Person.Address as ad on ad.AddressID = ba.AddressID
GROUP by ad.City

-- 3/ Poprzwednie zapytanie - pokaż tylko miasta w których mieszka min 200 osób

select ad.City, COUNT(*) FROM
Person.Person as p 
JOIN Person.BusinessEntityAddress as ba on ba.BusinessEntityID = p.BusinessEntityID
join Person.Address as ad on ad.AddressID = ba.AddressID
GROUP by ad.City
HAVING COUNT(*)>= 200


-- 5/ Sprawdź gdzie mieszka NAJWIĘCEJ osób

select top 1 ad.City, COUNT(*) FROM
Person.Person as p 
JOIN Person.BusinessEntityAddress as ba on ba.BusinessEntityID = p.BusinessEntityID
join Person.Address as ad on ad.AddressID = ba.AddressID
GROUP by ad.City
ORDER by COUNT(*) desc
