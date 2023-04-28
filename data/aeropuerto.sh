#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 52-55 | sort | uniq  >aeropuerto.csv
