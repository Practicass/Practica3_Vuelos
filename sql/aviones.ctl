OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/aviones.csv'
INTO TABLE AVIONES
FIELDS TERMINATED BY ';'
( 
    Compania,
    Matricula,
    Modelo,
    AgnoFabricacion
)