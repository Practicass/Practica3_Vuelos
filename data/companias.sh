#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 1,2 | sort | uniq  >companias.csv
