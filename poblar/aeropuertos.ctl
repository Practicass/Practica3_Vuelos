OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/aeropuerto.csv'
INTO TABLE AEROPUERTOS
FIELDS TERMINATED BY ';'
( 
    IATA,
    Nombre,
    Ciudad,
    Estado
)