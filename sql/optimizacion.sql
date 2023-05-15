CREATE MATERIALIZED VIEW retardos_seg AS
Select count(*)*100 as ret_seg, M.Modelo as mod
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo
        and V.IdVuelo=R.Vuelo and R.causa='seguridad'
        GROUP BY M.MODELO;

        
CREATE MATERIALIZED VIEW retardos AS
Select count(*) as ret, M.Modelo
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and V.IdVuelo=R.Vuelo 
        GROUP BY M.MODELO;


Select M2.Modelo, M2.Fabricante, M2.Motor
FROM MODELO M2, retardos RE, retardos_seg R
WHERE   ret_seg > ret and M2.Modelo = R.Mod and RE.Modelo=R.Mod;

CREATE INDEX vuelos_idx ON (idVuelo, Avion);

CREATE INDEX aviones_idx ON (Matricula, Compania);
DROP INDEX vuelos_idx ;
DROP INDEX aviones_idx ;

-----3
WITH
        X as (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
                        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                        WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                        GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                        ORDER BY num),
        Z as (Select max(num) AS maximo
        FROM  X)
Select X.aeropuerto, TO_CHAR(X.fecha, 'YYYY-MM-DD hh:mi:ss') as fechafin, X.num
FROM     Z,  X
WHERE X.num=maximo
GROUP BY X.aeropuerto, X.fecha, X.num


CREATE INDEX vuelos_idx2 ON VUELOS(FechSalida,FechLlegada,idVuelo,AeropuertoD,AeropuertoO);
DROP INDEX vuelos_idx2 ;


CREATE MATERIALIZED VIEW actividad AS
Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num, A.nombre as nom
FROM VUELOS V, VUELOS V2, AEROPUERTOS A
WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
GROUP BY V.IdVuelo, A.IATA, V.FechSalida, A.nombre;




Select actividad.nom, actividad.aeropuerto, TO_CHAR(actividad.fecha, 'YYYY-MM-DD hh:mi:ss') as fechafin, actividad.num
FROM     actividad
WHERE actividad.num=(Select max(actividad.num) AS maximo
        FROM  actividad)
GROUP BY actividad.nom, actividad.aeropuerto, actividad.fecha, actividad.num;
                       