OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/cancelaciones.csv'
INTO TABLE CANCELACIONES
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( 
    Vuelo
    IdCancelacion "retrasos.nextval"
)