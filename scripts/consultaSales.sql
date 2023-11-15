use adw;

SELECT 
    ssoh.SalesOrderID,
    ssod.ProductID, 
    ssoh.SubTotal, 
    ssod.OrderQty,
    SUM(ssod.LineTotal) AS Ganancia,
    SUM(ssod.UnitPrice * ssod.OrderQty) - SUM(pp.StandardCost * ssod.OrderQty) AS Ganancia,  
    dwdimFecha.KEY_Fecha, 
    ssoh.CustomerID,
    dwdimcliente.KEY_Cliente, 
    ssod.ProductID, 
    dwdimProducto.KEY_Producto,
    dwdimTienda.KEY_TIENDA
FROM Sales_SalesOrderHeader ssoh
INNER JOIN Sales_SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN Sales_Customer sc ON sc.CustomerID = ssoh.CustomerID
INNER JOIN Sales_Store ss ON sc.StoreID = ss.BusinessEntityID
INNER JOIN Production_Product pp ON ssod.ProductID = pp.ProductID
INNER JOIN adventureWorksDW.DimFecha dwdimFecha ON dwdimFecha.OrderFecha = DATE(ssoh.OrderDate)
INNER JOIN adventureWorksDW.DimCliente dwdimcliente ON ssoh.CustomerID = dwdimcliente.ID_Cliente
INNER JOIN adventureWorksDW.DimProducto dwdimProducto ON ssod.ProductID = dwdimProducto.ProductID
INNER JOIN adventureWorksDW.DimTienda dwdimTienda ON ss.BusinessEntityID = dwdimTienda.ID_TIENDA
GROUP BY ssoh.SalesOrderID, ssod.ProductID, ssoh.SubTotal, ssod.OrderQty, dwdimFecha.KEY_Fecha, 
ssoh.CustomerID, dwdimcliente.KEY_Cliente, dwdimProducto.KEY_Producto, dwdimTienda.KEY_TIENDA
LIMIT 5;