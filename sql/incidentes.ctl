OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/incidentes.csv'
INTO TABLE INCIDENTES
FIELDS TERMINATED BY ';'
( 
    Vuelo,
    IdIncidente
)