
--2.Ejecuta todos los pasos necesarios para crear un wallet de tipo FILE tal y como hemos visto en clase y en los videos para permitir implementar TDE
--(Transparent Data Encryption) sobre columnas de las tablas que seleccionemos.

ALTER SYSTEM SET "WALLET_ROOT"='C:\Users\alumnos\Oracle\wallet' scope=SPFILE;

ALTER SYSTEM SET TDE_CONFIGURATION="KEYSTORE_CONFIGURATION=FILE" scope=both;

/*
Commandos desde Sqlplus

Microsoft Windows [Versión 10.0.10240]
(c) 2015 Microsoft Corporation. Todos los derechos reservados.

C:\Windows\system32>Sqlplus / as syskm

SQL*Plus: Release 18.0.0.0.0 - Production on Mar Mar 23 13:41:36 2021
Version 18.3.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.


Conectado a:
Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Version 18.3.0.0.0

SQL> ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY password;

almacÚn de claves modificado.

SQL> ADMINISTER KEY MANAGEMENT CREATE AUTO_LOGIN KEYSTORE FROM KEYSTORE IDENTIFIED BY password;

almacÚn de claves modificado.

SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE open IDENTIFIED BY password;

almacÚn de claves modificado.

SQL> ADMINISTER KEY MANAGEMENT SET KEY identified by password with backup;

almacÚn de claves modificado.

SQL>
*/

SHOW PARAMETER WALLET_ROOT;

select * from user_tablespaces;

--4
CREATE TABLE USUARIO1.table1 (
	name VARCHAR2(50),
	first_name VARCHAR2(50),
	last_name VARCHAR2(50)
);

--5
ALTER TABLE USUARIO1.table1 MODIFY (last_name ENCRYPT);
ALTER TABLE USUARIO1.table1 MODIFY (first_name ENCRYPT);

--6
select * from dba_encrypted_columns;

--7
insert into usuario1.table1 values('Roberto','Terriente','Rodr�guez');
insert into usuario1.table1 values('Diego','Ronda','Torrente');
insert into usuario1.table1 values('Antonio','Github','P�rez');

alter system flush buffer_cache;

--Miramos el directorio C:\Users\alumnos\Oracle\oradata\ORCL
/*
Descargamos la herramienta Strings desde el siguiente enlace https://docs.microsoft.com/en-us/sysinternals/downloads/strings
La ejecutamos con el siguiente comando, en el cual buscar� un string que no est� encriptado, en mi caso "Diego"

strings.exe C:\Users\alumnos\Oracle\oradata\ORCL\* | findstr /i Diego

Obtenemos esta salida:
C:\Users\alumnos\Downloads\Strings>strings.exe C:\Users\alumnos\Oracle\oradata\ORCL\* | findstr /i Diego
C:\Users\alumnos\Oracle\oradata\ORCL\REDO03.LOG: Diego
C:\Users\alumnos\Oracle\oradata\ORCL\REDO03.LOG: Diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: /Diego Garcia 1969 to WGS 84 (1) (EPSG OP 15808)
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: /Diego Garcia 1969 to WGS 84 (1) (EPSG OP 15808)
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: /Diego Garcia 1969 to WGS 84 (1) (EPSG OP 15808)
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GEOGCS [ "Diego Garcia 1969", DATUM ["Diego Garcia 1969 (EPSG ID 6724)", SPHEROID ["International 1924 (EPSG ID 7022)", 6378388.0, 297.0]], PRIMEM [ "Greenwich", 0.000000000 ], UNIT ["Decimal Degree", 0.0174532925199433]]
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GEOGCS["Diego Garcia 1969",\n  DATUM["Diego Garcia 1969",\n    SPHEROID[\n      "International 1924",\n      6378388.0,\n      297.0,\n      AUTHORITY["EPSG", "7022"]],\n    TOWGS84[0, 0, 0, 0, 0, 0, 0],\n    AUTHORITY["OGP", "6724"]],\n  PRIMEM["Greenwich", 0.000000000, AUTHORITY["EPSG","8901"]],\n  UNIT["degree (supplier to define representation)", 0.0174532925199433, AUTHORITY["EPSG", "9122"]],\n  AXIS["Lat", NORTH],\n  AXIS["Long", EAST],\n  AUTHORITY["OGP", "4724"]],
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: Diego Garcia 1969
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GEOGCS [ "Diego Garcia 1969", DATUM ["Diego Garcia 1969 (EPSG ID 6724)", SPHEROID ["International 1924 (EPSG ID 7022)", 6378388.0, 297.0]], PRIMEM [ "Greenwich", 0.000000000 ], UNIT ["Decimal Degree", 0.0174532925199433]]
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GEOGCS["Diego Garcia 1969",
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF:   DATUM["Diego Garcia 1969",
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GRANT UPDATE ON USUARIO1.TABLE1 TO diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: DIEGO
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GRANT SELECT ON USUARIO1.TABLE1 TO diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: DIEGO
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: GRANT CONNECT TO diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: DIEGO
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF: create user diego identified by *
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF:  TO diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSAUX01.DBF:  TO diego
C:\Users\alumnos\Oracle\oradata\ORCL\SYSTEM01.DBF: DIEGO
C:\Users\alumnos\Oracle\oradata\ORCL\SYSTEM01.DBF: DIEGO
C:\Users\alumnos\Oracle\oradata\ORCL\SYSTEM01.DBF: DIEGO

No puedo concluir nada ya que no veo información sensible expuesta.
*/

