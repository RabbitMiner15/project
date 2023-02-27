-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `iduser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` MEDIUMTEXT NOT NULL,
  `picture` INT UNSIGNED NOT NULL DEFAULT 1,
  `groupinvites` TINYINT NULL DEFAULT 1,
  `temperature` VARCHAR(45) NULL DEFAULT 'Celsius',
  `distance` VARCHAR(45) NULL DEFAULT 'km',
  `accesstoken` MEDIUMTEXT NULL,
  `refreshtoken` MEDIUMTEXT NULL,
  `summary` TINYINT NULL,
  `websitenot` TINYINT NULL DEFAULT 1,
  `emailnot` TINYINT NULL DEFAULT 1,
  `discordnot` TINYINT NULL DEFAULT 0,
  `private` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `idUser_UNIQUE` (`iduser` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `idcategory` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `categoryname` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `fitbit` TINYINT NOT NULL,
  PRIMARY KEY (`idcategory`),
  UNIQUE INDEX `iddata_UNIQUE` (`idcategory` ASC) VISIBLE,
  UNIQUE INDEX `dataname_UNIQUE` (`categoryname` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userdata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`userdata` ;

CREATE TABLE IF NOT EXISTS `mydb`.`userdata` (
  `user_iduser` INT UNSIGNED NOT NULL,
  `data_iddata` INT UNSIGNED NOT NULL,
  `private` TINYINT NULL,
  PRIMARY KEY (`user_iduser`, `data_iddata`),
  INDEX `fk_user_has_data_data1_idx` (`data_iddata` ASC) VISIBLE,
  INDEX `fk_user_has_data_user_idx` (`user_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_data_user`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_data_data1`
    FOREIGN KEY (`data_iddata`)
    REFERENCES `mydb`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`notification` ;

CREATE TABLE IF NOT EXISTS `mydb`.`notification` (
  `idnotification` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fiuser` INT UNSIGNED NOT NULL,
  `title` VARCHAR(45) NULL,
  `text` VARCHAR(255) NULL,
  `seen` TINYINT NULL,
  `visible` TINYINT NULL,
  `time` DATETIME NULL,
  PRIMARY KEY (`idnotification`, `fiuser`),
  UNIQUE INDEX `idnotification_UNIQUE` (`idnotification` ASC) VISIBLE,
  INDEX `fk_notification_user1_idx` (`fiuser` ASC) VISIBLE,
  CONSTRAINT `fk_notification_user1`
    FOREIGN KEY (`fiuser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`achievements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`achievements` ;

CREATE TABLE IF NOT EXISTS `mydb`.`achievements` (
  `idachievements` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `picture` INT UNSIGNED NOT NULL DEFAULT 100,
  `condition` VARCHAR(45) NOT NULL,
  `data_iddata` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idachievements`, `data_iddata`),
  UNIQUE INDEX `idachievements_UNIQUE` (`idachievements` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`title` ASC) VISIBLE,
  UNIQUE INDEX `text_UNIQUE` (`text` ASC) VISIBLE,
  INDEX `fk_achievements_data1_idx` (`data_iddata` ASC) VISIBLE,
  CONSTRAINT `fk_achievements_data1`
    FOREIGN KEY (`data_iddata`)
    REFERENCES `mydb`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userachievements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`userachievements` ;

CREATE TABLE IF NOT EXISTS `mydb`.`userachievements` (
  `user_iduser` INT UNSIGNED NOT NULL,
  `achievements_idachievements` INT UNSIGNED NOT NULL,
  `visible` TINYINT NULL DEFAULT 0,
  `completed` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`user_iduser`, `achievements_idachievements`),
  INDEX `fk_user_has_achievements_achievements1_idx` (`achievements_idachievements` ASC) VISIBLE,
  INDEX `fk_user_has_achievements_user1_idx` (`user_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_achievements_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_achievements_achievements1`
    FOREIGN KEY (`achievements_idachievements`)
    REFERENCES `mydb`.`achievements` (`idachievements`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`group` (
  `idgroup` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `user_iduser` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idgroup`),
  INDEX `fk_group_user1_idx` (`user_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_group_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`goal` ;

CREATE TABLE IF NOT EXISTS `mydb`.`goal` (
  `idgoal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `goal` VARCHAR(45) NOT NULL,
  `deadline` DATE NOT NULL,
  `user_iduser` INT UNSIGNED NULL,
  `data_iddata` INT UNSIGNED NOT NULL,
  `group_idgroup` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idgoal`, `data_iddata`),
  UNIQUE INDEX `idgoal_UNIQUE` (`idgoal` ASC) VISIBLE,
  INDEX `fk_goal_user1_idx` (`user_iduser` ASC) VISIBLE,
  INDEX `fk_goal_data1_idx` (`data_iddata` ASC) VISIBLE,
  INDEX `fk_goal_group1_idx` (`group_idgroup` ASC) VISIBLE,
  CONSTRAINT `fk_goal_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goal_data1`
    FOREIGN KEY (`data_iddata`)
    REFERENCES `mydb`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goal_group1`
    FOREIGN KEY (`group_idgroup`)
    REFERENCES `mydb`.`group` (`idgroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`progress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`progress` ;

CREATE TABLE IF NOT EXISTS `mydb`.`progress` (
  `idprogress` INT UNSIGNED NOT NULL,
  `value` VARCHAR(45) NULL,
  `userdata_user_iduser` INT UNSIGNED NOT NULL,
  `userdata_data_iddata` INT UNSIGNED NOT NULL,
  `time` DATETIME NULL,
  PRIMARY KEY (`idprogress`, `userdata_user_iduser`, `userdata_data_iddata`),
  UNIQUE INDEX `idprogress_UNIQUE` (`idprogress` ASC) VISIBLE,
  INDEX `fk_progress_userdata1_idx` (`userdata_user_iduser` ASC, `userdata_data_iddata` ASC) VISIBLE,
  CONSTRAINT `fk_progress_userdata1`
    FOREIGN KEY (`userdata_user_iduser` , `userdata_data_iddata`)
    REFERENCES `mydb`.`userdata` (`user_iduser` , `data_iddata`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`group_has_user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`group_has_user` (
  `group_idgroup` INT UNSIGNED NOT NULL,
  `user_iduser` INT UNSIGNED NOT NULL,
  `accepted` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`group_idgroup`, `user_iduser`),
  INDEX `fk_group_has_user_user1_idx` (`user_iduser` ASC) VISIBLE,
  INDEX `fk_group_has_user_group1_idx` (`group_idgroup` ASC) VISIBLE,
  CONSTRAINT `fk_group_has_user_group1`
    FOREIGN KEY (`group_idgroup`)
    REFERENCES `mydb`.`group` (`idgroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_has_user_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
