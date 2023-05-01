OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/desvios.csv'
INTO TABLE DESVIOS
FIELDS TERMINATED BY ';'
( 
    IdIncidente,
    AeropuertoAlt
)