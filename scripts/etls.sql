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




SELECT * FROM adventureWorksDW.DimProducto;
SELECT KEY_TIENDA, ID_TIENDA, NOMBRE FROM adventureWorksDW.DimTienda limit 10;
SELECT * FROM adventureWorksDW.DimCliente limit 10;
SELECT * FROM adventureWorksDW.DimFecha LIMIT 10;

