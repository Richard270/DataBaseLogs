USE mexpet;

-- Elimina la tabla logs si existe
DROP TABLE IF EXISTS logs;

-- Crea la tabla logs
CREATE TABLE logs (
    id BINARY(16) PRIMARY KEY NOT NULL,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    old_values TEXT NULL,
    new_values TEXT NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Trigger para insertar en logs después de insertar en users
DELIMITER //
CREATE TRIGGER t_insert_users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN
    DECLARE values_text TEXT;
    
    SET values_text = CONCAT(
        'name: ', NEW.name,
        ', lastname: ', NEW.lastname,
        ', surname: ', COALESCE(NEW.surname, 'N/A'),
        ', nick_name: ', NEW.nick_name,
        ', phone: ', NEW.phone,
        ', password: ', NEW.password,
        ', email_users_id: ', NEW.email_users_idemail_users,
        ', state_id: ', NEW.state_idstate,
        ', user_roles_id: ', NEW.user_roles_iduser_rol
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'INSERT', 'users', NULL, values_text, CURRENT_USER(), NOW());
END //
DELIMITER ;

-- Trigger para actualizar en logs después de actualizar en users
DELIMITER //
CREATE TRIGGER t_update_users_log AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    DECLARE old_values_text TEXT;
    DECLARE new_values_text TEXT;

    SET old_values_text = CONCAT(
        'name: ', OLD.name,
        ', lastname: ', OLD.lastname,
        ', surname: ', COALESCE(OLD.surname, 'N/A'),
        ', nick_name: ', OLD.nick_name,
        ', phone: ', OLD.phone,
        ', password: ', OLD.password,
        ', email_users_id: ', OLD.email_users_idemail_users,
        ', state_id: ', OLD.state_idstate,
        ', user_roles_id: ', OLD.user_roles_iduser_rol
    );

    SET new_values_text = CONCAT(
        'name: ', NEW.name,
        ', lastname: ', NEW.lastname,
        ', surname: ', COALESCE(NEW.surname, 'N/A'),
        ', nick_name: ', NEW.nick_name,
        ', phone: ', NEW.phone,
        ', password: ', NEW.password,
        ', email_users_id: ', NEW.email_users_idemail_users,
        ', state_id: ', NEW.state_idstate,
        ', user_roles_id: ', NEW.user_roles_iduser_rol
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'UPDATE', 'users', old_values_text, new_values_text, CURRENT_USER(), NOW());
END //
DELIMITER ;

-- Trigger para insertar en logs después de insertar en pets
DELIMITER //
CREATE TRIGGER t_insert_pets_log AFTER INSERT ON pets
FOR EACH ROW
BEGIN
    DECLARE values_text TEXT;
    
    SET values_text = CONCAT(
        'name: ', NEW.name,
        ', description: ', NEW.description,
        ', sex: ', NEW.sex,
        ', size: ', NEW.size,
        ', age: ', NEW.age,
        ', color: ', NEW.color,
        ', sterilization: ', NEW.sterilization,
        ', status: ', NEW.status,
        ', images: ', 'BLOB Data', -- Considera si necesitas almacenar esto en la bitácora
        ', state_id: ', NEW.state_idstate,
        ', type_pets_id: ', NEW.type_pets_idtype_pet,
        ', personalities_id: ', NEW.personalities_idpersonalities,
        ', races_id: ', NEW.races_idraces
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'INSERT', 'pets', NULL, values_text, CURRENT_USER(), NOW());
END //
DELIMITER ;

-- Trigger para actualizar en logs después de actualizar en pets
DELIMITER //
CREATE TRIGGER t_update_pets_log AFTER UPDATE ON pets
FOR EACH ROW
BEGIN
    DECLARE old_values_text TEXT;
    DECLARE new_values_text TEXT;

    SET old_values_text = CONCAT(
        'name: ', OLD.name,
        ', description: ', OLD.description,
        ', sex: ', OLD.sex,
        ', size: ', OLD.size,
        ', age: ', OLD.age,
        ', color: ', OLD.color,
        ', sterilization: ', OLD.sterilization,
        ', status: ', OLD.status,
        ', images: ', 'BLOB Data', -- Considera si necesitas almacenar esto en la bitácora
        ', state_id: ', OLD.state_idstate,
        ', type_pets_id: ', OLD.type_pets_idtype_pet,
        ', personalities_id: ', OLD.personalities_idpersonalities,
        ', races_id: ', OLD.races_idraces
    );

    SET new_values_text = CONCAT(
        'name: ', NEW.name,
        ', description: ', NEW.description,
        ', sex: ', NEW.sex,
        ', size: ', NEW.size,
        ', age: ', NEW.age,
        ', color: ', NEW.color,
        ', sterilization: ', NEW.sterilization,
        ', status: ', NEW.status,
        ', images: ', 'BLOB Data', -- Considera si necesitas almacenar esto en la bitácora
        ', state_id: ', NEW.state_idstate,
        ', type_pets_id: ', NEW.type_pets_idtype_pet,
        ', personalities_id: ', NEW.personalities_idpersonalities,
        ', races_id: ', NEW.races_idraces
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'UPDATE', 'pets', old_values_text, new_values_text, CURRENT_USER(), NOW());
END //
DELIMITER ;

-- Trigger para eliminar en logs después de eliminar en users
DELIMITER //
CREATE TRIGGER t_delete_users_log AFTER DELETE ON users
FOR EACH ROW
BEGIN
    DECLARE old_values_text TEXT;

    SET old_values_text = CONCAT(
        'name: ', OLD.name,
        ', lastname: ', OLD.lastname,
        ', surname: ', COALESCE(OLD.surname, 'N/A'),
        ', nick_name: ', OLD.nick_name,
        ', phone: ', OLD.phone,
        ', password: ', OLD.password,
        ', email_users_id: ', OLD.email_users_idemail_users,
        ', state_id: ', OLD.state_idstate,
        ', user_roles_id: ', OLD.user_roles_iduser_rol
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'DELETE', 'users', old_values_text, '', CURRENT_USER(), NOW());
END //
DELIMITER ;

-- Trigger para eliminar en logs después de eliminar en pets
DELIMITER //
CREATE TRIGGER t_delete_pets_log AFTER DELETE ON pets
FOR EACH ROW
BEGIN
    DECLARE old_values_text TEXT;

    SET old_values_text = CONCAT(
        'name: ', OLD.name,
        ', description: ', OLD.description,
        ', sex: ', OLD.sex,
        ', size: ', OLD.size,
        ', age: ', OLD.age,
        ', color: ', OLD.color,
        ', sterilization: ', OLD.sterilization,
        ', status: ', OLD.status,
        ', images: ', 'BLOB Data', -- Considera si necesitas almacenar esto en la bitácora
        ', state_id: ', OLD.state_idstate,
        ', type_pets_id: ', OLD.type_pets_idtype_pet,
        ', personalities_id: ', OLD.personalities_idpersonalities,
        ', races_id: ', OLD.races_idraces
    );

    INSERT INTO logs (id, action, table_name, old_values, new_values, user_name, created_at)
    VALUES (UNHEX(UUID()), 'DELETE', 'pets', old_values_text, '', CURRENT_USER(), NOW());
END //
DELIMITER ;