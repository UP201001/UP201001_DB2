DROP TABLE STAR_BILLINGS;
DROP TABLE ACTORS;
DROP TABLE RENTAL_HISTORY;
DROP TABLE MEDIA;
DROP TABLE MOVIES;
DROP TABLE CUSTOMERS;


CREATE TABLE `customers` (
  `CUSTOMER_ID` int(10) NOT NULL AUTO_INCREMENT,
  `LAST_NAME` varchar(25) NOT NULL,
  `FIRST_NAME` varchar(25) NOT NULL,
  `HOME_PHONE` varchar(12) NOT NULL,
  `ADDRESS` varchar(100) NOT NULL,
  `CITY` varchar(30) NOT NULL,
  `STATE` varchar(2) NOT NULL,
  `EMAIL` varchar(25) DEFAULT NULL,
  `CELL_PHONE` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `movies` (
  `TITLE_ID` int(10) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(60) NOT NULL,
  `DESCRIPTION` varchar(400) NOT NULL,
  `RATING` varchar(4) DEFAULT NULL,
  `CATEGORY` varchar(20) DEFAULT NULL,
  `RELEASE_DATE` int(11) NOT NULL,
  PRIMARY KEY (`TITLE_ID`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`RATING` = 'G' OR `RATING` = 'PG' OR `RATING` = 'PG13' OR `RATING` = 'R'),
  CONSTRAINT `CONSTRAINT_2` CHECK (`CATEGORY` = 'DRAMA' OR `CATEGORY` = 'COMEDY' OR `CATEGORY` = 'ACTION' OR `CATEGORY` = 'CHILD' OR `CATEGORY` = 'SCIFI' OR `CATEGORY` = 'DOCUMENTARY')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `media` (
  `MEDIA_ID` int(10) NOT NULL AUTO_INCREMENT,
  `FORMAT` varchar(3) NOT NULL,
  `TITLE_ID` int(10) NOT NULL,
  PRIMARY KEY (`MEDIA_ID`),
  KEY `TITLE_ID` (`TITLE_ID`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`TITLE_ID`) REFERENCES `movies` (`TITLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `rental history` (
  `MEDIA_ID` int(10) NOT NULL,
  `RENTAL_DATE` date NOT NULL DEFAULT current_timestamp(),
  `CUSTOMER_ID` int(10) NOT NULL,
  `RETURN_DATE` date DEFAULT NULL,
  PRIMARY KEY (`MEDIA_ID`,`RENTAL_DATE`),
  KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  CONSTRAINT `rental history_ibfk_1` FOREIGN KEY (`MEDIA_ID`) REFERENCES `media` (`MEDIA_ID`),
  CONSTRAINT `rental history_ibfk_2` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customers` (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `actors` (
  `ACTOR_ID` int(10) NOT NULL AUTO_INCREMENT,
  `STAGE_NAME` varchar(40) NOT NULL,
  `FIRST_NAME` varchar(25) NOT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `BIRTH_DATE` date NOT NULL,
  PRIMARY KEY (`ACTOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `star_billings` (
  `ACTOR_ID` int(10) NOT NULL,
  `TITLE_ID` int(10) NOT NULL,
  `COMMENTS` varchar(40) NOT NULL,
  PRIMARY KEY (`ACTOR_ID`,`TITLE_ID`),
  KEY `TITLE_ID` (`TITLE_ID`),
  CONSTRAINT `star_billings_ibfk_1` FOREIGN KEY (`TITLE_ID`) REFERENCES `movies` (`TITLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `star_billings_ibfk_2` FOREIGN KEY (`ACTOR_ID`) REFERENCES `actors` (`ACTOR_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;