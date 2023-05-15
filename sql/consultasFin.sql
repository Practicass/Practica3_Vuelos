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

WITH 
        X as(Select M.modelo as model, count(*)*100 as num
                FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
                WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and V.IdVuelo=R.Vuelo and R.causa='seguridad'
                GROUP BY M.MODELO),
        Z as (Select M.modelo as model, count(*) as num
        FROM VUELOS V, AVIONES A2, MODELO M, RETRASOS R
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and V.IdVuelo=R.Vuelo 
        GROUP BY M.MODELO)
Select M2.Modelo, M2.fabricante, M2.motor
FROM MODELO M2, X, Z
WHERE   X.model = M2.modelo and Z.model = M2.modelo and X.num>Z.num

--3:

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