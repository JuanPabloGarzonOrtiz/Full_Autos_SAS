/*Creacion de Base de Datos*/
CREATE DATABASE Full_Autos_SAS;
USE Full_Autos_SAS;

/*Creacion de Entidades*/
CREATE TABLE Puntos_de_Venta (
	id_Punto INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	latitud DECIMAL(9,6) NOT NULL,
	altitud INT NOT NULL
);
CREATE TABLE Empleados (
	id_Empleado INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	cargo ENUM('Ayudante de Taller', 'Mecanico General','Tecnico en Llantas', 'Tecnico de Cambios Rapidos', 'Electricista Automotriz') DEFAULT 'Ayudante de Taller' NOT NULL,
	foto VARCHAR(300) NOT NULL,
	usuario VARCHAR(10) NOT NULL,
	contraseña VARCHAR(300) NOT NULL,
	id_Punto INT NOT NULL,
	FOREIGN KEY(id_Punto) REFERENCES Puntos_de_Venta(id_Punto)
);
CREATE TABLE Servicios (
	id_Servicio INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	foto VARCHAR(300) NOT NULL,
	descripcion TEXT NOT NULL,
	tipo ENUM('Mantenimiento Preventivo', 'Mantenimiento Correctivo', 'Servicio Especializado', 'Llantas y Rines', 'Otros Servicios') DEFAULT 'Mantenimiento Preventivo' NOT NULL,
	tiempo TIME NOT NULL,
	materiales JSON NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	manual VARCHAR(300) NOT NULL
);
CREATE TABLE Empleados_Servicios (
	id_EmpleadoServicio INTEGER AUTO_INCREMENT PRIMARY KEY,
	id_Empleado INT NOT NULL,
	id_Servicio INT NOT NULL,
	fecha_Entrega DATE NOT NULL,
	FOREIGN KEY (id_Empleado) REFERENCES Empleados(id_Empleado),
	FOREIGN KEY (id_Servicio) REFERENCES Servicios(id_Servicio)
);
CREATE TABLE Datos_Trayectoria (
	id_Evento INTEGER AUTO_INCREMENT PRIMARY KEY,
	fecha DATE NOT NULL,
	descripcion TEXT NOT NULL
);
CREATE TABLE Postulaciones (
	id_Postulacion INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	correo VARCHAR(200) NOT NULL,
	estado ENUM('Pendiente', 'Aceptado', 'Rechazado') DEFAULT 'Pendiente' NOT NULL
);

/*Insercion de Datos*/
INSERT INTO Puntos_de_Venta (nombre, latitud, altitud) VALUES
	('Serviteca Bogotá Centro', 4.609710, 2600),
	('Serviteca Medellín Norte', 6.244203, 1495),
	('Serviteca Cali Sur', 3.451647, 1000),
	('Serviteca Barranquilla Atlántico', 10.968540, 18),
	('Serviteca Pasto Andina', 1.207325, 2527);

