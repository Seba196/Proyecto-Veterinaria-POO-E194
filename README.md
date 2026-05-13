# Proyecto-Veterinaria-POO-E194
**--PRIMERA ENTREGA--**
Sistema de gestión de inventario para clínica veterinaria desarrollado 
en Java SE con Swing y PostgreSQL. Proyecto de aula para la asignatura 
de Programación Orientada a Objetos.

Unidades Tecnológicas de Santander
Tecnología en Desarrollo de Sistemas Informáticos  
I Semestre 2026  
Profesor: Mag. Carlos Adolfo Beltrán Castro


1. Integrantes del Grupo
Alexis Mendoza Olaya | 75106533 | alexismendoza@uts.edu.co | 3506422065 |
Sebastian Suárez Sierra | 1005279975 | ssuarezs@uts.edu.co | 3188128925 |
Juan Jose Rojas Ramírez | 1095892149 | Jjrojasramirez@uts.edu.co | - |

2. Objetivos del Proyecto
Objetivo Principal
Desarrollar una aplicación de escritorio que permita gestionar de manera 
eficiente el inventario de medicamentos, insumos médicos y productos 
comerciales de una clínica veterinaria, garantizando el control de 
existencias y la trazabilidad de los productos.

Objetivos Específicos
- Diseñar e implementar una base de datos relacional para el 
  almacenamiento seguro de productos, proveedores y movimientos de stock.
- Desarrollar una interfaz gráfica intuitiva mediante Java Swing para 
  facilitar la interacción del personal administrativo.
- Implementar módulos CRUD (Crear, Leer, Actualizar, Eliminar) para el 
  control total de los insumos.
- Establecer una conexión estable entre la aplicación y el servidor de 
  base de datos para la persistencia de la información.

Justificación
Las clínicas veterinarias manejan una gran variedad de productos con 
fechas de vencimiento críticas y niveles de stock que afectan la atención 
médica. El uso de Programación Orientada a Objetos permite que este sistema 
sea escalable, facilitando el mantenimiento del código y permitiendo 
futuras integraciones.

Entorno de Trabajo
- Lenguaje: Java SE
- Librería Gráfica: Java Swing
- IDE: NetBeans
- Gestor de Base de Datos: PostgreSQL
- Control de Versiones: GitHub

3. Requerimientos del Sistema

| Tipo | Requerimiento | Descripción |
| Funcional | Gestión de Productos | El sistema debe permitir registrar, editar y dar de baja productos como medicamentos, alimentos, etc. |
| Funcional | Control de Stock | El sistema descuenta automáticamente del inventario cada vez que se registre una salida o venta |
| Funcional | Gestión de Proveedores | Registro de datos de contacto de las empresas que suministran los insumos |
| Funcional | Autenticación | Los usuarios deben ingresar con credenciales para acceder al panel administrativo |
| No Funcional | Persistencia | Toda la información debe almacenarse en una base de datos PostgreSQL |
| No Funcional | Interfaz | La navegación entre secciones debe ser fluida mediante un menú lateral o superior persistente |
| No Funcional | Seguridad | El sistema debe mostrar mensajes de confirmación antes de realizar acciones de eliminación |


**--SEGUNDA ENTREGA--**
--Paso 1, Diagrama Entidad/Relacion--
[diagrama_entidad_relacion_proyecto.drawio.xml](https://github.com/user-attachments/files/27671401/diagrama_entidad_relacion_proyecto.drawio.xml)
<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" agent="5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36"><diagram id="R2lEEEUBdFMjLlhIrx00" name="Page-1">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</diagram></mxfile>


--Paso 2, Script de la Base de Datos en SQL--
CREATE DATABASE veterinaria_db;
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


--Paso 3, Proyecto en Java (Menú + Conexión BD + CRUD Usuarios)--




