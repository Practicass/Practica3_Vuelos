

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
Select C3.Nombre, retrasos*100/total
FROM (Select C2.Nombre as nombreT, count(*) as total
        FROM COMPANIAS C2, VUELOS V2, AVIONES A2
        WHERE V2.avion = A2.matricula and A2.compania = C2.codigo and C2.Nombre IN(Select C.Nombre
                                                                                FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                                WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                                GROUP BY C.Nombre)
        GROUP BY C2.Nombre) X, (Select C.Nombre as nombreR, count(*) as retrasos
                                                                                FROM COMPANIAS C, VUELOS V, AVIONES A, INCIDENTES I, RETRASOS R
                                                                                WHERE V.avion = A.matricula and A.compania = C.codigo and I.vuelo = V.IdVuelo and I.IdIncidente = R.IdIncidente
                                                                                GROUP BY C.Nombre) Z, COMPANIAS C3
WHERE C3.Nombre = nombreR and C3.Nombre = nombreT



Select M2.fabricante
FROM MODELO M2
WHERE (Select count(*)*100
        FROM VUELOS V, AVIONES A2, MODELO M, INCIDENTES I, RETRASOS R, CAUSAS CA
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and M.fabricante=M2.fabricante and V.IdVuelo=I.Vuelo and I.IdIncidente=R.IdIncidente and R.IdIncidente=CA.IdIncidente and CA.Causa='seguridad'
        GROUP BY M.fabricante)>(Select count(*)
                                                                                                                                                        FROM VUELOS V, AVIONES A2, MODELO M, INCIDENTES I, RETRASOS R
                                                                                                                                                        WHERE V.Avion=A2.matricula and A2.modelo=M.modelo and M.fabricante=M2.fabricante and V.IdVuelo=I.vuelo and I.IdIncidente=R.IdIncidente
                                                                                                                                                        GROUP BY M.fabricante)













Select M.fabricante, count(*)
        FROM VUELOS V, AVIONES A2, MODELO M, INCIDENTES I, RETRASOS R, CAUSAS CA
        WHERE V.Avion= A2.matricula and A2.modelo=M.modelo and V.IdVuelo=I.Vuelo and I.IdIncidente=R.IdIncidente and R.IdIncidente=CA.IdIncidente and CA.Causa='seguridad'