INSERT INTO Empleados (nombre, cargo, foto, usuario, contraseña, id_Punto) VALUES
	('Juan Pérez', 'Ayudante de Taller', '/fotos/empleado1.jpg', 'juanp', 'passJuan1', 1),
	('Carlos López', 'Mecanico General', '/fotos/empleado2.jpg', 'carlosl', 'passCarlos2', 1),
	('Ana Gómez', 'Tecnico en Llantas', '/fotos/empleado3.jpg', 'anag', 'passAna3', 1),
	('Luis Martínez', 'Tecnico de Cambios Rapidos', '/fotos/empleado4.jpg', 'luism', 'passLuis4', 1),
	('Sofía Ramírez', 'Electricista Automotriz', '/fotos/empleado5.jpg', 'sofiar', 'passSofia5', 1),
	('Miguel Torres', 'Ayudante de Taller', '/fotos/empleado6.jpg', 'miguelt', 'passMiguel6', 2),
	('Laura Díaz', 'Mecanico General', '/fotos/empleado7.jpg', 'laurad', 'passLaura7', 2),
	('Diego Fernández', 'Tecnico en Llantas', '/fotos/empleado8.jpg', 'diegof', 'passDiego8', 2),
	('Carolina Vargas', 'Tecnico de Cambios Rapidos', '/fotos/empleado9.jpg', 'carolinav', 'passCarolina9', 2),
	('Andrés Morales', 'Electricista Automotriz', '/fotos/empleado10.jpg', 'andresm', 'passAndres10', 2),
	('Valentina Herrera', 'Ayudante de Taller', '/fotos/empleado11.jpg', 'valentinah', 'passValentina11', 3),
	('Sebastián Castro', 'Mecanico General', '/fotos/empleado12.jpg', 'sebastianc', 'passSebastian12', 3),
	('Natalia Rojas', 'Tecnico en Llantas', '/fotos/empleado13.jpg', 'nataliar', 'passNatalia13', 3),
	('Jorge Sánchez', 'Tecnico de Cambios Rapidos', '/fotos/empleado14.jpg', 'jorges', 'passJorge14', 3),
	('María Jiménez', 'Electricista Automotriz', '/fotos/empleado15.jpg', 'mariaj', 'passMaria15', 3),
	('Andriana Pineda', 'Ayudante de Taller', '/fotos/empleado16.jpg', 'andrianap', 'passAndriana16', 4),
	('Ricardo Salazar', 'Mecanico General', '/fotos/empleado17.jpg', 'ricardos', 'passRicardo17', 4),
	('Camila Torres', 'Tecnico en Llantas', '/fotos/empleado18.jpg', 'camilat', 'passCamila18', 4),
	('Fernando Ortiz', 'Tecnico de Cambios Rapidos', '/fotos/empleado19.jpg', 'fernandoo', 'passFernando19', 4),
	('Isabella Medina', 'Electricista Automotriz', '/fotos/empleado20.jpg', 'isabellam', 'passIsabella20', 4),
	('Mateo Suarez', 'Ayudante de Taller', '/fotos/empleado21.jpg', 'mateos', 'passMateo21', 5),
	('Daniela Cardenas', 'Mecanico General', '/fotos/empleado22.jpg', 'danielac', 'passDaniela22', 5),
	('Andres Felipe', 'Tecnico en Llantas', '/fotos/empleado23.jpg', 'andresf', 'passAndres23', 5),
	('Laura Moreno', 'Tecnico de Cambios Rapidos', '/fotos/empleado24.jpg', 'lauram', 'passLaura24', 5),
	('José Ramirez', 'Electricista Automotriz', '/fotos/empleado25.jpg', 'joser', 'passJose25', 5);

	INSERT INTO Servicios (nombre, foto, descripcion, tipo, tiempo, materiales, precio, manual) VALUES
	('Cambio de Aceite', '/fotos/servicio1.jpg', 'Cambio de aceite y filtro, revisión general.', 'Mantenimiento Preventivo', '00:45:00', '["Aceite 5W30","Filtro de aceite","Guantes","Trapo"]', 85000.00, '/manuales/servicio1.pdf'),
	('Revisión de Frenos', '/fotos/servicio2.jpg', 'Inspección de pastillas, discos y líquido de frenos.', 'Mantenimiento Preventivo', '00:50:00', '["Pastillas de freno","Disco de freno","Líquido de frenos","Llave de torque"]', 70000.00, '/manuales/servicio2.pdf'),
	('Inspección de Suspensión', '/fotos/servicio3.jpg', 'Revisión de amortiguadores y suspensión general.', 'Mantenimiento Preventivo', '01:00:00', '["Amortiguadores","Llaves","Gato hidráulico"]', 95000.00, '/manuales/servicio3.pdf'),
	('Chequeo General', '/fotos/servicio4.jpg', 'Revisión completa del vehículo antes de viaje.', 'Mantenimiento Preventivo', '01:15:00', '["Guantes","Trapo","Escáner OBD"]', 120000.00, '/manuales/servicio4.pdf'),
	('Revisión de Luces', '/fotos/servicio5.jpg', 'Chequeo de luces delanteras, traseras y direccionales.', 'Mantenimiento Preventivo', '00:30:00', '["Multímetro","Bombillas de repuesto","Guantes"]', 50000.00, '/manuales/servicio5.pdf'),
	('Reparación de Frenos', '/fotos/servicio6.jpg', 'Sustitución de pastillas y discos de freno.', 'Mantenimiento Correctivo', '01:30:00', '["Pastillas","Discos","Líquido de frenos","Llave de torque"]', 180000.00, '/manuales/servicio6.pdf'),
	('Cambio de Correa de Distribución', '/fotos/servicio7.jpg', 'Sustitución de la correa de distribución del motor.', 'Mantenimiento Correctivo', '02:30:00', '["Correa de distribución","Llaves","Gato hidráulico"]', 450000.00, '/manuales/servicio7.pdf'),
	('Reparación de Motor', '/fotos/servicio8.jpg', 'Reparación de fallas mecánicas del motor.', 'Mantenimiento Correctivo', '03:00:00', '["Herramientas mecánicas","Aceite","Gatos"]', 600000.00, '/manuales/servicio8.pdf'),
	('Cambio de Amortiguadores', '/fotos/servicio9.jpg', 'Sustitución de amortiguadores traseros y delanteros.', 'Mantenimiento Correctivo', '01:45:00', '["Amortiguadores","Llaves","Gato hidráulico"]', 250000.00, '/manuales/servicio9.pdf'),
	('Reparación de Transmisión', '/fotos/servicio10.jpg', 'Reparación o ajuste de la transmisión del vehículo.', 'Mantenimiento Correctivo', '02:00:00', '["Aceite de transmisión","Herramientas","Llaves"]', 500000.00, '/manuales/servicio10.pdf'),
	('Diagnóstico Electrónico', '/fotos/servicio11.jpg', 'Escaneo OBD y detección de fallas electrónicas.', 'Servicio Especializado', '01:00:00', '["Escáner OBD","Computador","Guantes"]', 120000.00, '/manuales/servicio11.pdf'),
	('Reparación de Aire Acondicionado', '/fotos/servicio12.jpg', 'Revisión y reparación del sistema de aire acondicionado.', 'Servicio Especializado', '02:00:00', '["Gas refrigerante","Llaves","Manómetro"]', 350000.00, '/manuales/servicio12.pdf'),
	('Actualización de Software', '/fotos/servicio13.jpg', 'Actualización del software interno del vehículo.', 'Servicio Especializado', '01:30:00', '["Computador","Cable OBD","Manual"]', 200000.00, '/manuales/servicio13.pdf'),
	('Reparación de Sensores', '/fotos/servicio14.jpg', 'Sustitución o calibración de sensores electrónicos.', 'Servicio Especializado', '01:45:00', '["Sensores","Llaves","Herramientas especiales"]', 250000.00, '/manuales/servicio14.pdf'),
	('Diagnóstico de Batería', '/fotos/servicio15.jpg', 'Prueba de batería y sistema eléctrico.', 'Servicio Especializado', '00:40:00', '["Multímetro","Batería de prueba","Guantes"]', 80000.00, '/manuales/servicio15.pdf'),
	('Alineación de Ruedas', '/fotos/servicio16.jpg', 'Alineación de ruedas para mejorar desempeño y seguridad.', 'Llantas y Rines', '01:15:00', '["Máquina de alineación","Llaves","Guantes"]', 95000.00, '/manuales/servicio16.pdf'),
	('Balanceo de Llantas', '/fotos/servicio17.jpg', 'Balanceo de llantas delanteras y traseras.', 'Llantas y Rines', '01:00:00', '["Balanza de llantas","Pesos","Llaves"]', 85000.00, '/manuales/servicio17.pdf'),
	('Cambio de Llantas', '/fotos/servicio18.jpg', 'Desmontaje y montaje de llantas nuevas.', 'Llantas y Rines', '01:30:00', '["Llanta nueva","Llave de cruz","Gato"]', 120000.00, '/manuales/servicio18.pdf'),
	('Rotación de Llantas', '/fotos/servicio19.jpg', 'Rotación de llantas para desgaste uniforme.', 'Llantas y Rines', '00:50:00', '["Llave de cruz","Guantes"]', 60000.00, '/manuales/servicio19.pdf'),
	('Reparación de Rines', '/fotos/servicio20.jpg', 'Reparación y enderezado de rines dañados.', 'Llantas y Rines', '01:45:00', '["Herramientas","Rines","Llaves"]', 180000.00, '/manuales/servicio20.pdf'),
	('Lavado Completo', '/fotos/servicio21.jpg', 'Lavado exterior e interior del vehículo.', 'Otros Servicios', '01:00:00', '["Champú","Esponjas","Aspiradora","Cera"]', 60000.00, '/manuales/servicio21.pdf'),
	('Detallado de Carrocería', '/fotos/servicio22.jpg', 'Pulido y encerado de carrocería.', 'Otros Servicios', '01:30:00', '["Cera","Pulidor","Trapo","Guantes"]', 90000.00, '/manuales/servicio22.pdf'),
	('Desinfección Interior', '/fotos/servicio23.jpg', 'Limpieza profunda y desinfección del interior del vehículo.', 'Otros Servicios', '00:45:00', '["Desinfectante","Aspiradora","Guantes"]', 50000.00, '/manuales/servicio23.pdf'),
	('Revisión Pre ITV', '/fotos/servicio24.jpg', 'Revisión general para pasar inspección técnica vehicular.', 'Otros Servicios', '01:15:00', '["Herramientas","Multímetro","Trapo"]', 75000.00, '/manuales/servicio24.pdf'),
	('Revisión de Luces y Señales', '/fotos/servicio25.jpg', 'Chequeo de todas las luces y señales del vehículo.', 'Otros Servicios', '00:30:00', '["Bombillas de repuesto","Multímetro","Guantes"]', 50000.00, '/manuales/servicio25.pdf');

	INSERT INTO Empleados_Servicios (id_Empleado, id_Servicio, fecha_Entrega) VALUES
		(2, 1, '2025-09-01'),
		(3, 6, '2025-09-01'),
		(5, 11, '2025-09-01'),
		(4, 2, '2025-09-01'),
		(1, 21, '2025-09-01'),
		(2, 2, '2025-09-02'),
		(3, 7, '2025-09-02'),
		(5, 12, '2025-09-02'),
		(4, 3, '2025-09-02'),
		(1, 22, '2025-09-02'),
		(2, 3, '2025-09-03'),
		(3, 8, '2025-09-03'),
		(5, 13, '2025-09-03'),
		(4, 4, '2025-09-03'),
		(1, 23, '2025-09-03'),
		(2, 4, '2025-09-04'),
		(3, 9, '2025-09-04'),
		(5, 14, '2025-09-04'),
		(4, 5, '2025-09-04'),
		(1, 24, '2025-09-04'),
		(2, 5, '2025-09-05'),
		(3, 10, '2025-09-05'),
		(5, 15, '2025-09-05'),
		(4, 1, '2025-09-05'),
		(1, 25, '2025-09-05');

INSERT INTO Datos_Trayectoria (fecha, descripcion) VALUES
	('1985-06-15', 'Fundación de la serviteca en Bogotá, iniciando con un taller pequeño.'),
	('1990-03-20', 'Primer gran contrato de mantenimiento con flota de taxis locales en Bogotá.'),
	('1995-08-10', 'Apertura del segundo punto de venta en Medellín.'),
	('2000-05-05', 'Adquisición de equipo especializado para diagnóstico electrónico en Bogotá.'),
	('2005-09-12', 'Implementación de sistema de control de clientes y servicios informatizado en Bogotá.'),
	('2010-01-18', 'Apertura del tercer punto de venta en Cali, expandiendo servicios a Llantas y Rines.'),
	('2015-07-23', 'Reconocimiento local como taller especializado en mantenimiento preventivo en Medellín.'),
	('2018-11-30', 'Inicio de capacitación interna para técnicos en nuevas tecnologías automotrices en Bogotá.'),
	('2022-04-14', 'Apertura del cuarto punto de venta en Barranquilla con servicio completo de reparación y lavado.'),
	('2025-02-01', 'Inauguración del quinto punto de venta en Pasto y modernización del sistema de citas y asignación de servicios.');