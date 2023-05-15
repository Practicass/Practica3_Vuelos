OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/retrasos.csv'
INTO TABLE RETRASOS
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( 
    Vuelo,
    Duracion,
    Causa,
    IdRetraso "retarded.nextval"
)
