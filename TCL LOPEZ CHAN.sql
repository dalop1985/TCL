/**************************************************************************************************
* David José de Jesús López Chan	       													      *
* Sistema: Nómina																	    		  *
* Objetivo: Creación de Código TCL, Rollback y Savepoints					                      *																			  
* ------------------------------------------------------------------------------------------------*
*																						          *
* Versión   Fecha        Usuario            Descripción									          *
* -------   ----------   ------------------ ------------------------------------------- ----------*
*  1.0      16/11/2022   David López	    Creación de dos TCL en las tablas de nompersonas y    *
*											nomempleados.										  *
**************************************************************************************************/
/*Primer Ejercicio*/
USE NOMINA;

SELECT @@autocommit; /*Seteando el Autocommit*/
SET AUTOCOMMIT = 0;

START TRANSACTION; /*Ejemplo sin usar el COMMIT, donde eliminamos el registro 2 de las ciudadades*/
DELETE FROM princiudades WHERE PRIN_IDCIUDAD = 2;
SELECT * FROM princiudades; /*Cuando vemos la tabla el registro 2 ya no está*/
ROLLBACK;/*Acá estamos devolviendo el registro eliminado*/
SELECT * FROM princiudades; /*Vemos que ya está el registro 2 que se eliminó*/

START TRANSACTION; /*Ejemplo usando el COMMIT, donde eliminamos el registro 2 de las ciudadades y vemos que no se recupera con el ROLLBACK*/
DELETE FROM princiudades WHERE PRIN_IDCIUDAD = 2;
SELECT * FROM princiudades;/*Cuando vemos la tabla el registro 2 ya no está*/
COMMIT;/*Validamos que el registro ya no va a regrsar*/
ROLLBACK;/*Acá estamos devolviendo el registro eliminado*/
SELECT * FROM princiudades;/*Vemos que ya NO está el registro 2 que se eliminó ún aplicando el ROLLBACK*/




/*Segundo Ejercicio*/
USE NOMINA;

SELECT * FROM nomdepartamento;
SELECT @@autocommit; /*Seteando el Autocommit*/
SET AUTOCOMMIT = 0;

START TRANSACTION; /*Ejemplo para agregar los savepoint después del 4to y 8vo registro*/
INSERT INTO nomdepartamento VALUES (6,'Patrimonio',4,'9996456545',5);
INSERT INTO nomdepartamento VALUES (7,'Egresos',4,'9996456545',5);
INSERT INTO nomdepartamento VALUES (8,'Contabilidad',4,'9996456545',5);
INSERT INTO nomdepartamento VALUES (9,'Presidencia',4,'9996456545',5);
SAVEPOINT DEPAS; /*Creando un SavePoint*/
INSERT INTO nomdepartamento VALUES (10,'Comunicación',4,'9996456545',5);	
INSERT INTO nomdepartamento VALUES (11,'Almacén',4,'9996456545',5);
INSERT INTO nomdepartamento VALUES (12,'Tecnologías',4,'9996456545',5);
INSERT INTO nomdepartamento VALUES (13,'ParqueVehicular',4,'9996456545',5);
SAVEPOINT DEPAS2; /*Creando el Segundo SavePoint*/
RELEASE SAVEPOINT DEPAS; /*Eliminando el savepoint DEPAS*/
ROLLBACK TO DEPAS; /*Intentando regresar al savepoint DEPAS*/
SELECT * FROM nomdepartamento; /*Validando la información*/



