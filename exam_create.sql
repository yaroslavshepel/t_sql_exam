CREATE TABLE [Countries] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE [Themes] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE [Authors] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Surname] NVARCHAR(MAX) NOT NULL,
    [CountryId] INT NOT NULL,
    FOREIGN KEY ([CountryId]) REFERENCES [Countries](Id)
);

CREATE TABLE [Shops] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(MAX) NOT NULL,
    [CountryId] INT NOT NULL,
    FOREIGN KEY ([CountryId]) REFERENCES [Countries](Id)
);

CREATE TABLE [Books] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Pages] INT NOT NULL CHECK ([Pages] > 0),
    [Price] MONEY NOT NULL CHECK ([Price] >= 0),
    [PublishDate] DATE NOT NULL CHECK ([PublishDate] <= GETDATE()),
    [AuthorId] INT NOT NULL,
    [ThemeId] INT NOT NULL,
    FOREIGN KEY ([AuthorId]) REFERENCES [Authors](Id),
    FOREIGN KEY ([ThemeId]) REFERENCES [Themes](Id)
);

CREATE TABLE [Sales] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Price] MONEY NOT NULL CHECK ([Price] >= 0),
    [Quantity] INT NOT NULL CHECK ([Quantity] > 0),
    [SaleDate] DATE NOT NULL DEFAULT GETDATE() CHECK ([SaleDate] <= GETDATE()),
    [BookId] INT NOT NULL,
    [ShopId] INT NOT NULL,
    FOREIGN KEY ([BookId]) REFERENCES [Books](Id),
    FOREIGN KEY ([ShopId]) REFERENCES [Shops](Id)
);
