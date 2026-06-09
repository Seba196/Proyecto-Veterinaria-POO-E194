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


--Nuevos Productos de la Veterinaria--
INSERT INTO productos (nombre, descripcion, precio, stock, fecha_vencimiento, id_proveedor, id_categoria) VALUES
-- Medicamentos
('Amoxicilina 500mg',     'Antibiotico para perros y gatos',         25000,  50, '2027-06-01', 1, 1),
('Ivermectina 1%',        'Antiparasitario externo e interno',        18000,  80, '2027-03-01', 1, 1),
('Dexametasona 2mg',      'Antiinflamatorio corticoesteroide',        32000,  40, '2026-12-01', 1, 1),
('Metronidazol 250mg',    'Antibiotico para infecciones digestivas',  22000,  60, '2027-01-01', 1, 1),
('Tramadol 50mg',         'Analgesico para dolor moderado',           45000,  30, '2026-11-01', 2, 1),
-- Alimentos
('Concentrado Adulto 5kg','Alimento balanceado perros adultos',       85000,  30, '2026-12-01', 2, 2),
('Concentrado Cachorro 3kg','Alimento para cachorros',                72000,  25, '2026-10-01', 2, 2),
('Concentrado Gato 2kg',  'Alimento balanceado para gatos',           65000,  20, '2026-11-01', 2, 2),
('Snack dental perro',    'Premio dental para higiene bucal',         15000, 100, '2027-05-01', 2, 2),
-- Insumos medicos
('Jeringa 5ml',           'Insumo medico desechable',                  1500, 200,  NULL,        1, 3),
('Jeringa 10ml',          'Insumo medico desechable',                  2000, 150,  NULL,        1, 3),
('Guantes latex caja x50','Guantes desechables para examen',          18000,  20,  NULL,        1, 3),
('Gasas esteriles x10',   'Apósitos para curaciones',                  5000,  80,  NULL,        1, 3),
('Alcohol 96% 500ml',     'Antiseptico para desinfeccion',             8000,  50, '2028-01-01', 2, 3),
('Suero fisiologico 500ml','Solucion isotonica para hidratacion',     12000,  40, '2027-08-01', 1, 3);

--Nuevos Proveedores de la Veterinaria y Actualizar proveedores existentes con datos completos--
UPDATE proveedores SET 
    telefono  = '6047001234',
    correo    = 'ventas@vetsuply.com',
    direccion = 'Cra 15 #20-30, Bucaramanga'
WHERE id_proveedor = 1;

UPDATE proveedores SET 
    telefono  = '6047005678',
    correo    = 'info@medivet.com',
    direccion = 'Cll 45 #10-20, Bucaramanga'
WHERE id_proveedor = 2;

-- Agregar tercer proveedor
INSERT INTO proveedores (nombre, telefono, correo, direccion) VALUES
('BioPet Colombia', '3156789012', 'contacto@biopet.com.co', 'Av. Quebrada Seca #33-15, Bucaramanga');

-- Asignar algunos productos al nuevo proveedor
UPDATE productos SET id_proveedor = 3 
WHERE nombre IN ('Concentrado Gato 2kg', 'Snack dental perro', 'Tramadol 50mg');

--CATEGORIAS PARA LA VETERINARIA--
INSERT INTO categorias (nombre, descripcion) VALUES
('Accesorios',    'Correas, collares, camas y juguetes para mascotas'),
('Higiene',       'Shampoos, cepillos y productos de aseo para mascotas'),
('Vitaminas',     'Suplementos vitamínicos y minerales para animales');


----CONSULTAS----
SELECT * FROM usuarios;
SELECT * FROM productos;
SELECT * FROM categorias;