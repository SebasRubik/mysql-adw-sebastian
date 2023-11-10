use adw;

SELECT ssoh.SalesOrderID , ssoh.OrderDate, DATE(OrderDate) as Fecha, ssoh.CustomerID,dwdimcliente.KEY_Cliente, ssod.SalesOrderDetailID, ssod.ProductID, dwdimProducto.KEY_Producto
FROM Sales_SalesOrderHeader ssoh
INNER JOIN Sales_SalesOrderDetail ssod  ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN adventureWorksDW.DimCliente dwdimcliente on  ssoh.CustomerID = dwdimcliente.ID_Cliente
INNER JOIN adventureWorksDW.DimProducto dwdimProducto on ssod.ProductID = dwdimProducto.ProductID
LIMIT 5;

