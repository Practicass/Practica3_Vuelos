OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/vuelos.csv'
INTO TABLE VUELOS
FIELDS TERMINATED BY ';'
( 
   idVuelo,
   Avion,
   Numero,
   AeropuertoO,
   AeropuertoD,
   FechSalida TIMESTAMP 'DD/MM/YY HH24:MI',
   FechLlegada TIMESTAMP 'DD/MM/YY HH24:MI'
)