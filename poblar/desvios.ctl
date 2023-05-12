OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/desvios.csv'
INTO TABLE DESVIOS
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( 
    Vuelo,
    AeropuertoAlt
    IdDesvio "desvios.nextval"
)