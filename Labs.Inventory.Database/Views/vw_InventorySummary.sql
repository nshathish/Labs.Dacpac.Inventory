-- Views/vw_InventorySummary.sql
CREATE VIEW [dbo].[vw_InventorySummary]
AS
SELECT
    p.ProductId,
    p.SKU,
    p.ProductName,
    c.CategoryName,
    s.SupplierName,
    SUM(i.QuantityOnHand) as TotalQuantityOnHand,
    SUM(i.QuantityReserved) as TotalQuantityReserved,
    SUM(i.QuantityAvailable) as TotalQuantityAvailable,
    p.UnitPrice,
    p.ReorderLevel,
    p.MinimumStock,
    CASE WHEN SUM(i.QuantityAvailable) <= p.ReorderLevel THEN 1 ELSE 0 END as NeedsReorder
FROM
    dbo.Products p
        INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
        LEFT JOIN dbo.Suppliers s ON p.SupplierId = s.SupplierId
        LEFT JOIN dbo.Inventory i ON p.ProductId = i.ProductId
WHERE
    p.IsActive = 1
GROUP BY
    p.ProductId, p.SKU, p.ProductName, c.CategoryName, s.SupplierName,
    p.UnitPrice, p.ReorderLevel, p.MinimumStock;