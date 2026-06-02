SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `nexshop_db` DEFAULT CHARACTER SET utf8mb4 ;
USE `nexshop_db` ;

-- -----------------------------------------------------
-- Tabla `Sedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sedes` (
  `id_sede` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `tipo` ENUM('Tienda', 'Almacen') NOT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(12) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `email_corporativo` VARCHAR(100) NOT NULL,
  `fecha_incorporacion` DATE NOT NULL,
  `rol_cargo` ENUM('Encargado', 'Vendedor', 'Responsable Almacen', 'Agente Atencion', 'Logistica', 'Compras') NOT NULL,
  `id_sede` INT NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC),
  UNIQUE INDEX `email_corp_UNIQUE` (`email_corporativo` ASC),
  CONSTRAINT `fk_Empleados_Sedes`
    FOREIGN KEY (`id_sede`)
    REFERENCES `Sedes` (`id_sede`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categorias` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Subcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Subcategorias` (
  `id_subcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_subcategoria`),
  CONSTRAINT `fk_Subcategorias_Categorias`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `Categorias` (`id_categoria`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `referencia` VARCHAR(150) NOT NULL,
  `nombre` VARCHAR(200) NOT NULL,
  `pvp_actual` DECIMAL(10,2) NOT NULL,
  `id_subcategoria` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE INDEX `referencia_UNIQUE` (`referencia` ASC),
  CONSTRAINT `fk_Productos_Subcategorias`
    FOREIGN KEY (`id_subcategoria`)
    REFERENCES `Subcategorias` (`id_subcategoria`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Historico_precios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Historico_precios` (
  `id_historico_precio` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(10,2) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_historico_precio`),
  CONSTRAINT `fk_Historico_precios_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Promociones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Promociones` (
  `id_promocion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descuento_porcentaje` DECIMAL(5,2) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  PRIMARY KEY (`id_promocion`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Promociones_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Promociones_productos` (
  `id_promocion` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_promocion`, `id_producto`),
  CONSTRAINT `fk_Prom_Prod_Promociones`
    FOREIGN KEY (`id_promocion`)
    REFERENCES `Promociones` (`id_promocion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prom_Prod_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveedores` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `id_empleado_representante` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  CONSTRAINT `fk_Proveedores_Empleados`
    FOREIGN KEY (`id_empleado_representante`)
    REFERENCES `Empleados` (`id_empleado`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Condiciones_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condiciones_proveedor` (
  `id_condicion` INT NOT NULL AUTO_INCREMENT,
  `precio_coste` DECIMAL(10,2) NOT NULL,
  `plazo_entrega_dias` INT NOT NULL,
  `fecha_negociacion` DATE NOT NULL,
  `id_producto` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_condicion`),
  CONSTRAINT `fk_Condiciones_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Condiciones_Proveedores`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `Proveedores` (`id_proveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Stock_ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stock_ubicacion` (
  `cantidad` INT NOT NULL DEFAULT 0,
  `id_producto` INT NOT NULL,
  `id_sede` INT NOT NULL,
  PRIMARY KEY (`id_producto`, `id_sede`),
  CONSTRAINT `fk_Stock_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Stock_Sedes`
    FOREIGN KEY (`id_sede`)
    REFERENCES `Sedes` (`id_sede`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `apellidos` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `contrasena` VARCHAR(255) NULL,
  `fecha_nacimiento` DATE NULL,
  `es_registrado` TINYINT NOT NULL DEFAULT 0,
  `saldo_puntos_actual` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Direcciones_Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Direcciones_Clientes` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `tipo_direccion` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `piso` VARCHAR(20) NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  CONSTRAINT `fk_Direcciones_Clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Clientes` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Pedidos_online`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedidos_online` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATETIME NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `fk_Pedidos_Clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Clientes` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedidos_Direcciones`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `Direcciones_Clientes` (`id_direccion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Lineas_pedidos_online`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Lineas_pedidos_online` (
  `cantidad` INT NOT NULL,
  `precio_unitario_aplicado` DECIMAL(10,2) NOT NULL,
  `id_pedido` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_producto`),
  CONSTRAINT `fk_LinesPed_Pedidos`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `Pedidos_online` (`id_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LinesPed_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Envios` (
  `id_envio` INT NOT NULL AUTO_INCREMENT,
  `numero_seguimiento` VARCHAR(100) NOT NULL,
  `transportista` VARCHAR(50) NOT NULL,
  `fecha_estimada_entrega` DATE NOT NULL,
  `id_pedido` INT NOT NULL,
  `id_sede_origen` INT NOT NULL,
  PRIMARY KEY (`id_envio`),
  CONSTRAINT `fk_Envios_Pedidos`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `Pedidos_online` (`id_pedido`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Envios_Sedes`
    FOREIGN KEY (`id_sede_origen`)
    REFERENCES `Sedes` (`id_sede`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Lineas_envio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Lineas_envio` (
  `cantidad_enviada` INT NOT NULL,
  `id_envio` INT NOT NULL,
  `id_pedido` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_envio`, `id_pedido`, `id_producto`),
  CONSTRAINT `fk_LinesEnv_Envios`
    FOREIGN KEY (`id_envio`)
    REFERENCES `Envios` (`id_envio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LinesEnv_LinesPed`
    FOREIGN KEY (`id_pedido`, `id_producto`)
    REFERENCES `Lineas_pedidos_online` (`id_pedido`, `id_producto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Ventas_presenciales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ventas_presenciales` (
  `id_ticket` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATETIME NOT NULL,
  `id_sede` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `id_cliente` INT NULL,
  PRIMARY KEY (`id_ticket`),
  CONSTRAINT `fk_Ventas_Sedes`
    FOREIGN KEY (`id_sede`)
    REFERENCES `Sedes` (`id_sede`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventas_Empleados`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `Empleados` (`id_empleado`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventas_Clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Clientes` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Lineas_ticket_presencial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Lineas_ticket_presencial` (
  `cantidad` INT NOT NULL,
  `precio_unitario_aplicado` DECIMAL(10,2) NOT NULL,
  `id_ticket` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_ticket`, `id_producto`),
  CONSTRAINT `fk_LinesTick_Ventas`
    FOREIGN KEY (`id_ticket`)
    REFERENCES `Ventas_presenciales` (`id_ticket`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LinesTick_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Devoluciones_presenciales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Devoluciones_presenciales` (
  `id_devolucion` INT NOT NULL AUTO_INCREMENT,
  `fecha_devolucion` DATETIME NOT NULL,
  `motivo` VARCHAR(255) NOT NULL,
  `id_ticket` INT NOT NULL,
  PRIMARY KEY (`id_devolucion`),
  CONSTRAINT `fk_Devoluciones_Ventas`
    FOREIGN KEY (`id_ticket`)
    REFERENCES `Ventas_presenciales` (`id_ticket`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Tickets_incidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tickets_incidencia` (
  `id_ticket_incidencia` INT NOT NULL AUTO_INCREMENT,
  `asunto` VARCHAR(150) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_apertura` DATETIME NOT NULL,
  `estado` ENUM('abierto', 'en gestion', 'resuelto') NOT NULL,
  `nota_resolucion` TEXT NULL,
  `fecha_cierre` DATETIME NULL,
  `id_empleado_agent` INT NOT NULL,
  `id_pedido` INT NULL,
  PRIMARY KEY (`id_ticket_incidencia`),
  CONSTRAINT `fk_Incidencias_Empleados`
    FOREIGN KEY (`id_empleado_agent`)
    REFERENCES `Empleados` (`id_empleado`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Incidencias_Pedidos`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `Pedidos_online` (`id_pedido`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Valoraciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Valoraciones` (
  `id_valoracion` INT NOT NULL AUTO_INCREMENT,
  `puntuacion` INT NOT NULL,
  `comentario` TEXT NULL,
  `es_verificada` TINYINT NOT NULL DEFAULT 0,
  `id_cliente` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_valoracion`),
  UNIQUE INDEX `client_prod_UNIQUE` (`id_cliente` ASC, `id_producto` ASC),
  CONSTRAINT `fk_Valoraciones_Clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Clientes` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Valoraciones_Productos`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Productos` (`id_producto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT chk_puntuacion CHECK (puntuacion BETWEEN 1 AND 5)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `Movimientos_puntos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movimientos_puntos` (
  `id_movimiento` INT NOT NULL AUTO_INCREMENT,
  `cantidad_puntos` INT NOT NULL,
  `tipo_movimiento` ENUM('ganados', 'canjeados') NOT NULL,
  `fecha_movimiento` DATETIME NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_pedido` INT NULL,
  PRIMARY KEY (`id_movimiento`),
  CONSTRAINT `fk_Puntos_Clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Clientes` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Puntos_Pedidos`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `Pedidos_online` (`id_pedido`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;