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