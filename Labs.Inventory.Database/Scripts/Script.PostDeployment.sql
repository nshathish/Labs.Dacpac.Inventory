/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Add all foreign key constraints in pre-deployment
PRINT 'Adding foreign key constraints...';

-- Self-referencing category constraint
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Categories_ParentCategory')
BEGIN
ALTER TABLE [dbo].[Categories]
    ADD CONSTRAINT [FK_Categories_ParentCategory]
    FOREIGN KEY ([ParentCategoryId])
    REFERENCES [dbo].[Categories]([CategoryId]);
PRINT 'Added FK_Categories_ParentCategory';
END
GO

-- Product constraints
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Products_Categories')
BEGIN
ALTER TABLE [dbo].[Products]
    ADD CONSTRAINT [FK_Products_Categories]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[Categories]([CategoryId]);
PRINT 'Added FK_Products_Categories';
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Products_Suppliers')
BEGIN
ALTER TABLE [dbo].[Products]
    ADD CONSTRAINT [FK_Products_Suppliers]
    FOREIGN KEY ([SupplierId])
    REFERENCES [dbo].[Suppliers]([SupplierId]);
PRINT 'Added FK_Products_Suppliers';
END
GO

-- Inventory constraints
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Inventory_Products')
BEGIN
ALTER TABLE [dbo].[Inventory]
    ADD CONSTRAINT [FK_Inventory_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]([ProductId]);
PRINT 'Added FK_Inventory_Products';
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Inventory_Locations')
BEGIN
ALTER TABLE [dbo].[Inventory]
    ADD CONSTRAINT [FK_Inventory_Locations]
    FOREIGN KEY ([LocationId])
    REFERENCES [dbo].[Locations]([LocationId]);
PRINT 'Added FK_Inventory_Locations';
END
GO

-- InventoryTransactions constraints
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_InventoryTransactions_Products')
BEGIN
ALTER TABLE [dbo].[InventoryTransactions]
    ADD CONSTRAINT [FK_InventoryTransactions_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]([ProductId]);
PRINT 'Added FK_InventoryTransactions_Products';
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_InventoryTransactions_Locations')
BEGIN
ALTER TABLE [dbo].[InventoryTransactions]
    ADD CONSTRAINT [FK_InventoryTransactions_Locations]
    FOREIGN KEY ([LocationId])
    REFERENCES [dbo].[Locations]([LocationId]);
PRINT 'Added FK_InventoryTransactions_Locations';
END
GO

-- PurchaseOrders constraints (when you add them back)
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'PurchaseOrders')
AND NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseOrders_Suppliers')
BEGIN
ALTER TABLE [dbo].[PurchaseOrders]
    ADD CONSTRAINT [FK_PurchaseOrders_Suppliers]
    FOREIGN KEY ([SupplierId])
    REFERENCES [dbo].[Suppliers]([SupplierId]);
PRINT 'Added FK_PurchaseOrders_Suppliers';
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'PurchaseOrderItems')
AND NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseOrderItems_Products')
BEGIN
ALTER TABLE [dbo].[PurchaseOrderItems]
    ADD CONSTRAINT [FK_PurchaseOrderItems_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]([ProductId]);
PRINT 'Added FK_PurchaseOrderItems_Products';
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'PurchaseOrderItems')
AND NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_PurchaseOrderItems_PurchaseOrders')
BEGIN
ALTER TABLE [dbo].[PurchaseOrderItems]
    ADD CONSTRAINT [FK_PurchaseOrderItems_PurchaseOrders]
    FOREIGN KEY ([PurchaseOrderId])
    REFERENCES [dbo].[PurchaseOrders]([PurchaseOrderId]);
PRINT 'Added FK_PurchaseOrderItems_PurchaseOrders';
END
GO

PRINT 'All constraints added successfully.';
GO