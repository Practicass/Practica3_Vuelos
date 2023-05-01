OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/modelos.csv'
INTO TABLE MODELO
FIELDS TERMINATED BY ';'
( 
    Fabricante,
    Modelo,
    Motor
)