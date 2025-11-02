-- Tables/Products.sql
CREATE TABLE [dbo].[Products] (
    [ProductId] INT IDENTITY(1,1) PRIMARY KEY,
    [SKU] NVARCHAR(50) NOT NULL UNIQUE,
    [ProductName] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(1000) NULL,
    [CategoryId] INT NOT NULL,
    [SupplierId] INT NULL,
    [UnitPrice] DECIMAL(18,2) NOT NULL,
    [CostPrice] DECIMAL(18,2) NULL,
    [ReorderLevel] INT NOT NULL DEFAULT 0,
    [MinimumStock] INT NOT NULL DEFAULT 0,
    [UnitOfMeasure] NVARCHAR(20) NULL,
    [Weight] DECIMAL(10,3) NULL,
    [Dimensions] NVARCHAR(100) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT [CHK_Products_UnitPrice]
    CHECK ([UnitPrice] >= 0),

    CONSTRAINT [CHK_Products_CostPrice]
    CHECK ([CostPrice] >= 0)
);
GO

CREATE INDEX [IX_Products_CategoryId] ON [dbo].[Products]([CategoryId]);
GO

CREATE INDEX [IX_Products_SupplierId] ON [dbo].[Products]([SupplierId]);
GO