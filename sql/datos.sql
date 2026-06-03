USE `nexshop_db`;

-- =============================================================================
-- 0. LIMPIEZA PREVIA DE CONTROL REPRODUCIBLE
-- =============================================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Direcciones_Clientes;
TRUNCATE TABLE Clientes;
TRUNCATE TABLE Productos;
TRUNCATE TABLE Subcategorias;
TRUNCATE TABLE Categorias;
TRUNCATE TABLE Sedes;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- 1. TABLA: Sedes (Madrid, Valencia, Barcelona y Canal Online)
-- =============================================================================
INSERT INTO Sedes (id_sede, nombre, ciudad, tipo) VALUES
(1, 'Central Logística y Tienda Web NexShop', 'Madrid', 'Almacen'), -- Nodo e-commerce
(2, 'Tienda Física NexShop Gran Vía', 'Madrid', 'Tienda'),
(3, 'Almacén Regulador Zona Centro', 'Madrid', 'Almacen'),
(4, 'Tienda Física NexShop Plaza Catalunya', 'Barcelona', 'Tienda'),
(5, 'Almacén Logístico Nordeste', 'Barcelona', 'Almacen'),
(6, 'Tienda Física NexShop Diagonal', 'Barcelona', 'Tienda'),
(7, 'Tienda Física NexShop Calle Colón', 'Valencia', 'Tienda'),
(8, 'Almacén Suministros Levante', 'Valencia', 'Almacen'),
(9, 'Tienda Física NexShop Ruzafa', 'Valencia', 'Tienda'),
(10, 'Punto de Recogida Transaccional Sants', 'Barcelona', 'Tienda');

-- =============================================================================
-- 2. TABLA: Categorias (10 Categorías de Hardware y Tecnología Real)
-- =============================================================================
INSERT INTO Categorias (id_categoria, nombre) VALUES
(1, 'Procesadores y CPU'),
(2, 'Tarjetas Gráficas (GPU)'),
(3, 'Placas Base y Placas Base Servidor'),
(4, 'Memoria RAM'),
(5, 'Almacenamiento Digital'),
(6, 'Sistemas de Refrigeración'),
(7, 'Fuentes de Alimentación'),
(8, 'Portátiles y Equipos'),
(9, 'Periféricos y Controladores'),
(10, 'Redes e Infraestructura');

-- =============================================================================
-- 3. TABLA: Subcategorias (10 Subcategorías específicas del sector)
-- =============================================================================
INSERT INTO Subcategorias (id_subcategoria, nombre, id_categoria) VALUES
(1, 'Procesadores de Consumo e hilos', 1),
(2, 'Gráficas Gaming dedicadas', 2),
(3, 'Placas Base ATX / ITX', 3),
(4, 'Módulos RAM DDR5', 4),
(5, 'Discos SSD NVMe M.2 PCIe 4.0/5.0', 5),
(6, 'Refrigeraciones Líquidas AIO', 6),
(7, 'Fuentes Modulares Certificadas', 7),
(8, 'Portátiles de Alto Rendimiento', 8),
(9, 'Teclados Mecánicos Estructurales', 9),
(10, 'Switches e Infraestructura de Red', 10);

-- =============================================================================
-- 4. TABLA: Productos (10 Componentes de Hardware Real con Precios de Mercado)
-- =============================================================================
INSERT INTO Productos (id_producto, referencia, nombre, pvp_actual, id_subcategoria) VALUES
(1, 'AMD-RYZ-7800X3D', 'Procesador AMD Ryzen 7 7800X3D 4.2GHz 8-Cores', 399.95, 1),
(2, 'MSI-RTX-4070S-V', 'Tarjeta Gráfica MSI NVIDIA GeForce RTX 4070 Super Ventus 2X 12GB', 629.90, 2),
(3, 'ASU-ROG-B650E-F', 'Placa Base ASUS ROG STRIX B650E-F GAMING WIFI AM5', 245.50, 3),
(4, 'COR-VEN-DDR5-32', 'Memoria RAM Corsair Vengeance DDR5 6000MHz 32GB 2x16GB CL30', 119.99, 4),
(5, 'WD-BLK-SN850X-2', 'Disco SSD WD Black SN850X 2TB NVMe M.2 PCIe Gen4', 164.00, 5),
(6, 'COR-ICU-H150I-E', 'Refrigeración Líquida Corsair iCUE LINK H150i RGB 360mm', 189.90, 6),
(7, 'COR-RM-850X-MOD', 'Fuente Alimentación Corsair RM850x 850W 80 Plus Gold Modular', 134.95, 7),
(8, 'MSI-VEC-GP77-13', 'Portátil MSI Vector GP77 13VG Intel i7 16GB 1TB RTX 4070', 1699.00, 8),
(9, 'LOG-GPR-XSUP-B', 'Teclado Mecánico Logitech G Pro X Superlight Switch GX Brown', 149.00, 9),
(10, 'UBI-USW-ULT-G1', 'Switch Administrable Ubiquiti UniFi Ultra de 8 Puertos Gigabit', 159.95, 10);

