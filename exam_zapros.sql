use exam
go
/*1*/
SELECT *
FROM [Books]
WHERE [Pages] > 500 AND [Pages] < 650;

/*2*/
SELECT * 
FROM [Books]
WHERE LEFT([Name], 1) IN ('А', 'З');


/*3*/
SELECT [Books].*
FROM [Books]
INNER JOIN [Sales] ON [Books].Id = [Sales].BookId
WHERE [Books].[ThemeId] = 5 AND [Sales].[Quantity] > 30;

/*4*/
SELECT *
FROM [Books]
WHERE [Name] LIKE '%Microsoft%' AND [Name] NOT LIKE '%Windows%';

/*5*/
SELECT 
    CONCAT([Books].[Name], ' - ', [Themes].[Name], ' - ', [Authors].[Name], ' ', [Authors].[Surname]) AS 'Book_Info'
FROM [Books]
JOIN [Themes] ON [Books].[ThemeId] = [Themes].Id
JOIN [Authors] ON [Books].[AuthorId] = [Authors].Id
WHERE [Books].[Price] / [Books].[Pages] < 0.65;

/*6*/
SELECT *
FROM [Books]
WHERE LEN([Name]) - LEN(REPLACE([Name], ' ', '')) = 3;

/*7*/
SELECT 
    b.[Name], 
    t.[Name] AS [Theme], 
    CONCAT(a.[Name], ' ', a.[Surname]) AS [Author], 
    s.[Price], 
    s.[Quantity], 
    sh.[Name] AS [Shop]
FROM [Sales] s
INNER JOIN [Books] b ON s.[BookId] = b.[Id]
INNER JOIN [Themes] t ON b.[ThemeId] = t.[Id]
INNER JOIN [Authors] a ON b.[AuthorId] = a.[Id]
INNER JOIN [Shops] sh ON s.[ShopId] = sh.[Id]
WHERE b.[Name] NOT LIKE '%A%' 
    AND t.[Name] != 'Програмування' 
    AND CONCAT(a.[Name], ' ', a.[Surname]) != 'Френк Герберт'
    AND s.[Price] BETWEEN 10 AND 20
    AND s.[Quantity] >= 8
    AND sh.[CountryId] NOT IN (1, 2);

/*8*/
SELECT 'Кількість авторів' AS Description, COUNT(*) AS Value FROM Authors
UNION ALL
SELECT 'Кількість книг', COUNT(*) FROM Books
UNION ALL
SELECT 'Середня ціна продажу', AVG(Sales.[Price]) FROM Sales
UNION ALL
SELECT 'Середня кількість сторінок', AVG(Books.Pages) FROM Books;

/*9*/
SELECT Themes.[Name], SUM(Books.Pages) AS TotalPages
FROM Books
JOIN Themes ON Books.ThemeId = Themes.Id
GROUP BY Themes.[Name];

/*10*/
SELECT (Authors.[Name] + ' ' + Authors.[Surname]) AS AuthorFullName,
       COUNT(Books.Id) AS TotalBooks,
       SUM(Books.Pages) AS TotalPages
FROM Books
JOIN Authors ON Books.AuthorId = Authors.Id
GROUP BY Authors.[Name], Authors.[Surname];

/*11*/
SELECT TOP 1 Books.*
FROM Books
JOIN Themes ON Books.ThemeId = Themes.Id
WHERE Themes.[Name] = 'Програмування'
ORDER BY Books.Pages DESC;

/*12*/
SELECT Themes.[Name], AVG(Books.Pages) AS AveragePages
FROM Books
JOIN Themes ON Books.ThemeId = Themes.Id
GROUP BY Themes.[Name]
HAVING AVG(Books.Pages) <= 400;

/*13*/
SELECT Themes.[Name], SUM(Books.Pages) AS TotalPages
FROM Books
JOIN Themes ON Books.ThemeId = Themes.Id
WHERE Books.Pages > 400
  AND Themes.[Name] IN ('Програмування', 'Адміністрація', 'Дизайн')
GROUP BY Themes.[Name];

/*14*/
SELECT
    Books.[Name] AS BookName,
    Shops.[Name] AS ShopName,
    (Authors.[Name] + ' ' + Authors.[Surname]) AS Author,
    Sales.SaleDate,
    Sales.Quantity
FROM Sales
JOIN Books ON Sales.BookId = Books.Id
JOIN Shops ON Sales.ShopId = Shops.Id
JOIN Authors ON Books.AuthorId = Authors.Id;

/*15*/
SELECT TOP 1 Shops.[Name] AS ShopName, SUM(Sales.[Price] * Sales.[Quantity]) AS TotalRevenue
FROM Sales
JOIN Shops ON Sales.ShopId = Shops.Id
GROUP BY Shops.[Name]
ORDER BY TotalRevenue DESC;