--8
create or replace function USUARIO1.sec_function(p_schema varchar2, p_obj varchar2) Return varchar2 is
   usuario VARCHAR2(100);
Begin
    usuario := SYS_CONTEXT('userenv', 'SESSION_USER');
    return 'UPPER(user_name) = ''' || usuario || '''';
End;
 /

 -- userenv = El contexto de aplicaci�n
 -- p_obj es el nombre de la tabla o vista al cual se le aplicar� la pol�tica
 -- p_schema es el schema en el que se encuentra dicha tabla o vista.


ALTER TABLE USUARIO1.table1 ADD (user_name VARCHAR2(50));
UPDATE USUARIO1.table1 SET USER_NAME=NAME; -- El user_name ser� el name.


--9

begin
 dbms_rls.add_policy
  (object_schema=>'USUARIO1',
   object_name=>'TABLE1',
   policy_name=>'EMP_POLICY',
   function_schema=>'USUARIO1',
   policy_function=>'SEC_FUNCTION');
end;
/

create user diego identified by psswd
default tablespace TS_SECRETARIA
quota 1M on TS_SECRETARIA;

GRANT CONNECT TO diego;
GRANT SELECT ON USUARIO1.TABLE1 TO diego;

-- Abrimos sqlplus, nos conectamos como diego y ejecutamos SELECT * FROM USUARIO1.TABLE1;
-- Obtenemos el los datos de ese usuario.

--Para desactivar la pol�tica:
/*
begin
 DBMS_RLS.ENABLE_POLICY (        object_schema=>'USUARIO1',    object_name=>'TABLE1',
policy_name=>'EMP_POLICY', enable=>false);
end;
/
*/

--10
GRANT UPDATE ON USUARIO1.TABLE1 TO diego;

--11
--Muestra solamente los datos de diego.

--12
-- Solamente se efectua sobre los datos de diego.

--13
--No. �nicamente tiene sentido que se pueda modificar la columna user_name ya que es la fila que se puede ver.

--14
-- Se debe a�adir el update_check al crear la pol�tica.

--drop de la pol�tica:
BEGIN

dbms_rls.drop_policy (

  object_schema=>'USUARIO1',

  object_name=>'TABLE1',

  policy_name=>'EMP_POLICY' );

end;
/

begin
 dbms_rls.add_policy
  (object_schema=>'USUARIO1',
   object_name=>'TABLE1',
   policy_name=>'EMP_POLICY',
   function_schema=>'USUARIO1',
   policy_function=>'SEC_FUNCTION',
   update_check=>true);
end;
/

--15
begin
 DBMS_RLS.ENABLE_POLICY (        object_schema=>'USUARIO1',    object_name=>'TABLE1',
policy_name=>'EMP_POLICY', enable=>false);
end;
/

begin dbms_rls.add_policy (
   object_schema => 'USUARIO1', 
   object_name => 'TABLE1', 
   policy_name => 'SecondPolicy', 
   function_schema => 'USUARIO1', 
   policy_function => 'SEC_FUNCTION', 
   sec_relevant_cols => 'first_name');
end;
/

