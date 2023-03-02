DROP DATABASE IF EXISTS dbFitty;

CREATE DATABASE dbFitty;

USE dbFitty;

DROP TABLE IF EXISTS tblUser;

CREATE TABLE tblUser(
  idUser INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  dtUsername VARCHAR(255) NOT NULL UNIQUE CHECK (dtUsername <> ''),
  dtEmail VARCHAR(255) NOT NULL UNIQUE CHECK (dtEmail <> ''),
  dtPassword TEXT NOT NULL,
  dtPicture INT UNSIGNED DEFAULT 1,
  dtGroupInvites TINYINT DEFAULT 1,
  dtTemperature ENUM('Celsius','Fahrenheit') DEFAULT 'Celsius',
  dtDistance ENUM('km','mi') DEFAULT 'km',
  dtVolume ENUM('l','gal') DEFAULT 'l',
  dtWeight ENUM('kg','pound') DEFAULT 'kg',
  dtSummary TINYINT DEFAULT 1,
  dtWebsiteNoti TINYINT DEFAULT 1,
  dtEmailNoti TINYINT DEFAULT 1,
  dtDiscordNoti TINYINT DEFAULT 0,
  dtPrivate TINYINT DEFAULT 0
);

DROP TABLE IF EXISTS tblInterest;

CREATE TABLE tblInterest(
  idInterest INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  dtInterestName VARCHAR(255) NOT NULL CHECK (dtInterestName <> ''),
  dtCategory ENUM('Health','Tracker','Fitness') NOT NULL,
  dtUnit ENUM('h','kcal','bpm','l','kg','Celsius','d'),
  dtFitbit TINYINT DEFAULT 0
);

DROP TABLE IF EXISTS tblUserInterest;

CREATE TABLE tblUserInterest(
  fiUser INT UNSIGNED NOT NULL,
  fiInterest INT UNSIGNED NOT NULL,
  dtPrivate TINYINT DEFAULT 0,

  CONSTRAINT fiUser1
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fiInterest1
    FOREIGN KEY (fiInterest) REFERENCES tblInterest (idInterest)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  
  PRIMARY KEY (fiUser, fiInterest)
);

DROP TABLE IF EXISTS tblNotification;

