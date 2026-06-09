# Proyecto Veterinaria - POO E194
Sistema de gestión de inventario para clínica veterinaria desarrollado
en Java SE con Swing y PostgreSQL.

**Unidades Tecnológicas de Santander**
Tecnología en Desarrollo de Sistemas Informáticos
Programación Orientada a Objetos — I Semestre 2026
Profesor: Mag. Carlos Adolfo Beltrán Castro


## 1. Integrantes del Grupo
Sebastian Suárez Sierra - 1005279975 - ssuarezs@uts.edu.co - 3188128925 
Juan Jose Rojas Ramírez - 1095892149 - Jjrojasramirez@uts.edu.co - 
Alexis Mendoza Olaya - 75106533 - alexismendoza@uts.edu.co - 3506422065 

## 2. Objetivos del Proyecto
### Objetivo Principal
Desarrollar una aplicación de escritorio que permita gestionar de manera
eficiente el inventario de medicamentos, insumos médicos y productos
comerciales de una clínica veterinaria, garantizando el control de
existencias y la trazabilidad de los productos.

### Objetivos Específicos
- Diseñar e implementar una base de datos relacional para el
  almacenamiento seguro de productos, proveedores y movimientos de stock.
- Desarrollar una interfaz gráfica intuitiva mediante Java Swing para
  facilitar la interacción del personal administrativo.
- Implementar módulos CRUD (Crear, Leer, Actualizar, Eliminar) para el
  control total de los insumos.
- Establecer una conexión estable entre la aplicación y el servidor de
  base de datos para la persistencia de la información.

### Justificación
Las clínicas veterinarias manejan una gran variedad de productos con
fechas de vencimiento críticas y niveles de stock que afectan la atención
médica. El uso de Programación Orientada a Objetos permite que este sistema
sea escalable, facilitando el mantenimiento del código y permitiendo
futuras integraciones.

### Entorno de Trabajo
- **Lenguaje:** Java SE
- **Librería Gráfica:** Java Swing
- **IDE:** NetBeans
- **Gestor de Base de Datos:** PostgreSQL
- **Control de Versiones:** GitHub

## 3. Requerimientos del Sistema

| Tipo | Requerimiento | Descripción |
|---|---|---|
| Funcional | Gestión de Productos | Registrar, editar y dar de baja productos como medicamentos, alimentos, etc. |
| Funcional | Control de Stock | Descontar automáticamente del inventario cada vez que se registre una salida o venta |
| Funcional | Gestión de Proveedores | Registro de datos de contacto de las empresas que suministran los insumos |
| Funcional | Autenticación | Los usuarios deben ingresar con credenciales para acceder al panel administrativo |
| No Funcional | Persistencia | Toda la información debe almacenarse en una base de datos PostgreSQL |
| No Funcional | Interfaz | La navegación entre secciones debe ser fluida mediante un menú lateral persistente |
| No Funcional | Seguridad | El sistema debe mostrar mensajes de confirmación antes de eliminar registros |


## SEGUNDA ENTREGA
### Paso 1 — Diagrama Entidad Relación
El diagrama muestra las 5 tablas principales del sistema y sus relaciones:

- **USUARIOS** — gestiona el acceso al sistema
- **CATEGORIAS** — clasifica los productos
- **PROVEEDORES** — empresas que suministran productos
- **PRODUCTOS** — inventario principal (relacionado con categorías y proveedores)
- **MOVIMIENTOS_STOCK** — registra entradas y salidas (relacionado con productos y usuarios)

Archivo del diagrama: <img width="902" height="572" alt="diagrama_entidad_relacion_proyecto drawio" src="https://github.com/user-attachments/assets/a433b046-3b18-407c-af46-5ab0a03d1a85" />


### Paso 2 — Script SQL
Script de creación de la base de datos `veterinaria_db` en PostgreSQL.

Incluye:
- Creación de las 5 tablas con sus relaciones
- Datos de prueba (categorías, proveedores, usuarios y productos)

Archivo: https://github.com/Seba196/Proyecto-Veterinaria-POO-E194/blob/main/Codigo_BD_Proyecto.sql

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


### Paso 3 — Proyecto Java (Parcial Funcional)
Aplicación de escritorio desarrollada en Java SE con Swing y PostgreSQL.

#### Funcionalidades implementadas:

**Menú de Navegación**
- Panel lateral azul con acceso a todos los módulos
- Botón de cierre de sesión con confirmación

**Conexión a Base de Datos**
- Conexión estable a PostgreSQL mediante JDBC
- Clase `Conexion.java` centralizada

**CRUD de Usuarios** 
- Crear nuevos usuarios con nombre, correo, teléfono, contraseña y rol
- Listar todos los usuarios en tabla interactiva
- Actualizar datos seleccionando una fila de la tabla
- Eliminar usuarios con mensaje de confirmación

#### Estructura del Proyecto:
VeterinariaApp
├── conexion/
│   └── Conexion.java
├── modelo/
│   ├── Usuario.java
│   ├── Producto.java
│   ├── Proveedor.java
│   ├── Categoria.java
│   └── Movimiento.java
├── dao/
│   ├── UsuarioDAO.java
│   ├── LoginDAO.java
│   ├── ProductoDAO.java
│   ├── ProveedorDAO.java
│   ├── CategoriaDAO.java
│   └── MovimientoDAO.java
└── vista/
    ├── LoginVista.java
    ├── MenuPrincipal.java
    ├── UsuarioVista.java
    ├── ProductoVista.java
    ├── ProveedorVista.java
    ├── CategoriaVista.java
    └── MovimientoVista.java

