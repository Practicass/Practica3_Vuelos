OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/causa.csv'
INTO TABLE CAUSAS
FIELDS TERMINATED BY ';'
( 
    IdIncidente,
    Causa
)