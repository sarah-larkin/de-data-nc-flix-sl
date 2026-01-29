#!/bin/bash

for file in "./sl_db"/*.sql; do
    psql -f "${file}" > ${file%.sql}.txt
  
done