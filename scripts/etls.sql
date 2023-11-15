use adw;

INSERT INTO adventureWorksDW.DimProducto(
    ProductID,
    SubCategoria,
    Categoria
)
SELECT ProductID, ppsc.name AS SubCatName , ppc.name AS CatName
FROM Production_Product p
INNER JOIN Production_ProductSubcategory ppsc ON p.ProductSubcategoryID = ppsc.ProductSubcategoryID
INNER JOIN Production_ProductCategory ppc on ppsc.ProductCategoryID = ppc.ProductCategoryID;


INSERT INTO adventureWorksDW.DimTienda(
    ID_Tienda,
    Nombre,
    Demograficos
)
SELECT BusinessEntityID,Name,Demographics
FROM Sales_Store;

INSERT INTO adventureWorksDW.DimCliente(
    ID_Cliente,
    Tienda,
    Ciudad_Pais
)
SELECT sc.CustomerID,ss.name, sst.name 
FROM Sales_Customer sc
INNER JOIN Sales_SalesTerritory sst on sst.TerritoryID = sc.TerritoryID
INNER JOIN Sales_Store ss on sc.StoreID = ss.BusinessEntityID;


INSERT INTO adventureWorksDW.DimFecha (
    OrderFecha,
    Mes,
    Anio
)
SELECT 
    DISTINCT DATE(OrderDate) as Fecha,
    EXTRACT(MONTH FROM OrderDate) AS Mes,
    EXTRACT(YEAR FROM OrderDate) AS Ano
FROM adw.Sales_SalesOrderHeader;


INSERT INTO adventureWorksDW.FactVentas(
    FK_Producto,
    FK_Fecha,
    FK_Cliente,
    FK_Tienda,
    Unidades,
    Ingresos,
    Ganancia
)
SELECT 
    dwdimProducto.KEY_Producto,
    dwdimFecha.KEY_Fecha,
    dwdimcliente.KEY_Cliente, 
    dwdimTienda.KEY_TIENDA,
    ssod.OrderQty,
    SUM(ssod.LineTotal) AS Ingresos,
    SUM(ssod.UnitPrice * ssod.OrderQty) - SUM(pp.StandardCost * ssod.OrderQty) AS Ganancia
FROM 
    Sales_SalesOrderHeader ssoh
INNER JOIN 
    Sales_SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
INNER JOIN 
    Sales_Customer sc ON sc.CustomerID = ssoh.CustomerID
INNER JOIN 
    Sales_Store ss ON sc.StoreID = ss.BusinessEntityID
INNER JOIN 
    Production_Product pp ON ssod.ProductID = pp.ProductID
INNER JOIN 
    adventureWorksDW.DimFecha dwdimFecha ON dwdimFecha.OrderFecha = DATE(ssoh.OrderDate)
INNER JOIN 
    adventureWorksDW.DimCliente dwdimcliente ON ssoh.CustomerID = dwdimcliente.ID_Cliente
INNER JOIN 
    adventureWorksDW.DimProducto dwdimProducto ON ssod.ProductID = dwdimProducto.ProductID
INNER JOIN 
    adventureWorksDW.DimTienda dwdimTienda ON ss.BusinessEntityID = dwdimTienda.ID_TIENDA
GROUP BY 
    ssoh.SalesOrderID, ssod.ProductID, ssoh.SubTotal, ssod.OrderQty, dwdimFecha.KEY_Fecha, 
    ssoh.CustomerID, dwdimcliente.KEY_Cliente, dwdimProducto.KEY_Producto, dwdimTienda.KEY_TIENDA;


SELECT * FROM adventureWorksDW.DimProducto LIMIT 100;
SELECT KEY_TIENDA, ID_TIENDA, NOMBRE FROM adventureWorksDW.DimTienda limit 100;
SELECT * FROM adventureWorksDW.DimCliente limit 100;
SELECT * FROM adventureWorksDW.DimFecha LIMIT 100;
SELECT * FROM adventureWorksDW.FactVentas LIMIT 100;

SELECT ID_Ventas, FK_Producto, DISTINCT(FK_Fecha), FK_Cliente, FK_Cliente, Unidades, Ingresos, Ganancia FROM adventureWorksDW.FactVentas LIMIT 100;