-- Tables/Locations.sql
CREATE TABLE [dbo].[Locations] (
    [LocationId] INT IDENTITY(1,1) PRIMARY KEY,
    [LocationName] NVARCHAR(100) NOT NULL,
    [LocationCode] NVARCHAR(20) NOT NULL UNIQUE,
    [Address] NVARCHAR(500) NULL,
    [City] NVARCHAR(100) NULL,
    [State] NVARCHAR(100) NULL,
    [PostalCode] NVARCHAR(20) NULL,
    [Country] NVARCHAR(100) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);
GO

CREATE UNIQUE INDEX [IX_Locations_LocationName]
    ON [dbo].[Locations]([LocationName])
WHERE [IsActive] = 1;
GO