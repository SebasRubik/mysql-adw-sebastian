/*CREATE DATABASE adventureWorksDW;*/
USE adventureWorksDW;

-- Tabla de Dimensiones - Producto

DROP TABLE IF EXISTS `FactVentas`;
DROP TABLE IF EXISTS `DimProducto`;
DROP TABLE IF EXISTS `DimTienda`;
DROP TABLE IF EXISTS `DimCliente`;
DROP TABLE IF EXISTS `DimFecha`;

CREATE TABLE DimProducto (
    KEY_Producto INT AUTO_INCREMENT PRIMARY KEY,
    ProductID int(11),
    SubCategoria VARCHAR(100),
    Categoria VARCHAR(100)
);

-- Tabla de Dimensiones - Tienda
CREATE TABLE DimTienda (
    KEY_Tienda INT AUTO_INCREMENT PRIMARY KEY,
    ID_Tienda int(11),
    Nombre VARCHAR(100),
    Demograficos text
);

-- Tabla de Dimensiones - Cliente
CREATE TABLE DimCliente (
    KEY_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente VARCHAR(255),
    Tienda VARCHAR(255),
    Ciudad_Pais VARCHAR(255)
);

-- Tabla de Dimensiones - Fecha
CREATE TABLE DimFecha (
    KEY_Fecha INT AUTO_INCREMENT PRIMARY KEY,
    OrdeFecha TIMESTAMP,
    Mes INT,
    Anio INT
);

-- Tabla de Hechos - Ventas
CREATE TABLE FactVentas (
    ID_Ventas INT AUTO_INCREMENT PRIMARY KEY,
    FK_Producto INT,
    FK_Fecha INT,
    FK_Cliente INT,
    FK_Tienda INT,
    Unidades INT,
    Ingresos DECIMAL(10,2),
    Ganancia DECIMAL(10,2),
    FOREIGN KEY (FK_Producto) REFERENCES DimProducto(KEY_Producto),
    FOREIGN KEY (FK_Fecha) REFERENCES DimFecha(KEY_Fecha),
    FOREIGN KEY (FK_Cliente) REFERENCES DimCliente(KEY_Cliente),
    FOREIGN KEY (FK_Tienda) REFERENCES DimTienda(KEY_Tienda)
);

