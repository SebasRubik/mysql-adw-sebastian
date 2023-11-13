/*Ventas Totales por Categoría de Producto*/
SELECT 
    dp.Categoria,
    SUM(fv.Ingresos) AS VentasTotales
FROM 
    adventureWorksDW.FactVentas fv
JOIN 
    adventureWorksDW.DimProducto dp ON fv.FK_Producto = dp.KEY_Producto
GROUP BY 
    dp.Categoria;

/*Ganancia Total por Tienda*/
SELECT 
    dt.Nombre AS NombreTienda,
    SUM(fv.Ganancia) AS GananciaTotal
FROM 
    adventureWorksDW.FactVentas fv
JOIN 
    adventureWorksDW.DimTienda dt ON fv.FK_Tienda = dt.KEY_TIENDA
GROUP BY 
    dt.Nombre;

/*Número de Unidades Vendidas por Mes y Año*/
SELECT 
    df.Mes,
    df.Anio,
    SUM(fv.Unidades) AS UnidadesVendidas
FROM 
    adventureWorksDW.FactVentas fv
JOIN 
    adventureWorksDW.DimFecha df ON fv.FK_Fecha = df.KEY_Fecha
GROUP BY 
    df.Mes, df.Anio
ORDER BY 
    df.Anio, df.Mes;

/*Ventas Totales por Cliente y Ciudad*/
SELECT 
    dc.ID_Cliente,
    dc.Ciudad_Pais,
    SUM(fv.Ingresos) AS VentasTotales
FROM 
    adventureWorksDW.FactVentas fv
JOIN 
    adventureWorksDW.DimCliente dc ON fv.FK_Cliente = dc.KEY_Cliente
GROUP BY 
    dc.ID_Cliente, dc.Ciudad_Pais;

/*Análisis de Ventas y Ganancias por Fecha*/
SELECT 
    df.OrderFecha,
    SUM(fv.Ingresos) AS VentasTotales,
    SUM(fv.Ganancia) AS GananciaTotal
FROM 
    adventureWorksDW.FactVentas fv
JOIN 
    adventureWorksDW.DimFecha df ON fv.FK_Fecha = df.KEY_Fecha
GROUP BY 
    df.OrderFecha;