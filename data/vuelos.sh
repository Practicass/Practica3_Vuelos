#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 3,4,5,6,10,52,59| sort | uniq  >vuelos.csv
