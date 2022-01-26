-- MySQL Script generated by MySQL Workbench
-- Wed Jan 26 10:18:22 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mypet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mypet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mypet` DEFAULT CHARACTER SET utf8 ;
USE `mypet` ;

-- -----------------------------------------------------
-- Table `mypet`.`Gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Gender` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Species`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Species` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `ScientificName` VARCHAR(100) NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IdRemoved` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Breed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Breed` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `IdSpecies` VARCHAR(36) NOT NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  INDEX `Breed_Species_idx` (`IdSpecies` ASC) VISIBLE,
  CONSTRAINT `Breed_Species`
    FOREIGN KEY (`IdSpecies`)
    REFERENCES `mypet`.`Species` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Owner` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(200) NULL,
  `PhoneNumber` INT NULL,
  `Email` VARCHAR(100) NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Pet` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `IdBreed` VARCHAR(36) NOT NULL,
  `IdGender` VARCHAR(36) NOT NULL,
  `Birth` DATETIME NULL,
  `IdOwner` VARCHAR(36) NOT NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Pet_Breed_idx` (`IdBreed` ASC) VISIBLE,
  INDEX `Pet_Owner_idx` (`IdOwner` ASC) VISIBLE,
  INDEX `Pet_Gender_idx` (`IdGender` ASC) VISIBLE,
  CONSTRAINT `Pet_Breed`
    FOREIGN KEY (`IdBreed`)
    REFERENCES `mypet`.`Breed` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Pet_Owner`
    FOREIGN KEY (`IdOwner`)
    REFERENCES `mypet`.`Owner` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Pet_Gender`
    FOREIGN KEY (`IdGender`)
    REFERENCES `mypet`.`Gender` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Clinic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Clinic` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(200) NULL,
  `PhoneNumber` INT NOT NULL,
  `Email` VARCHAR(100) NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Veterinary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Veterinary` (
  `Id` VARCHAR(36) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `VeterinaryNumber` INT NOT NULL,
  `PhoneNumber` INT NULL,
  `Email` VARCHAR(100) NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`ClinicVeterinary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`ClinicVeterinary` (
  `IdClinic` VARCHAR(36) NOT NULL,
  `IdVeterinary` VARCHAR(36) NOT NULL,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`IdClinic`, `IdVeterinary`),
  INDEX `ClinicVeterinary_Veterinary_idx` (`IdVeterinary` ASC) VISIBLE,
  CONSTRAINT `ClinicVeterinary_Clinic`
    FOREIGN KEY (`IdClinic`)
    REFERENCES `mypet`.`Clinic` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ClinicVeterinary_Veterinary`
    FOREIGN KEY (`IdVeterinary`)
    REFERENCES `mypet`.`Veterinary` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mypet`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mypet`.`Appointment` (
  `Id` VARCHAR(36) NOT NULL,
  `IdClinic` VARCHAR(36) NOT NULL,
  `IdVeterinary` VARCHAR(36) NOT NULL,
  `IdPet` VARCHAR(36) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Observations` TEXT NULL,
  `Urgency` TINYINT NOT NULL DEFAULT 0,
  `Updated` DATETIME NOT NULL DEFAULT NOW(),
  `IsRemoved` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;