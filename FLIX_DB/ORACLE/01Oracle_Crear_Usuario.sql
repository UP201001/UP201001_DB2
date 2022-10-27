--PERMITE UTILIZAR PALABRAS RESERVADAS PARA NOMBRES; LE DA
--A ENTENDER A ORACLE QUE NO ES NECESARIO QUE REVISE LOS NOMBRES
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
--'DROPEA' A UN USUARIO Y EL CASCADE HACE QUE TAMBIÉN ELIMINE
--TODO LO QUE LE PERTENECIA (OBJETOS) A ESE USUARIO
DROP USER FLIX CASCADE;
--CREACION DEL USUARIO FLIX
CREATE USER FLIX IDENTIFIED BY FLIX
--SE DEFINE CUAL SERÁ SU ESPACIO DE TRABAJO
DEFAULT TABLESPACE USERS
--SE DEFINE CUÁL SERÁ SU ESPACIO DE TRABAJO TEMPORAL
TEMPORARY TABLESPACE TEMP
--DEFINE EL TAMAÑO MÁXIMO QUE PUEDA TRABAJAR EN EL ESPACIO DE TRABAJO
QUOTA UNLIMITED ON USERS;
--SE LE OTORGAN LOS PERMISOS PARA CONECTAR
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW,
             CREATE SEQUENCE, CREATE SYNONYM,
             INSERT ANY TABLE, SELECT ANY TABLE,
             UPDATE ANY TABLE 
             TO FLIX;
revoke insert any table from FLIX container=all;
revoke select any table from FLIX container=all;
revoke update any table from FLIX container=all;