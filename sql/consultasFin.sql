--1:
Select P.Nombre, P.ratio
FROM (Select C3.Nombre as Nombre, retrasos*100/total as ratio
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
        ORDER BY ratio DESC) P, (Select C3.Nombre as Nombre, retrasos*100/total as ratio
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
        ORDER BY ratio DESC) P2
WHERE P.ratio <= P2.ratio
GROUP BY P.Nombre, P.ratio
HAVING count(*) <= 3
ORDER BY P.ratio DESC


WITH
        X as (Select C2.Nombre as nombreT, count(*) as total
                FROM COMPANIAS C2, VUELOS V2, AVIONES A2
                WHERE V2.avion = A2.matricula and A2.compania = C2.codigo and C2.Nombre IN(Select C.Nombre
                                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A, RETRASOS R
                                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and R.vuelo = V.IdVuelo
                                                                                        GROUP BY C.Nombre)
                GROUP BY C2.Nombre) , 
        Z as (Select C.Nombre as nombreR, count(*) as retrasos
                                                                                        FROM COMPANIAS C, VUELOS V, AVIONES A,  RETRASOS R
                                                                                        WHERE V.avion = A.matricula and A.compania = C.codigo and R.vuelo = V.IdVuelo 
                                                                                        GROUP BY C.Nombre),
        P as (Select C3.Nombre as Nombre, retrasos*100/total as ratio
                FROM  X,  Z, COMPANIAS C3
                WHERE C3.Nombre = nombreR and C3.Nombre = nombreT
                ORDER BY ratio DESC),
        P2 as (Select C3.Nombre as Nombre, retrasos*100/total as ratio
                FROM X, Z, COMPANIAS C3
                WHERE C3.Nombre = nombreR and C3.Nombre = nombreT
                ORDER BY ratio DESC) 
Select P.Nombre, P.ratio
FROM  P, P2
WHERE P.ratio <= P2.ratio
GROUP BY P.Nombre, P.ratio
HAVING count(*) <= 3
ORDER BY P.ratio DESC


--2:
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

--3:
Select DISTINCT aeropuerto2, max, fecha
FROM    (Select  aeropuerto as aeropuerto2, max(num) as max
        from    (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
                FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                WHERE V.AeropuertoO = A.IATA and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                GROUP BY V.IdVuelo, A.IATA, V.FechSalida)
        GROUP BY aeropuerto) X, (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
                FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                GROUP BY V.IdVuelo, A.IATA, V.FechSalida) Z
WHERE Z.aeropuerto=X.aeropuerto2 and Z.num=X.max




Select max
Select A.IATA as aeropuerto,V.FechSalida as fecha, TO_CHAR(V.FechSalida, 'HH24:MI') as hora, count(*) as num
                FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                ORDER BY num


Select X.aeropuerto, X.hora, X.num
FROM    (Select max(num) AS maximo
        FROM (Select A.IATA as aeropuerto,V.FechSalida as fecha, TO_CHAR(V.FechSalida, 'YYYY-MM-DD hh:mm:ss') as hora, count(*) as num
                        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                        WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                        GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                        ORDER BY num) X) Z, (Select A.IATA as aeropuerto,V.FechSalida as fecha, TO_CHAR(V.FechSalida, 'HH24:MI') as hora, count(*) as num
                        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                        WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                        GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                        ORDER BY num) X
WHERE X.num=maximo


Select X.aeropuerto, X.fecha as fechafin, X.num
FROM    (Select max(num) AS maximo
        FROM (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
                        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                        WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                        GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                        ORDER BY num) X) Z, (Select A.IATA as aeropuerto,V.FechSalida as fecha, count(*) as num
                        FROM VUELOS V, VUELOS V2, AEROPUERTOS A
                        WHERE V.AeropuertoO = A.IATA  and ((V2.AeropuertoO = A.IATA and V.FechSalida + 15/1440 >= V2.FechSalida and V.FechSalida - 15/1440 <= V2.FechSalida) or (V2.AeropuertoD = A.IATA and V.FechSalida + 15/1440 >= V2.FechLlegada and V.FechSalida - 15/1440<= V2.FechLlegada))
                        GROUP BY V.IdVuelo, A.IATA, V.FechSalida
                        ORDER BY num) X
WHERE X.num=maximo
GROUP BY X.aeropuerto, X.fecha, X.num