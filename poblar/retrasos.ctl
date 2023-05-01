OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/retrasos.csv'
INTO TABLE RETRASOS
FIELDS TERMINATED BY ';'
( 
    IdIncidente,
    Duracion
)