#### Capturas de pantalla:
<img width="1920" height="1023" alt="{1308FDCC-A845-4705-83D5-609C7AEA68A0}" src="https://github.com/user-attachments/assets/6db69ca2-3cdc-48a8-87d9-fa5d749a73e1" />
<img width="1920" height="1020" alt="{82EA74D0-7843-44E7-9F0E-FACA8AF6A60F}" src="https://github.com/user-attachments/assets/85d9cfaf-4b7a-4403-954a-c588d963b0cb" />
<img width="1920" height="1014" alt="{D1B2CB89-99F0-4E08-9F55-23F1D128427C}" src="https://github.com/user-attachments/assets/cdf92165-f7ec-476f-85c9-4db3fd7f7c81" />
<img width="1920" height="1022" alt="{DC4CFDA8-7B7D-481F-BD70-C7266FD2AA23}" src="https://github.com/user-attachments/assets/b57749c6-eb1f-4008-b4f6-a81b0cd10306" />
<img width="1920" height="1019" alt="{FFDDFA4B-E3CE-4BA2-8F9D-6362A8BFFE03}" src="https://github.com/user-attachments/assets/55606569-82ea-4080-82a7-61a2a44b5ec6" />
<img width="1920" height="1018" alt="{59D13762-CF6B-4DAB-9519-6D4C0BD8B8FA}" src="https://github.com/user-attachments/assets/a4051042-4e4f-4524-9c96-8a59e89bc39e" />
<img width="1914" height="1019" alt="{8E273884-1DA1-42BA-9728-0F3145D94E1B}" src="https://github.com/user-attachments/assets/99f99e2c-e084-4a0a-a774-c2e371e19638" />
<img width="1920" height="1019" alt="{0C53C4B2-43C5-4AF0-9505-73C3E497C56E}" src="https://github.com/user-attachments/assets/0ae97e66-bdc9-4112-bcc1-9e273d6fb119" />


## Instalación y Ejecución
### Requisitos:
- Java JDK 17 o superior
- NetBeans IDE
- PostgreSQL 15 o superior
- Driver JDBC PostgreSQL (.jar)

### Pasos:
1. Tener instalado **Java JDK**, **NetBeans** y **PostgreSQL**
2. Ejecutar el archivo `script_veterinaria.sql` en pgAdmin
3. Abrir el proyecto en NetBeans
4. En `Conexion.java` cambiar la contraseña por la de tu PostgreSQL
5. Ejecutar `LoginVista.java` con clic derecho → Run File


## TERCERA ENTREGA

### Nuevas Funcionalidades Implementadas
**Login con roles y permisos**
- Autenticación con correo y contraseña
- 3 roles: Admin, Veterinario y Empleado
- Restricción de acceso por módulo según rol

| Módulo | Admin | Veterinario | Empleado |
|---|---|---|---|
| Usuarios | ✅ | ❌ | ❌ |
| Productos | ✅ | ✅ | ✅ |
| Proveedores | ✅ | ❌ | ❌ |
| Categorias | ✅ | ✅ | ❌ |
| Movimientos | ✅ | ✅ | ✅ |

**CRUD de Productos**
- Registro completo con precio, stock, fecha de vencimiento
- Vinculación con proveedor y categoría

**CRUD de Proveedores**
- Vista de productos ofrecidos por cada proveedor

**CRUD de Categorías**
- Clasificación de productos por tipo

**Registro de Movimientos**
- Entradas y salidas de stock
- Actualización automática del inventario
- Filtros por producto y por fecha

#### Capturas de pantalla:
<img width="509" height="469" alt="image" src="https://github.com/user-attachments/assets/bf463f80-b096-476e-bb6e-6088e5356955" />
<img width="504" height="463" alt="image" src="https://github.com/user-attachments/assets/8ea6de1b-ec0c-48ff-81b2-6e1e18173453" />
<img width="1110" height="739" alt="image" src="https://github.com/user-attachments/assets/a6fe1ee2-568e-4fea-9c16-b01226b48e7a" />
<img width="1163" height="673" alt="image" src="https://github.com/user-attachments/assets/c4579f4f-d0d2-42cd-b5a4-13f3e29e4934" />
<img width="1228" height="711" alt="image" src="https://github.com/user-attachments/assets/ae85d79e-7a97-474a-acc7-a473558753e1" />
<img width="1111" height="736" alt="image" src="https://github.com/user-attachments/assets/4246d958-39a1-47fb-a9e0-7b9ddc563a63" />
<img width="1457" height="716" alt="image" src="https://github.com/user-attachments/assets/94ea3ff8-dd98-4348-a284-7c6affc6fa7c" />
<img width="1107" height="739" alt="image" src="https://github.com/user-attachments/assets/215415b4-4c53-41cd-91ea-1207434500e0" />
<img width="1107" height="737" alt="image" src="https://github.com/user-attachments/assets/7c2c1a3f-45e7-44a4-91be-d82d6332b601" />



