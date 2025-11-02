-- Tables/Suppliers.sql
CREATE TABLE [dbo].[Suppliers] (
    [SupplierId] INT IDENTITY(1,1) PRIMARY KEY,
    [SupplierName] NVARCHAR(200) NOT NULL,
    [ContactName] NVARCHAR(100) NULL,
    [ContactEmail] NVARCHAR(255) NULL,
    [ContactPhone] NVARCHAR(20) NULL,
    [Address] NVARCHAR(500) NULL,
    [City] NVARCHAR(100) NULL,
    [State] NVARCHAR(100) NULL,
    [PostalCode] NVARCHAR(20) NULL,
    [Country] NVARCHAR(100) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE()
    );

CREATE UNIQUE INDEX [IX_Suppliers_SupplierName]
    ON [dbo].[Suppliers]([SupplierName])
    WHERE [IsActive] = 1;