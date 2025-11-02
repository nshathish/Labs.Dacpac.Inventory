-- Tables/PurchaseOrderItems.sql
CREATE TABLE [dbo].[PurchaseOrderItems] (
    [POItemId] INT IDENTITY(1,1) PRIMARY KEY,
    [PurchaseOrderId] INT NOT NULL,
    [ProductId] INT NOT NULL,
    [QuantityOrdered] INT NOT NULL,
    [QuantityReceived] INT NOT NULL DEFAULT 0,
    [UnitCost] DECIMAL(18,2) NOT NULL,
    [ReceivedDate] DATETIME2 NULL
);