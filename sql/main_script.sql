
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dmitrenko
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dmitrenko
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dmitrenko` DEFAULT CHARACTER SET utf8 ;
USE `dmitrenko` ;

-- -----------------------------------------------------
-- Table `dmitrenko`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` VARCHAR(300) NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`game_chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`game_chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `game_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_chat_game1_idx` (`game_id` ASC),
  CONSTRAINT `fk_game_chat_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `dmitrenko`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `card_number` VARCHAR(45) NOT NULL,
  `expiration_date` CHAR(4) NOT NULL,
  `cvc` CHAR(3) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`security`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`security` (
  `login` VARCHAR(30) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`login`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL,
  `username` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `inform` VARCHAR(500) NULL,
  `game_chat_id` INT NULL,
  `payment_id` INT NOT NULL,
  `security_login` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`, `payment_id`, `security_login`),
  INDEX `fk_user_game_chat1_idx` (`game_chat_id` ASC),
  INDEX `fk_user_payment1_idx` (`payment_id` ASC),
  INDEX `fk_user_security1_idx` (`security_login` ASC),
  UNIQUE INDEX `security_login_UNIQUE` (`security_login` ASC),
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC),
  CONSTRAINT `fk_user_game_chat1`
    FOREIGN KEY (`game_chat_id`)
    REFERENCES `dmitrenko`.`game_chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `dmitrenko`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_security1`
    FOREIGN KEY (`security_login`)
    REFERENCES `dmitrenko`.`security` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `message` LONGTEXT NOT NULL,
  `game_chat_id` INT NOT NULL,
  PRIMARY KEY (`id`, `game_chat_id`),
  INDEX `fk_message_game_chat1_idx` (`game_chat_id` ASC),
  CONSTRAINT `fk_message_game_chat1`
    FOREIGN KEY (`game_chat_id`)
    REFERENCES `dmitrenko`.`game_chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `size` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `game_chat_id` INT NOT NULL,
  PRIMARY KEY (`id`, `game_chat_id`),
  INDEX `fk_media_game_chat1_idx` (`game_chat_id` ASC),
  CONSTRAINT `fk_media_game_chat1`
    FOREIGN KEY (`game_chat_id`)
    REFERENCES `dmitrenko`.`game_chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dmitrenko`.`audio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dmitrenko`.`audio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `duration` INT NOT NULL,
  `game_chat_id` INT NOT NULL,
  PRIMARY KEY (`id`, `game_chat_id`),
  INDEX `fk_audio_game_chat1_idx` (`game_chat_id` ASC),
  CONSTRAINT `fk_audio_game_chat1`
    FOREIGN KEY (`game_chat_id`)
    REFERENCES `dmitrenko`.`game_chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
