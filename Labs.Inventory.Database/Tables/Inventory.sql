-- Tables/Inventory.sql
CREATE TABLE [dbo].[Inventory] (
    [InventoryId] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductId] INT NOT NULL,
    [LocationId] INT NOT NULL,
    [QuantityOnHand] INT NOT NULL DEFAULT 0,
    [QuantityReserved] INT NOT NULL DEFAULT 0,
    [QuantityAvailable] AS ([QuantityOnHand] - [QuantityReserved]),
    [BinLocation] NVARCHAR(50) NULL,
    [LastStockTakeDate] DATETIME2 NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT [CHK_Inventory_QuantityOnHand]
    CHECK ([QuantityOnHand] >= 0),

    CONSTRAINT [CHK_Inventory_QuantityReserved]
    CHECK ([QuantityReserved] >= 0 AND [QuantityReserved] <= [QuantityOnHand]),

    CONSTRAINT [UK_Inventory_ProductLocation]
    UNIQUE ([ProductId], [LocationId])
);
GO

CREATE INDEX [IX_Inventory_LocationId] ON [dbo].[Inventory]([LocationId]);
GO

CREATE INDEX [IX_Inventory_ProductId] ON [dbo].[Inventory]([ProductId]);
GO