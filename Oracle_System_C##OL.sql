-- USER SQL
CREATE USER C##Oracle_Local IDENTIFIED BY Password123 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER C##Oracle_Local QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT "CONNECT" TO C##Oracle_Local;

-- SYSTEM PRIVILEGES
GRANT CREATE TRIGGER TO C##Oracle_Local ;
GRANT CREATE SEQUENCE TO C##Oracle_Local ;
GRANT CREATE TABLE TO C##Oracle_Local ;
GRANT CREATE PROCEDURE TO C##Oracle_Local ;
GRANT CREATE VIEW TO C##Oracle_Local ;