CREATE TABLE tblNotification(
  idNotification INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fiUser INT UNSIGNED NOT NULL,
  dtTitle VARCHAR(255) NOT NULL CHECK (dtTitle <> ''),
  dtText VARCHAR(255) NOT NULL CHECK (dtText <> ''),
  dtSeen TINYINT DEFAULT 0,
  dtVisible TINYINT DEFAULT 1,
  dtTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fiUser2
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tblAchievements;

CREATE TABLE tblAchievement(
  idAchievement INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fiInterest INT UNSIGNED NOT NULL,
  dtTitle VARCHAR(255) NOT NULL CHECK (dtTitle <> ''),
  dtText VARCHAR(255) NOT NULL CHECK (dtText <> ''),
  dtPicture INT UNSIGNED DEFAULT 100,
  dtCondition VARCHAR(255) NOT NULL CHECK (dtCondition <> ''),

  CONSTRAINT fiInterest2
    FOREIGN KEY (fiInterest) REFERENCES tblInterest (idInterest)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tblUserAchievements;

CREATE TABLE tblUserAchievements(
  fiUser INT UNSIGNED NOT NULL,
  fiAchievement INT UNSIGNED NOT NULL,
  dtVisible TINYINT DEFAULT 0,
  dtCompleted TINYINT DEFAULT 0,

  CONSTRAINT fiUser3
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fiAchievement1
    FOREIGN KEY (fiAchievement) REFERENCES tblAchievement (idAchievement)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  PRIMARY KEY (fiUser, fiAchievement)
);

DROP TABLE IF EXISTS tblGroup;

CREATE TABLE tblGroup(
  idGroup INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fiUser INT UNSIGNED NOT NULL,
  dtGroupName VARCHAR(255) NOT NULL CHECK (dtGroupName <> ''),
  dtDescription VARCHAR(255) NOT NULL CHECK (dtDescription <> ''),

  CONSTRAINT fiUser4
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tblGoal;

CREATE TABLE tblGoal(
  idGoal INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fiUser INT UNSIGNED,
  fiGroup INT UNSIGNED,
  fiInterest INT UNSIGNED NOT NULL,
  dtTarget INT NOT NULL,
  dtDeadline DATE NOt NULL,

  CONSTRAINT fiUser5
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  
  CONSTRAINT fiGroup1
    FOREIGN KEY (fiGroup) REFERENCES tblGroup (idGroup)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fiInterest3
    FOREIGN KEY (fiInterest) REFERENCES tblInterest (idInterest)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tblProgress;

CREATE TABLE tblProgress(
  idProgress INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fiUser INT UNSIGNED NOT NULL,
  fiInterest INT UNSIGNED NOT NULL,
  dtValue INT NOT NULL,
  dtTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fiUser6
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fiInterest4
    FOREIGN KEY (fiInterest) REFERENCES tblInterest (idInterest)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tblUserGroup;

CREATE TABLE tblUserGroup(
  fiUser INT UNSIGNED NOT NULL,
  fiGroup INT UNSIGNED NOT NULL,
  dtAccepted TINYINT DEFAULT 0,

  CONSTRAINT fiUser7
    FOREIGN KEY (fiUser) REFERENCES tblUser (idUser)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fiGroup2
    FOREIGN KEY (fiGroup) REFERENCES tblGroup (idGroup)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  PRIMARY KEY (fiUser, fiGroup)
);

INSERT INTO tblInterest (dtInterestName,dtCategory,dtUnit,dtFitbit) VALUES
('Sleep','Health','h',1),
('Nutrition','Health','kcal',0),
('Heart Rate','Health','bpm',1),
('Water','Health','l',0),
('Weight','Health','kg',0),
('Temperature','Health','Celsius',1),
('Meat','Tracker','d',0),
('Alcohol','Tracker','d',0),
('Sugar','Tracker','d',0),
('Vegan','Tracker','d',0),
('Vegetarian','Tracker','d',0),
('Activity','Fitness','h',1),
('Distance','Fitness','km',1);

DROP PROCEDURE IF EXISTS spSignUp;

DELIMITER $$

CREATE PROCEDURE spSignUp(IN inJSON JSON, OUT outJSON JSON)
BEGIN
  DECLARE vJSONSCHEMA JSON;
  DECLARE fiUser INT;
  DECLARE vUser JSON;

  DECLARE EXIT HANDLER FOR 1062
	BEGIN
 	  SET outJSON = '{"code": 400, "label": "Duplicate Key", "message": "This user already exists"}';
	END;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET outJSON = '{"code": 500,"label": "Internal Server Error","message": "The procedure has encountered a situation it does not know how to handle."}';
	END;

	DECLARE EXIT HANDLER FOR 1406
	BEGIN
 	  SET outJSON = '{"code": 400, "label": "Bad Request", "message": "Input is too long"}';
	END;
    
  DECLARE EXIT HANDLER FOR 3819
	BEGIN
 	  SET outJSON = '{"code": 400, "label": "Bad Request", "message": "Input cannot be empty"}';
	END;

  SET vJSONSchema = '{
		"type":"object",
		"properties": {
      "username": {"type":"string"},
      "email": {"type":"string"},
      "password": {"type":"string"},
      "picture": {"type":"number"}},
		"required": ["username","email","password","picture"]
	}';
  IF NOT (JSON_VALID(inJSON)) THEN
		SET outJSON = '{
			"code": 400,
          "label": "Bad Request",
          "message": "The JSON string provided is not valid."
        }';
	ELSE
		INSERT INTO tblUser (dtUsername, dtEmail, dtPassword,dtPicture) VALUES 
			(JSON_UNQUOTE(JSON_EXTRACT(inJSON,'$.username')),JSON_UNQUOTE(JSON_EXTRACT(inJSON,'$.email')),JSON_UNQUOTE(JSON_EXTRACT(inJSON,'$.password')),JSON_UNQUOTE(JSON_EXTRACT(inJSON,'$.picture')));
    SELECT LAST_INSERT_ID() INTO fiUser;
    SELECT JSON_OBJECT('idUser',idUser, 'username', dtUsername, 'email', dtEmail, 'picture', dtPicture, 'groupInvites', dtGroupInvites, 'temperature', dtTemperature, 'distance', dtDistance, 'volume', dtVolume, 'weight', dtWeight, 'summary', dtSummary, 'websiteNoti', dtWebsiteNoti, 'emailNoti', dtEmailNoti, 'discordNoti', dtDiscordNoti, 'private', dtPrivate)INTO vUser FROM tblUser WHERE idUser = fiUser ;
    SET outJSON = CONCAT('{
			"code": 200,
			"label": "OK",
			"message": ',vUser,
    '}');
	END IF;
END$$

DELIMITER ;


