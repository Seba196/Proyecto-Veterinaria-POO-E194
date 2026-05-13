----TABLAS----
--TABLA CATEGORIAS--
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

--TABLA PROVEEDORES--
CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    direccion TEXT
);

--TABLA USUARIOS--
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(50)  DEFAULT 'empleado'
);

--TABLA PRODUCTOS--
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10,2) NOT NULL,
    stock INT DEFAULT 0,
    fecha_vencimiento DATE,
    id_proveedor INT REFERENCES proveedores(id_proveedor),
    id_categoria INT REFERENCES categorias(id_categoria)
);

--TABLA MOVIMIENTOS DE STOCK--
CREATE TABLE movimientos_stock (
    id_movimiento SERIAL PRIMARY KEY,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('entrada','salida')),
    cantidad INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_producto INT REFERENCES productos(id_producto),
    id_usuario INT REFERENCES usuarios(id_usuario)
);



----DATOS DE PRUEBA----
--Categorías--
INSERT INTO categorias (nombre, descripcion) VALUES
('Medicamentos', 'Fármacos y tratamientos veterinarios'),
('Alimentos', 'Concentrados y suplementos alimenticios'),
('Insumos', 'Materiales médicos y quirúrgicos');

--Proveedores--
INSERT INTO proveedores (nombre, telefono, correo, direccion) VALUES
('Vetsuply S.A.', '6047001234', 'ventas@vetsuply.com', 'Cra 15 #20-30, Bucaramanga'),
('MediVet Ltda.', '6047005678', 'info@medivet.com', 'Cll 45 #10-20, Bucaramanga');

--Usuarios--
INSERT INTO usuarios (nombre, correo, telefono, contrasena, rol) VALUES
('Admin Principal', 'admin@veterinaria.com', '3001234567', 'admin123', 'admin'),
('Sebastian Suarez','ssuarezs@uts.edu.co', '3188128925', 'seba123', 'empleado'),
('Juan Jose Rojas', 'jjrojasramirez@uts.edu.co','3009876543', 'juanjo123', 'empleado');

--Productos--
INSERT INTO productos (nombre, descripcion, precio, stock, fecha_vencimiento, id_proveedor, id_categoria) VALUES
('Amoxicilina 500mg', 'Antibiótico para perros y gatos', 25000, 50, '2027-06-01', 1, 1),
('Concentrado Adulto', 'Alimento balanceado para perros adultos', 85000, 30, '2026-12-01', 2, 2),
('Jeringa 5ml', 'Insumo médico desechable', 1500, 200, NULL, 1, 3);

--Movimientos--
INSERT INTO movimientos_stock (tipo, cantidad, id_producto, id_usuario) VALUES
('entrada', 50, 1, 1),
('entrada', 30, 2, 1),
('salida', 5, 1, 2);


----CONSULTAS----
SELECT * FROM usuarios;
SELECT * FROM productos;
SELECT * FROM categorias;