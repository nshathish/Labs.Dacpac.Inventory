-- Tables/InventoryTransactions.sql
CREATE TABLE [dbo].[InventoryTransactions] (
    [TransactionId] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductId] INT NOT NULL,
    [LocationId] INT NOT NULL,
    [TransactionType] NVARCHAR(20) NOT NULL, -- 'IN', 'OUT', 'ADJUST', 'TRANSFER'
    [Quantity] INT NOT NULL,
    [ReferenceNumber] NVARCHAR(100) NULL, -- PO Number, Sales Order, etc.
    [ReferenceType] NVARCHAR(50) NULL, -- 'PURCHASE', 'SALE', 'ADJUSTMENT', 'TRANSFER'
    [Notes] NVARCHAR(500) NULL,
    [TransactionDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [CreatedBy] NVARCHAR(100) NULL,

    CONSTRAINT [FK_InventoryTransactions_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]([ProductId]),

    CONSTRAINT [FK_InventoryTransactions_Locations]
    FOREIGN KEY ([LocationId])
    REFERENCES [dbo].[Locations]([LocationId]),

    CONSTRAINT [CHK_InventoryTransactions_TransactionType]
    CHECK ([TransactionType] IN ('IN', 'OUT', 'ADJUST', 'TRANSFER'))
    );

CREATE INDEX [IX_InventoryTransactions_ProductId] ON [dbo].[InventoryTransactions]([ProductId]);
CREATE INDEX [IX_InventoryTransactions_LocationId] ON [dbo].[InventoryTransactions]([LocationId]);
CREATE INDEX [IX_InventoryTransactions_TransactionDate] ON [dbo].[InventoryTransactions]([TransactionDate]);