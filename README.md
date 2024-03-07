# DataBaseLogs
Una bitácora (o log) en una base de datos se utiliza para registrar eventos o cambios significativos en el sistema. Esto es crucial para la auditoría, el seguimiento de cambios y la resolución de problemas. Un trigger es un tipo de procedimiento almacenado que se ejecuta automáticamente en respuesta a un evento específico en una tabla o vista

-- Tabla de usuarios
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(32) NOT NULL
);

-- Tabla de bitácora
CREATE TABLE logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    action VARCHAR(10) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    old_data TEXT,
    new_data TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para insertar en logs después de insertar en users
DELIMITER //
CREATE TRIGGER t_insert_users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN
    -- Variables para almacenar información
    DECLARE new_data_text TEXT;

    -- Construir el texto de los nuevos datos
    SET new_data_text = CONCAT(
        'username: ', NEW.username,
        ', email: ', NEW.email,
        ', password: ', NEW.password
    );

    -- Insertar en la tabla de bitácora
    INSERT INTO logs (action, table_name, record_id, new_data)
    VALUES ('INSERT', 'users', NEW.id, new_data_text);
END //
DELIMITER ;

Creación del Trigger:

Se utiliza CREATE TRIGGER para definir un nuevo trigger llamado t_insert_users_log.
AFTER INSERT ON users especifica que el trigger se activará después de una inserción en la tabla users.
FOR EACH ROW indica que el trigger se ejecutará una vez por cada fila afectada.
Inicio del Bloque BEGIN - END:

Todas las instrucciones del trigger están entre BEGIN y END.
Variables:

Se declara una variable new_data_text para almacenar la información de los nuevos datos que se insertarán en la bitácora.
Construcción del Texto de Nuevos Datos:

Usando CONCAT, se construye un texto que contiene la información de los nuevos datos de la fila insertada en la tabla users.
Inserción en la Tabla de Bitácora:

Se utiliza INSERT INTO para agregar una nueva entrada a la tabla logs.
Se registran la acción ('INSERT'), la tabla afectada ('users'), el ID del registro (NEW.id) y los nuevos datos.