-- =============================================================================
-- 5. TABLA: Clientes (10 Usuarios de Pruebas con Saldo Inicial a Cero)
-- =============================================================================
INSERT INTO Clientes (id_cliente, nombre, apellidos, email, contrasena, fecha_nacimiento, es_registrado, saldo_puntos_actual) VALUES
(1, 'Sergio', 'Barroso Milan', 'barrosomilansergio@gmail.com', '$2b$12$KqZmx8O34fG...', '1977-05-12', 1, 0),
(2, 'Alejandro', 'Gómez Ruiz', 'alejandro.gomez@gmail.com', '$2b$12$HwPlm9O91fX...', '1985-08-24', 1, 0),
(3, 'María', 'Fernández Soto', 'maria.fer90@hotmail.com', '$2b$12$JqTnx2X45vM...', '1990-11-03', 1, 0),
(4, 'Carlos', 'Martínez Vega', 'carlos.mtnz@yahoo.es', '$2b$12$LpWmx5Z88kB...', '1982-03-15', 1, 0),
(5, 'Laura', 'Sancho Ortiz', 'laura.sancho@outlook.com', '$2b$12$MnQrx3Y11pL...', '1995-07-29', 1, 0),
(6, 'David', 'Navarro Peña', 'david.nav@gmail.com', '$2b$12$OpVtx7B22nQ...', '1988-01-20', 1, 0),
(7, 'Ana', 'Blanco Carrasco', 'ana.blanco@icloud.com', '$2b$12$PxKmx1C33tW...', '1993-09-14', 1, 0),
(8, 'Javier', 'López Medina', 'javi.lopez.med@gmail.com', '$2b$12$QxLnx9V44rP...', '1979-04-02', 1, 0),
(9, 'Elena', 'Vargas Castro', 'elena.vargas@gmail.com', '$2b$12$RxMnx4W55zT...', '2001-12-05', 1, 0),
(10, 'Manuel', 'Soler Delgado', 'manuel.soler@outlook.es', '$2b$12$SxNnx6Q66xV...', '1984-06-18', 1, 0);

-- =============================================================================
-- 6. TABLA: Direcciones_Clientes (10 Ubicaciones alineadas por Código Postal)
-- =============================================================================
INSERT INTO Direcciones_Clientes (id_direccion, tipo_direccion, calle, numero, piso, codigo_postal, city, pais, id_cliente) VALUES
(1, 'Principal', 'Paseo de la Castellana', '120', '2ºB', '28046', 'Madrid', 'España', 1), -- Sergio Casa
(2, 'Trabajo', 'Gran Vía', '32', '4º Centro', '28013', 'Madrid', 'España', 1),      -- Sergio Oficina
(3, 'Principal', 'Carrer de Mallorca', '250', '1ºA', '08008', 'Barcelona', 'España', 2),
(4, 'Principal', 'Calle Colón', '15', '3º 4ª', '46004', 'Valencia', 'España', 3),
(5, 'Principal', 'Avinguda Diagonal', '400', 'Bajo B', '08037', 'Barcelona', 'España', 4),
(6, 'Principal', 'Calle de Alcalá', '88', '5ºD', '28009', 'Madrid', 'España', 5),
(7, 'Principal', 'Carrer de Sants', '102', '2º 1ª', '08028', 'Barcelona', 'España', 6),
(8, 'Principal', 'Calle de la Paz', '4', 'Principal', '46003', 'Valencia', 'España', 7),
(9, 'Principal', 'Avenida Blasco Ibáñez', '74', 'Apt 12', '46021', 'Valencia', 'España', 8),
(10, 'Principal', 'Calle Gran Vía', '612', '3ºB', '28003', 'Madrid', 'España', 9);