
-- - Crear una base de datos-----------------------------------------------------------------
CREATE DATABASE sprint_m5

-- - Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'usuario_sprint_m5'@'localhost' IDENTIFIED BY 'usuario_sprint_m5';
GRANT ALL PRIVILEGES ON sprint_m5.* TO 'usuario_sprint_m5'@'localhost';

-- Verificar el usuario
SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'usuario_sprint_m5'@'localhost';




-- Creación de la tabla Proveedor
CREATE TABLE Proveedor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  representante_legal VARCHAR(50) NOT NULL,
  nombre_corporativo VARCHAR(50) NOT NULL,
  mail  VARCHAR(40) NOT NULL 
);

-- INSERT INTO Proveedor
-- Realizamos un truncate table para que comience el ID en 1
TRUNCATE TABLE Proveedor;

START TRANSACTION;
INSERT INTO Proveedor (nombre, representante_legal, nombre_corporativo, mail)
VALUES 
  ('Proveedor1', 'Representante1', 'Corporativo1', 'proveedor1@mail.com'),
  ('Proveedor2', 'Representante2', 'Corporativo2', 'proveedor2@mail.com'),
  ('Proveedor3', 'Representante3', 'Corporativo3', 'proveedor3@mail.com'),
  ('Proveedor4', 'Representante4', 'Corporativo4', 'proveedor4@mail.com'),
  ('Proveedor5', 'Representante5', 'Corporativo5', 'proveedor5@mail.com');

COMMIT;


-- Creación de la tabla telefono_Proveedor
CREATE TABLE telefono_Proveedor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  proveedor_id INT,
  telefono VARCHAR(13) NOT NULL,
  nombre_contacto VARCHAR(50),
  FOREIGN KEY (proveedor_id) REFERENCES Proveedor(id)
);

INSERT INTO telefono_Proveedor (proveedor_id, telefono, nombre_contacto)
VALUES (1, '555-123-4567', 'Juan Pérez'),
       (2, '555-987-6543', 'María Gómez'),
       (3, '555-456-7890', 'Carlos Rodríguez'),
       (4, '555-789-0123', 'Ana López'),
       (5, '555-234-5678', 'Pedro Martínez');


-- Creación de la tabla Categoria
CREATE TABLE Categoria (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

-- INSERT

START TRANSACTION;
INSERT INTO Categoria (nombre)
VALUES ('Smartphones'),
       ('Computadoras'),
       ('Electrónica'),
       ('Software'),
       ('Accesorios');

COMMIT;
-- Creación de la tabla Cliente
CREATE TABLE Cliente (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(75) NOT NULL,
  apellido VARCHAR(75) NOT NULL,
  direccion VARCHAR(100) NOT NULL
);

-- INSERT INTO Cliente 
START TRANSACTION;
INSERT INTO Cliente (nombre, apellido, direccion)
VALUES 
  ('Cliente1', 'Apellido1', 'Dirección1'),
  ('Cliente2', 'Apellido2', 'Dirección2'),
  ('Cliente3', 'Apellido3', 'Dirección3'),
  ('Cliente4', 'Apellido4', 'Dirección4'),
  ('Cliente5', 'Apellido5', 'Dirección5');

COMMIT;

-- Creación de la tabla Producto
CREATE TABLE Producto (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  precio INT NOT NULL,
  categoria_id INT,
  proveedor_id INT,
  color VARCHAR(50),
  stock INT NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES Categoria(id),
  FOREIGN KEY (proveedor_id) REFERENCES Proveedor(id)
);

START TRANSACTION;

INSERT INTO Producto (nombre, precio, categoria_id, proveedor_id, color, stock)
VALUES 
  ('Smartphone Samsung Galaxy S21', 1000, 1, 1, 'Negro', 10),
  ('Laptop HP Pavilion', 1500, 2, 2, 'Plata', 5),
  ('Smartwatch Apple Watch Series 6', 800, 1, 3, 'Blanco', 20),
  ('TV LG OLED55C1', 2000, 3, 4, 'Gris', 15),
  ('Tablet Samsung Galaxy Tab S7', 1200, 2, 1, 'Azul', 8),
  ('Cámara Canon EOS R5', 1800, 1, 2, 'Rojo', 5),
  ('Auriculares Sony WH-1000XM4', 900, 3, 3, 'Negro', 6),
  ('Monitor Dell UltraSharp U2719D', 2500, 2, 4, 'Plata', 10),
  ('Altavoz Bluetooth JBL Charge 4', 1300, 1, 1, 'Negro', 7),
  ('Mouse Logitech MX Master 3', 1600, 2, 3, 'Gris', 9);

COMMIT;

DESCRIBE producto

--  Cuál es la categoría de productos que más se repite.
START TRANSACTION;
SELECT Producto.nombre, Producto.categoria_id, COUNT(Producto.id) AS repeticiones
FROM Producto
INNER JOIN categoria ON Producto.categoria_id = categoria.id
GROUP BY Producto.categoria_id
ORDER BY repeticiones DESC;
COMMIT;

-- Cuáles son los productos con mayor stock
START TRANSACTION;
SELECT * from producto ORDER BY stock desc;
COMMIT;

-- Qué color de producto es más común en nuestra tienda.
START TRANSACTION;
SELECT * ,COUNT(*)as repeticion from producto GROUP BY color ORDER BY repeticion desc;
COMMIT;

-- Cual o cuales son los proveedores con menor stock de productos.
START TRANSACTION;
select producto.id,producto.nombre,producto.stock,producto.proveedor_id,proveedor.nombre
from producto
INNER JOIN proveedor ON Producto.proveedor_id=proveedor.id
 ORDER BY producto.stock asc;
 COMMIT;
-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
START TRANSACTION;
UPDATE categoria
set nombre='Electrónica y computación' WHERE id=1 or id=2 or id=3;
COMMIT;

