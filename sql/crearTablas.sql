SET ECHO ON;

CREATE TABLE COMPANIAS (
    Codigo VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE MODELO (
    Modelo VARCHAR(30) PRIMARY KEY,
    Fabricante VARCHAR(30) NOT NULL,
    Motor VARCHAR(20) NOT NULL 
);

CREATE TABLE AEROPUERTOS (
    IATA VARCHAR(5) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(30),
    Estado VARCHAR(30) NOT NULL
);

CREATE TABLE AVIONES (
    Matricula VARCHAR(10) PRIMARY KEY,
    Compania VARCHAR(10) NOT NULL,
    Modelo VARCHAR(30),
    AgnoFabricacion NUMBER(4),
    FOREIGN KEY(Modelo) REFERENCES MODELO(Modelo) ON DELETE CASCADE,
    FOREIGN KEY(Compania) REFERENCES COMPANIAS(Codigo) ON DELETE CASCADE
);

CREATE TABLE VUELOS (
    IdVuelo NUMBER(6) PRIMARY KEY,
    Numero NUMBER(6) NOT NULL,
    Avion VARCHAR(10),
    AeropuertoO VARCHAR(5) NOT NULL,
    AeropuertoD VARCHAR(5), --Hacer check para que sean distintos 
    FechSalida DATE NOT NULL,
    FechLlegada DATE, --Hacer check de que sea fecha de llegada mayor que la de salida
    FOREIGN KEY(Avion) REFERENCES AVIONES(Matricula) ON DELETE CASCADE,
    FOREIGN KEY(AeropuertoO) REFERENCES AEROPUERTOS(IATA) ON DELETE CASCADE,
    FOREIGN KEY(AeropuertoD) REFERENCES AEROPUERTOS(IATA) ON DELETE CASCADE,
    CHECK (FechSalida < FechLLegada),
    CHECK (AeropuertoO <> AeropuertoD)
);


CREATE TABLE DESVIOS (
    IdDesvio NUMBER(6) PRIMARY KEY,
    Vuelo NUMBER(6) NOT NULL,
    AeropuertoAlt VARCHAR(5) NOT NULL,
    FOREIGN KEY(Vuelo) REFERENCES VUELOS(IdVuelo) ON DELETE CASCADE,
    FOREIGN KEY(AeropuertoAlt) REFERENCES AEROPUERTOS(IATA) ON DELETE CASCADE
);

CREATE TABLE RETRASOS (
    IdRetraso NUMBER(6) PRIMARY KEY,
    Vuelo NUMBER(6) NOT NULL,
    Causa VARCHAR(50),
    Duracion NUMBER(4),
    FOREIGN KEY(Vuelo) REFERENCES VUELOS(IdVuelo) ON DELETE CASCADE
);




CREATE TABLE CANCELACIONES (
    Vuelo NUMBER(6) NOT NULL  PRIMARY KEY,
    FOREIGN KEY(Vuelo) REFERENCES VUELOS(IdVuelo) ON DELETE CASCADE
);



--Secuencias

CREATE SEQUENCE retarded START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE desv START WITH 1 INCREMENT BY 1;
