use adw;


-- Ventas x Ubicacion
SELECT 
    S.SalesOrderID, 
    S.OrderDate,
    ST.Name AS Territorio,
    SP.Name AS Estado,
    A.City AS Ciudad,
    SUM(D.LineTotal) AS TotalSales
FROM 
    Sales_SalesOrderHeader S
INNER JOIN Sales_SalesTerritory ST ON S.TerritoryID = ST.TerritoryID
INNER JOIN Person_Address A ON S.ShipToAddressID = A.AddressID
INNER JOIN Person_StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
INNER JOIN Sales_SalesOrderDetail D ON S.SalesOrderID = D.SalesOrderID
GROUP BY 
    S.SalesOrderID, 
    S.OrderDate, 
    ST.Name, 
    SP.Name, 
    A.AddressLine1, 
    A.City
ORDER BY 
    S.OrderDate DESC
limit 5;


-- Ventas x Producto

SELECT 
    P.ProductID,
    P.Name AS NombreProducto,
    SUM(D.OrderQty) AS TotalQtyVendida,
    SUM(D.LineTotal) AS VentasTotales
FROM 
    Sales_SalesOrderDetail D
JOIN 
    Production_Product P ON D.ProductID = P.ProductID
GROUP BY 
    P.ProductID, 
    P.Name
limit 5;

-- Ventas x persona
