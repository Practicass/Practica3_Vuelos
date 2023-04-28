#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 37,38,40 | sort | uniq  >modelos.csv
