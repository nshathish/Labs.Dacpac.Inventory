-- Tables/PurchaseOrders.sql
CREATE TABLE [dbo].[PurchaseOrders] (
    [PurchaseOrderId] INT IDENTITY(1,1) PRIMARY KEY,
    [PONumber] NVARCHAR(50) NOT NULL UNIQUE,
    [SupplierId] INT NOT NULL,
    [OrderDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [ExpectedDate] DATETIME2 NULL,
    [Status] NVARCHAR(20) NOT NULL DEFAULT 'PENDING', -- PENDING, RECEIVED, CANCELLED
    [TotalAmount] DECIMAL(18,2) NULL,
    [Notes] NVARCHAR(500) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT [FK_PurchaseOrders_Suppliers]
    FOREIGN KEY ([SupplierId])
    REFERENCES [dbo].[Suppliers]([SupplierId])
    );