drop user 'flix'@'localhost';

CREATE DATABASE IF NOT EXISTS oracle_flix;

CREATE USER 'flix'@'localhost' IDENTIFIED BY 'flix';

GRANT SELECT, INSERT, UPDATE, INDEX, CREATE TEMPORARY TABLES, 
CREATE VIEW, SHOW VIEW ON *.* TO 'flix'@'localhost';

