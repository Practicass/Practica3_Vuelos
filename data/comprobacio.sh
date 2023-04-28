#!/bin/bash
cat DatosVuelo.csv | cut -d ';' -f 38-40 | cut -d '"' -f 1 | sort | uniq  >comprobacion.csv
