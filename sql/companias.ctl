OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/companias.csv'
INTO TABLE COMPANIAS
FIELDS TERMINATED BY ';'
( 
    Codigo,
    Nombre
)