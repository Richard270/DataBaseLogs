-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mexpet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mexpet` DEFAULT CHARACTER SET utf8 ;
USE `mexpet` ;

-- -----------------------------------------------------
-- Table `mexpet`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`user_roles` (
  `iduser_rol` INT NOT NULL AUTO_INCREMENT,
  `name_role` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`iduser_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`state` (
  `idstate` INT NOT NULL AUTO_INCREMENT,
  `name_state` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idstate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`email_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`email_users` (
  `idemail_users` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idemail_users`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`users` (
  `idusers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL,
  `nick_name` VARCHAR(100) NOT NULL,
  `phone` INT NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `email_users_idemail_users` INT NOT NULL,
  `state_idstate` INT NOT NULL,
  `user_roles_iduser_rol` INT NOT NULL,
  PRIMARY KEY (`idusers`),
  INDEX `fk_users_user_roles_idx` (`user_roles_iduser_rol` ASC) VISIBLE,
  INDEX `fk_users_state1_idx` (`state_idstate` ASC) VISIBLE,
  INDEX `fk_users_email_users1_idx` (`email_users_idemail_users` ASC) VISIBLE,
  CONSTRAINT `fk_users_user_roles`
    FOREIGN KEY (`user_roles_iduser_rol`)
    REFERENCES `mexpet`.`user_roles` (`iduser_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_state1`
    FOREIGN KEY (`state_idstate`)
    REFERENCES `mexpet`.`state` (`idstate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_email_users1`
    FOREIGN KEY (`email_users_idemail_users`)
    REFERENCES `mexpet`.`email_users` (`idemail_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`type_pets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`type_pets` (
  `idtype_pet` INT NOT NULL AUTO_INCREMENT,
  `type_pet` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtype_pet`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`personalities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`personalities` (
  `idpersonalities` INT NOT NULL AUTO_INCREMENT,
  `personality_pet` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpersonalities`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`races`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`races` (
  `idraces` INT NOT NULL AUTO_INCREMENT,
  `race_pet` VARCHAR(50) NULL,
  PRIMARY KEY (`idraces`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`pets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`pets` (
  `idpets` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `sex` VARCHAR(6) NOT NULL,
  `size` VARCHAR(20) NOT NULL,
  `age` INT NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `sterilization` BINARY(1) NOT NULL,
  `status` BINARY(1) NOT NULL,
  `images` BLOB NOT NULL,
  `state_idstate` INT NOT NULL,
  `type_pets_idtype_pet` INT NOT NULL,
  `personalities_idpersonalities` INT NOT NULL,
  `races_idraces` INT NOT NULL,
  PRIMARY KEY (`idpets`),
  INDEX `fk_pets_state1_idx` (`state_idstate` ASC) VISIBLE,
  INDEX `fk_pets_type_pets1_idx` (`type_pets_idtype_pet` ASC) VISIBLE,
  INDEX `fk_pets_personalities1_idx` (`personalities_idpersonalities` ASC) VISIBLE,
  INDEX `fk_pets_races1_idx` (`races_idraces` ASC) VISIBLE,
  CONSTRAINT `fk_pets_state1`
    FOREIGN KEY (`state_idstate`)
    REFERENCES `mexpet`.`state` (`idstate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pets_type_pets1`
    FOREIGN KEY (`type_pets_idtype_pet`)
    REFERENCES `mexpet`.`type_pets` (`idtype_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pets_personalities1`
    FOREIGN KEY (`personalities_idpersonalities`)
    REFERENCES `mexpet`.`personalities` (`idpersonalities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pets_races1`
    FOREIGN KEY (`races_idraces`)
    REFERENCES `mexpet`.`races` (`idraces`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`categories` (
  `idcategories` INT NOT NULL AUTO_INCREMENT,
  `cateogory_pets` VARCHAR(45) NOT NULL,
  `pets_idpets` INT NOT NULL,
  PRIMARY KEY (`idcategories`),
  INDEX `fk_categories_pets1_idx` (`pets_idpets` ASC) VISIBLE,
  CONSTRAINT `fk_categories_pets1`
    FOREIGN KEY (`pets_idpets`)
    REFERENCES `mexpet`.`pets` (`idpets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mexpet`.`application_adopt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mexpet`.`application_adopt` (
  `idapplication_adopt` INT NOT NULL AUTO_INCREMENT,
  `user_nickname` VARCHAR(100) NOT NULL,
  `status` BINARY(1) NOT NULL,
  `users_idusers` INT NOT NULL,
  `email_users_idemail_users` INT NOT NULL,
  `pets_idpets` INT NOT NULL,
  PRIMARY KEY (`idapplication_adopt`),
  INDEX `fk_application_adopt_users1_idx` (`users_idusers` ASC) VISIBLE,
  INDEX `fk_application_adopt_email_users1_idx` (`email_users_idemail_users` ASC) VISIBLE,
  INDEX `fk_application_adopt_pets1_idx` (`pets_idpets` ASC) VISIBLE,
  CONSTRAINT `fk_application_adopt_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mexpet`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_adopt_email_users1`
    FOREIGN KEY (`email_users_idemail_users`)
    REFERENCES `mexpet`.`email_users` (`idemail_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_adopt_pets1`
    FOREIGN KEY (`pets_idpets`)
    REFERENCES `mexpet`.`pets` (`idpets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
