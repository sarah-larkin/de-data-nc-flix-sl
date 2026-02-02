#!/bin/bash

for file in "./sl_db"/*.sql; do
    psql -f "${file}" > ${file%.sql}.txt
  
done


#to run: 
#chmod +x ./sl_run-all.sh
# ./sl_run-all.sh
