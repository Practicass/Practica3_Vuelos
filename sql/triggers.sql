--Primer trigger: revisa que el vuelo que se introduce tenga una fecha anterior al a�o de fabricaci�on del avi�n
CREATE OR REPLACE TRIGGER AvionNoFabricado
BEFORE INSERT OR UPDATE ON VUELOS
FOR EACH ROW
DECLARE
  agno NUMBER(4);
BEGIN
  SELECT A.AgnoFabricacion INTO agno FROM AVIONES A
  WHERE A.Matricula = :new.Avion;
  if (agno > EXTRACT(YEAR FROM :new.fechSalida))
  then 
      raise_application_error(-20000,'El avion no habia sido fabricado aun');
  end if;

END AvionNoFabricado;
/


--Segundo trigger: revisa que el aeropuerto al que se produce un desv�o no sea el mismo que el aeropuerto destino
CREATE OR REPLACE TRIGGER DesvioIncorrecto
BEFORE INSERT OR UPDATE ON DESVIOS
FOR EACH ROW 
DECLARE 
  cambio VARCHAR(5);
BEGIN
  SELECT V.AeropuertoD INTO cambio FROM VUELOS V
  WHERE V.idVuelo = :new.Vuelo;
  
  if(cambio = :new.AeropuertoAlt)
  then raise_application_error(-20001, 'Un vuelo no se desv�a al mismo aeropuerto que el destino');
  end if;
    
END DesvioIncorrecto;
/


--Tercer trigger: revisa que al insertar un nuevo vuelo el mismo avi�n salga en vuelos distintos a la misma hora
CREATE OR REPLACE TRIGGER NoVueloRepe
BEFORE INSERT OR UPDATE ON VUELOS
FOR EACH ROW
DECLARE
  vuelos NUMBER(4);
BEGIN
  SELECT count(*) INTO vuelos FROM VUELOS V
  WHERE V.Avion=:new.Avion and (V.fechSalida=:new.fechSalida) or (V.fechLlegada>:new.fechSalida);
  
  if(vuelos > 0) 
  then raise_application_error(-20002, 'Un avi�n con la misma matr�cula no puede despegar a la misma hora');
  end if;
  
END NoVueloRepe;
/