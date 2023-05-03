

Select C.Nombre, ((Select count(*)
        FROM VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente)*100)/(Select count(*)
                                                                                                                            FROM VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                                                                            WHERE V.avion = A.matricula and A.compania = C.codigo) AS ratioretr
FROM COMPANIAS C
ORDER BY ratioretr




Select C.Nombre, (Select count(*)
                    FROM VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                    WHERE V.avion = A.matricula and A.compania = C.codigo) AS ratioretr
FROM COMPANIAS C
ORDER BY ratioretr



(Select C2.Nombre, count(*)
FROM COMPANIAS C2, VUELOS V2, AVIONES A2
WHERE V2.avion = A2.matricula and A2.compania = C2.codigo and C2.Nombre IN(Select C.Nombre
                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                        GROUP BY C.Nombre)
GROUP BY C2.Nombre
ORDER BY count(*))*100/(Select C.Nombre
                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                        GROUP BY C.Nombre)


Select C.Nombre
                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                        GROUP BY C.Nombre







(Select C2.Nombre, count(*)
FROM COMPANIAS C2, VUELOS V2, AVIONES A2
WHERE V2.avion = A2.matricula and A2.compania = C2.codigo and C2.Nombre IN(Select C.Nombre
                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                        GROUP BY C.Nombre)
GROUP BY C2.Nombre)
(Select C.Nombre, count(*)
                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                        GROUP BY C.Nombre)

--Fin 1:
Select C3.Nombre, retrasos*100/total as ratio
FROM (Select C2.Nombre as nombreT, count(*) as total
        FROM COMPANIAS C2, VUELOS V2, AVIONES A2
        WHERE V2.avion = A2.matricula and A2.compania = C2.codigo and C2.Nombre IN(Select C.Nombre
                                                                                FROM COMPANIAS C, VUELOS V, AVIONES A, RETRASOS R
                                                                                WHERE V.avion = A.matricula and A.compania = C.codigo and R.vuelo = V.IdVuelo
                                                                                GROUP BY C.Nombre)
        GROUP BY C2.Nombre) X, (Select C.Nombre as nombreR, count(*) as retrasos
                                                                                FROM COMPANIAS C, VUELOS V, AVIONES A,  RETRASOS R
                                                                                WHERE V.avion = A.matricula and A.compania = C.codigo and R.vuelo = V.IdVuelo 
                                                                                GROUP BY C.Nombre) Z, COMPANIAS C3
WHERE C3.Nombre = nombreR and C3.Nombre = nombreT
ORDER BY ratio DESC




Select M2.Modelo
FROM MODELO M2
WHERE (Select count(*)*100
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M2.modelo and V.IdVuelo=R.Vuelo and R.causa='seguridad'
        )>(Select count(*)
                               FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
                               WHERE V.Avion=A2.matricula and A2.modelo=M2.modelo and V.IdVuelo=R.vuelo
                               )








--Fin 2:
Select M2.Modelo, M2.fabricante, M2.motor
FROM MODELO M2
WHERE   (Select count(*)*100
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and M.modelo=M2.modelo and V.IdVuelo=R.Vuelo and R.causa='seguridad'
        GROUP BY M.MODELO)>
        (Select count(*)
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and M.modelo=M2.modelo and V.IdVuelo=R.Vuelo 
        GROUP BY M.MODELO)



Select M.modelo, M.fabricante, M.motor, count(*)
        FROM VUELOS V, AVIONES A2, MODELO M, INCIDENTES I, RETRASOS R, CAUSAS CA
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and V.IdVuelo=I.Vuelo and I.IdIncidente=R.IdIncidente and R.IdIncidente=CA.IdIncidente and CA.Causa='seguridad'
GROUP BY M.modelo, M.fabricante, M.motor

ALTER SESSION SET nls_date_format = 'dd-mm-yyyy hh24:mi:ss';

Select A.IATA,V.FechSalida, count(*)
FROM VUELOS V, VUELOS V2, AEROPUERTOS A
WHERE V.AeropuertoO = A.IATA and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 > V2.FechSalida and V.FechSalida - 15/1440 < V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 > V2.FechLlegada and V.FechSalida - 15/1440< V2.FechLlegada))
GROUP BY V.IdVuelo, A.IATA, V.FechSalida


ALTER SESSION SET nls_date_format = 'dd-mm-yyyy hh24:mi:ss';
Select V.FechLlegada, V.FechLlegada + 15/1440
FROM VUELOS V
WHERE V.IdVuelo<10





2641
4856

--Fin 3:
Select aeropuerto, max(num)
from    (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
        WHERE V.AeropuertoO = A.IATA and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 > V2.FechSalida and V.FechSalida - 15/1440 < V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 > V2.FechLlegada and V.FechSalida - 15/1440< V2.FechLlegada))
        GROUP BY V.IdVuelo, A.IATA, V.FechSalida)
GROUP BY aeropuerto

