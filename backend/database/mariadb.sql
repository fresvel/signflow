/*
Create the Docker container for the mariadb instance

docker run -d --name deasy-mariadb \
  -p 127.0.0.1:3306:3306 \
  -e MARIADB_ROOT_PASSWORD=my-secret-pw \
  mariadb:latest
*/

CREATE DATABASE IF NOT EXISTS DEASY;
USE DEASY;

CREATE TABLE IF NOT EXISTS Users(
  userId  INT PRIMARY KEY AUTO_INCREMENT,
  numberId VARCHAR(20),
  typeId ENUM("Cardid", "Passportid"),
  name VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  status ENUM("Active", "Reported", "Inactive", "Deactive"),
  UNIQUE (numberId, typeId) 
)


CREATE TABLE IF NOT EXISTS Countries(
  countryId INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  iso_code VARCHAR(2) NOT NULL, 
  itu_code VARCHAR(7) NOT NULL,
  continent ENUM("América", "África", "Europa", "Asia", "Oceanía") NOT NULL,
  status ENUM("Active", "Inactive") DEFAULT "Active"
);

CREATE TABLE IF NOT EXISTS Emails(
  emailId INT PRIMARY KEY AUTO_INCREMENT,
  userId INT,
  email VARCHAR(255) NOT NULL,
  type ENUM("Personal", "Asignned"),
  status ENUM("Verified", "Unconfirmed"),
  FOREIGN KEY (userId) REFERENCES Users(userId),
  UNIQUE (userId, email)

);


CREATE TABLE IF NOT EXISTS Addresses(
  addressId INT PRIMARY KEY AUTO_INCREMENT,
  userId INT,
  countryId INT NOT NULL DEFAULT 54,
  city VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  zipCode VARCHAR(20) NOT NULL,
  gps_coord VARCHAR(25) NOT NULL,
  type ENUM("Home", "Work", "Other"),
  FOREIGN KEY (userId) REFERENCES Users(userId),
  FOREIGN KEY (countryId) REFERENCES Countries(countryId)
);

CREATE TABLE IF NOT EXISTS Phones(
  phoneId INT PRIMARY KEY AUTO_INCREMENT,
  userId INT,
  phoneNumber VARCHAR(20) NOT NULL,
  type ENUM("Mobile", "Home", "Work", "Other"),
  carrier ENUM("Movistar", "Tuenti", "Claro", "CNT"),
  countryId INT NOT NULL,
  FOREIGN KEY (countryId) REFERENCES Countries(countryId),
  FOREIGN KEY (userId) REFERENCES Users(userId),
  UNIQUE( countryId, phoneNumber, userId)
);

CREATE TABLE IF NOT EXISTS Channels (
  channelId INT PRIMARY KEY AUTO_INCREMENT,
  name ENUM ("WhatsApp", "Telegram"),
  status ENUM("Verified", "Unconfirmed"),
  phoneId INT NOT NULL,
  FOREIGN KEY (phoneId) REFERENCES Phones(phoneId),
  UNIQUE (phoneId, name)
);

-- Create triggers to update status of User state based on channels and emails


CREATE TABLE IF NOT EXISTS Documents (
  documentId INT PRIMARY KEY AUTO_INCREMENT,
  year INT NOT NULL,
  period ENUM("Primer Periodo", "Segundo Periodo"),
  vesion VARCHAR(10) DEFAULT '1.0',
  template_url VARCHAR(2048) NOT NULL,
  document_url VARCHAR(2048) NOT NULL,
  type ENUM("Report", "Memorandum", "Document", "Record"),
  status ENUM("Signed", "Made", "Checked", "Approved", "Started") DEFAULT "Started",
  code VARCHAR(20) NOT NULL,
  UNIQUE (code, vesion)
);