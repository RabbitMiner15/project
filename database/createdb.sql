DROP DATABASE IF EXISTS dbFitty;

CREATE DATABASE dbFitty;

USE dbFitty;

DROP TABLE IF EXISTS tblUser;

CREATE TABLE tblUser(
  idUser INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  dtUsername VARCHAR(255) NOT NULL UNIQUE,
  dtEmail VARCHAR(255) NOT NULL UNIQUE,
  dtPassword TEXT NOT NULL,
  dtPicture INT UNSIGNED DEFAULT 1,
  dtGroupInvites TINYINT DEFAULT 1,
  dtTemperature ENUM('°C','Fahrenheit') DEFAULT '°C',
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
  dtInterestName VARCHAR(255) NOT NULL,
  dtCategory ENUM('Health','Tracker','Fitness') NOT NULL,
  dtUnit ENUM('h','kcal','bpm','l','kg','°C','d'),
  dtOrigin VARCHAR(255) NOT NULL
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
  dtTitle VARCHAR(255) NOT NULL,
  dtText VARCHAR(255) NOT NULL,
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
  dtTitle VARCHAR(255) NOT NULL,
  dtText VARCHAR(255) NOT NULL,
  dtPicture INT UNSIGNED DEFAULT 100,
  dtCondition VARCHAR(255) NOT NULL,

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
  dtGroupName VARCHAR(255) NOT NULL,
  dtDescription VARCHAR(255) NOT NULL,

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
  dtDeadline DATE NOT NULL,
  dtCreationDate DATE DEFAULT CURRENT_DATE

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

INSERT INTO tblInterest (dtInterestName,dtCategory,dtUnit,dtOrigin) VALUES
('Sleep','Health','h','M | F'),
('Nutrition','Health','kcal','M'),
('Heart Rate','Health','bpm','M | F'),
('Water','Health','l','M'),
('Weight','Health','kg','M'),
('Temperature','Health','°C','M | F'),
('Meat Free','Tracker','d','M'),
('Alcohol Free','Tracker','d','M'),
('Sugar Free','Tracker','d','M'),
('Vegan','Tracker','d','M'),
('Smoke Free','Tracker','d','M'),
('Activity','Fitness','h','M | F'),
('Distance','Fitness','km','M | F');


