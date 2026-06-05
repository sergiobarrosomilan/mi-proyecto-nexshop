-- TODOS LOS PRODUCTOS --
SELECT * FROM Productos;

-- SE MUESTRAN NOMBRES, APELLIDOS Y MAIL DE LOS USUARIOS REGISTRADOS --
SELECT nombre, apellidos, email FROM Clientes WHERE es_registrado = 1;

-- SE MUESTRAN LOS NOMBRES QUE EMPIEZAN POR "A" --
SELECT id_cliente, nombre, apellidos, email 
FROM Clientes 
WHERE nombre LIKE 'A%';

-- SE MUESTRAN SOLO LOS PEDIDOS CON PAGO CONFIRMADO --
SELECT id_pedido, fecha_pedido, id_cliente, estado 
FROM Pedidos_online 
WHERE estado = 'Pago Confirmado';

-- FILTRADO POR PALABRA CLAVE "CORSAIR" --
SELECT referencia, nombre, pvp_actual FROM Productos WHERE nombre LIKE '%Corsair%';

-- FILTRADO PRODUCTOS POR RANGO DE FECHA --
SELECT id_pedido, fecha_pedido, estado FROM Pedidos_online 
WHERE fecha_pedido BETWEEN '2026-05-01 00:00:00' AND '2026-05-31 23:59:59';

-- FILTRADO PRODUCTOS POR RANGO DE PRECIO --
SELECT referencia, nombre, pvp_actual FROM Productos WHERE pvp_actual BETWEEN 150.00 AND 500.00;

-- FILTRADO CON CANTIDAD SUPERIOR A UN UMBRAL --
SELECT id_pedido, id_producto, cantidad, precio_unitario_aplicado FROM Lineas_pedidos_online 
WHERE cantidad > 1;

-- FILTRADO PEDIDOS ONLINE DE FORMA ASCENDENTE --
SELECT id_pedido, fecha_pedido, estado, id_cliente 
FROM Pedidos_online 
ORDER BY fecha_pedido ASC;

-- FILTRADO DE PRODUCTOS DE FORMA DESCENDENTE --
SELECT referencia, nombre, pvp_actual 
FROM Productos 
ORDER BY pvp_actual DESC;

-- FILTRADO DE CLIENTES POR NOMBRE EN ORDEN ASCENDENTE --
SELECT id_cliente, nombre, apellidos, email 
FROM Clientes 
ORDER BY nombre ASC;

-- CAMBIO DE CAMPO DE REGISTRO EN PEDIDOS ONLINE (ID_PEDIDO 3)
UPDATE Pedidos_online 
SET estado = 'Enviado' 
WHERE id_pedido = 3;

-- CONFIRMACION CAMBIO DE PEDIDO CAMPO ANTERIOR --
SELECT * FROM pedidos_online;

-- MODIFICAR EMAIL DE UN USUARIO USANDO SU MODIFICADOR --
UPDATE Clientes 
SET email = 'sergio.barroso.milan@gmail.com' 
WHERE id_cliente = 1;

-- CONFIRMACION CAMBIO DE MAIL DE CLIENTE --
SELECT * FROM clientes;

-- CONMBINAR DOS TABLAS RELACIONADAS MOSTRANDO CLIENTES Y ESTADO DE PEDIDOS --
SELECT 
    c.id_cliente,
    c.nombre,
    c.apellidos,
    p.id_pedido,
    p.fecha_pedido,
    p.estado
FROM Clientes c
INNER JOIN Pedidos_online p ON c.id_cliente = p.id_cliente;