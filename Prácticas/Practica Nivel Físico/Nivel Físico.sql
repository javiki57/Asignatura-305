/*
Pasos a seguir:

**Modificación del tamaño del SGA**

1. Conectar como **sys as sysdba** desde **sqlplus**
2. Cerrar la instancia
    1. Shutdown immediate
3. Intentar acceder desde otro sqlplus o sqldeveloper
4. Crear la instancia sin montarla
5. Intentar acceder desde sqlplus o sqldeveloper
6. Montarla
7. Intentar acceder desde sqlplus
8. Abrir la base de datos
9. Intentar acceder desde **sqlplus**
10. Crear fichero de inicio
11. Editarlo (se ha creado una copia en C:\Users\alumnos\Oracle_instalacion\database\copia por si acaso se rompe algo)
    1. C:\Users\alumnos\Oracle_instalacion\database\initORCL.ora
    2. Borrar las 3 líneas donde se indican los tamaños de las zonas de memoria y modificar las siguientes:
        1. .memory_target=450m
        2. .open_cursors=100
        3. .processes=100
12. Arrancar con el PFILE
    1. Startup pfile ='C:\Users\alumnos\Oracle_instalacion\database\initORCL.ora'
13. Crear un SPFILE nuevo
    1. Create spfile from pfile
14. Parar y arrancar
15. Comprobar de nuevo el tamaño de la SGA

*/

Introduzca el nombre de usuario: sys as sysdba
Introduzca la contrase±a:

Conectado a:
Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
Version 18.3.0.0.0

SQL> Shutdown immediate
Base de datos cerrada.
Base de datos desmontada.
Instancia ORACLE cerrada.

SQL*Plus: Release 18.0.0.0.0 - Production on Mar Mar 9 12:10:55 2021
Version 18.3.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.

Introduzca el nombre de usuario: sys as sysdba
Introduzca la contrase±a:
Conectado a una instancia inactiva.

SQL> startup nomount
Instancia ORACLE iniciada.

Total System Global Area  838857632 bytes
Fixed Size                  8795040 bytes
Variable Size             599785472 bytes
Database Buffers          222298112 bytes
Redo Buffers                7979008 bytes
SQL> ALTER DATABASE MOUNT;

Base de datos modificada.

SQL> ALTER DATABASE OPEN;

Base de datos modificada.

SQL> CREATE pfile FROM spfile;

Archivo creado.

SQL> SHUTDOWN IMMEDIATE;
Base de datos cerrada.
Base de datos desmontada.
Instancia ORACLE cerrada.

SQL> startup pfile='C:\Users\app\alumnos\Oracle_instalacion\database\INITORCL.ORA'
LRM-00109: no se ha podido abrir el archivo de parßmetros 'C:\Users\app\alumnos\Oracle_instalacion\database\INITORCL.ORA'
ORA-01078: fallo al procesar los parßmetros del sistema

SQL> startup pfile='C:\Users\alumnos\Oracle_instalacion\database\initORCL.ora'
Instancia ORACLE iniciada.

Total System Global Area  838857632 bytes
Fixed Size                  8795040 bytes
Variable Size             599785472 bytes
Database Buffers          222298112 bytes
Redo Buffers                7979008 bytes
Base de datos montada.
Base de datos abierta.
SQL>  startup pfile='C:\Users\alumnos\Oracle_instalacion\database\initORCL.ora'
ORA-01081: no se puede iniciar ORACLE cuando ya se estß ejecutando - ciÚrrelo primero
SQL> SHUTDOWN IMMEDIATE;
Base de datos cerrada.
Base de datos desmontada.
Instancia ORACLE cerrada.
SQL>  startup pfile='C:\Users\alumnos\Oracle_instalacion\database\initORCL.ora'
Instancia ORACLE iniciada.

Total System Global Area  473953088 bytes
Fixed Size                  8790848 bytes
Variable Size             385875968 bytes
Database Buffers           71303168 bytes
Redo Buffers                7983104 bytes
Base de datos montada.
Base de datos abierta.

SQL>
