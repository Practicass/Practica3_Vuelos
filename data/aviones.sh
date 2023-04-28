#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 1,4,38,41 | sort | uniq  >aviones.csv
