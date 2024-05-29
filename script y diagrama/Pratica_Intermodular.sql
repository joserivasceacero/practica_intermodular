
DROP DATABASE IF EXISTS practica_intermodular;


CREATE DATABASE practica_intermodular;


USE practica_intermodular;


CREATE TABLE Estrellas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo_estrella VARCHAR(10) NOT NULL,
    radio_km DOUBLE NOT NULL,
    temperatura_superficial_c INT NOT NULL,
    distancia_media_tierra_mkm DOUBLE NOT NULL,
    composicion TEXT NOT NULL,
    fecha_creacion TIMESTAMP
);


CREATE TABLE Planetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    radio_km DOUBLE NOT NULL,
    distancia_media_sol_mkm DOUBLE NOT NULL,
    periodo_orbital_dias DOUBLE NOT NULL,
    temperatura_media_c INT NOT NULL,
    tipo_planeta ENUM('Rocoso', 'Gaseoso') NOT NULL,
    numero_satelites INT DEFAULT 0,
    estrella_id INT NOT NULL,
    fecha_creacion TIMESTAMP,
    FOREIGN KEY (estrella_id) REFERENCES Estrellas(id)
);


CREATE TABLE Satelites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    planeta_id INT NOT NULL,
    radio_km DOUBLE NOT NULL,
    distancia_media_planeta_km DOUBLE NOT NULL,
    periodo_orbital_dias DOUBLE NOT NULL,
    temperatura_media_c INT NOT NULL,
    tipo_cuerpo ENUM('Sólido/Rocoso', 'Sólido/Hielo') NOT NULL,
    fecha_creacion TIMESTAMP,
    FOREIGN KEY (planeta_id) REFERENCES Planetas(id)
);

DELIMITER //
CREATE TRIGGER actualizar_numero_satelites
AFTER INSERT ON Satelites
FOR EACH ROW
BEGIN
    UPDATE Planetas
    SET numero_satelites = numero_satelites + 1
    WHERE id = NEW.planeta_id;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER actualizar_fecha_creacion_planetas
BEFORE INSERT ON Planetas
FOR EACH ROW
BEGIN
    SET NEW.fecha_creacion = CURRENT_TIMESTAMP;
END;
//
CREATE TRIGGER actualizar_fecha_creacion_satelites
BEFORE INSERT ON Satelites
FOR EACH ROW
BEGIN
    SET NEW.fecha_creacion = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;


INSERT INTO Estrellas (nombre, tipo_estrella, radio_km, temperatura_superficial_c, distancia_media_tierra_mkm, composicion)
VALUES
('Sol', 'G2V', 696340, 5500, 149.6, '74% Hidrógeno, 24% Helio, 2% Otros');


INSERT INTO Planetas (nombre, radio_km, distancia_media_sol_mkm, periodo_orbital_dias, temperatura_media_c, tipo_planeta, estrella_id)
VALUES
('Mercurio', 2439.7, 57.9, 88, 167, 'Rocoso', 1),
('Venus', 6051.8, 108.2, 225, 464, 'Rocoso', 1),
('Tierra', 6371, 149.6, 365.25, 15, 'Rocoso', 1),
('Marte', 3389.5, 227.9, 687, -65, 'Rocoso', 1),
('Júpiter', 69911, 778.5, 4333, -110, 'Gaseoso', 1),
('Saturno', 58232, 1429.4, 10759, -140, 'Gaseoso', 1),
('Urano', 25362, 2870.9, 30687, -195, 'Gaseoso', 1),
('Neptuno', 24622, 4498.3, 60190, -200, 'Gaseoso', 1);


INSERT INTO Satelites (nombre, planeta_id, radio_km, distancia_media_planeta_km, periodo_orbital_dias, temperatura_media_c, tipo_cuerpo)
VALUES
('Luna', 3, 1737.4, 384400, 27.3, -53, 'Sólido/Rocoso'),
('Fobos', 4, 11.1, 9378, 0.3, -40, 'Sólido/Rocoso'),
('Deimos', 4, 6.2, 23460, 1.3, -40, 'Sólido/Rocoso'),
('Ío', 5, 1821.6, 421700, 1.8, -143, 'Sólido/Rocoso'),
('Europa', 5, 1560.8, 670900, 3.5, -160, 'Sólido/Hielo'),
('Ganimedes', 5, 2634.1, 1070400, 7.2, -163, 'Sólido/Hielo'),
('Calisto', 5, 2410.3, 1882700, 16.7, -139, 'Sólido/Hielo'),
('Titán', 6, 2575.5, 1222000, 15.9, -179, 'Sólido/Hielo'),
('Encélado', 6, 252.1, 238000, 1.4, -201, 'Sólido/Hielo'),
('Titania', 7, 788.4, 435900, 8.7, -203, 'Sólido/Hielo'),
('Oberón', 7, 761.4, 583500, 13.5, -203, 'Sólido/Hielo');