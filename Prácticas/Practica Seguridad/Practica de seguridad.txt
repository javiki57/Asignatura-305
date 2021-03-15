--3.
select * from user_tablespaces where tablespace_name like 'TS_SECRETARIA';

create tablespace TS_SECRETARIA
DATAFILE 'autoracle.dbf'
SIZE 10M
AUTOEXTEND ON;

--4.
create profile PERF_ADMINISTRATIVO
    LIMIT SESSIONS_PER_USER 3
    IDLE_TIME 5;

--5

create profile PERF_ALUMNO
    LIMIT SESSIONS_PER_USER 4
    PASSWORD_LIFE_TIME 30;

--7
create role R_ADMINISTRATIVO_SUPER;

GRANT CONNECT, CREATE TABLE
    TO R_ADMINISTRATIVO_SUPER;
    
--8
CREATE USER USUARIO1
    IDENTIFIED BY usuario
    DEFAULT TABLESPACE TS_SECRETARIA
    QUOTA 1M ON TS_SECRETARIA
    PROFILE PERF_ADMINISTRATIVO;
    
CREATE USER USUARIO2
    IDENTIFIED BY usuario
    DEFAULT TABLESPACE TS_SECRETARIA
    QUOTA 1M ON TS_SECRETARIA
    PROFILE PERF_ADMINISTRATIVO;

GRANT R_ADMINISTRATIVO_SUPER
    TO USUARIO1, USUARIO2;

--9
CREATE TABLE USUARIO1.TABLA2 (CODIGO NUMBER);
CREATE TABLE USUARIO2.TABLA2 (CODIGO NUMBER);

--10
CREATE OR REPLACE
    PROCEDURE USUARIO1.PR_INSERTA_TABLA2 (P_CODIGO IN NUMBER) AS
    BEGIN
        INSERT INTO USUARIO1.TABLA2
            VALUES (P_CODIGO);
    END PR_INSERTA_TABLA2;
    /

/*
Introduzca el nombre de usuario: USUARIO1
Introduzca la contrase±a:

Conectado a:
Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Version 18.3.0.0.0
*/

/*

SQL> exec nombre_procedimiento(param);
BEGIN nombre_procedimiento(param); END;

                           *
ERROR en lÝnea 1:
ORA-06550: lÝnea 1, columna 28:
PLS-00201: el identificador 'PARAM' se debe declarar
ORA-06550: lÝnea 1, columna 7:
PL/SQL: Statement ignored

*/

--12
GRANT EXECUTE ON USUARIO1.PR_INSERTA_TABLA2
    TO USUARIO2;
    
--14
--Se inserta en la tabla del usuario1 ya que el procedimiento funciona sobre su tabla pero ejecutado por otro usuario.

--15
CREATE OR REPLACE
    PROCEDURE USUARIO1.PR_INSERTA_TABLA2 (P_CODIGO IN NUMBER) AS
    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO TABLA2 VALUES ('||P_CODIGO||')';
    END PR_INSERTA_TABLA2;
/

--16 Sí

--17 No

--18
CREATE OR REPLACE
    PROCEDURE USUARIO1.PR_CREA_TABLA (P_TABLA IN VARCHAR2, P_ATRIBUTO IN VARCHAR2) AS
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE '||P_TABLA||'('||P_ATRIBUTO||' NUMBER(9))';
    END PR_CREA_TABLA;
/

--19
--No funciona porque no se han otorgado el rol al usuario.

--20
GRANT CREATE TABLE
    TO USUARIO1;
    
GRANT CREATE TABLE
    TO USUARIO2;
    
GRANT EXECUTE ON USUARIO1.PR_INSERTA_TABLA2
    TO USUARIO2;
    
--21 Sí.


