/*
Ejecutar estas sentencias en system, para crear el usuario donde vamos a trabajar

create user clase7 identified by bd;
grant connect to clase7;
grant create table, create sequence to clase7;
alter user clase7 quota 10M on users;

*/

--A partir de aquí, todo se ejecuta en el usuario que acabamos de crear.

--Creamos la tabla
create table mensajes
(Codigo NUMBER(2) PRIMARY KEY,
Texto VARCHAR2(50) );


set serveroutput on --esta sentencia solo se ejecuta una vez.
declare 
    var_cod_mensaje1 number(2) default 1;
    var_texto_men1 varchar2(50);
    var_cod_mensaje2 number(2) := 2;
    var_texto_men2 varchar2(50);
begin
    var_texto_men1 :='Madrid 3, Liverpool 1';
    insert into mensajes values (var_cod_mensaje1, var_texto_men1);
    insert into mensajes values (var_cod_mensaje2, 'Falta poco para la vuelta');
    --Mostrar un mensaje por pantalla
    dbms_output.put_line(var_texto_men1);
    --Como borrar datos de una tabla
    var_cod_mensaje1 := 2;
    delete from mensajes where CODIGO = var_cod_mensaje1; --variable de acoplamiento
    commit;
end;
/

--Procedimiento para leer datos

declare 
    var_cod_mensaje1 number(2) default 1;
    var_texto_men1 varchar2(50);
    var_cod_mensaje2 number(2) := 2;
    var_texto_men2 varchar2(50);
begin
    var_cod_mensaje1 :=2;
    select texto into var_texto_men1 from mensajes where codigo = var_cod_mensaje1;
    dbms_output.put_line('El valor leido es: '||var_texto_men1);
end;
/

--creamos una sequencia
create sequence seq_mensajes start with 10 increment by 2;

--Como crear un bucle for
declare
    i number;
begin
    for i in 1..10 loop
        insert into mensajes values (seq_mensajes.nextval, 'mensaje nuevo '||i);
    end loop;
    commit;
end;
/

