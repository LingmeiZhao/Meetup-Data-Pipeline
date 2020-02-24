#!/bin/bash

cat /opt/data/read_data_into_hive.sql /opt/data/export_data_to_analysis.sql | hive

hive -e 'set hive.cli.print.header=true; select * from joinedgroup' | sed 's/[\t]/,/g' > opt/data/joinedGroup.csv
hive -e 'set hive.cli.print.header=true; select * from joinedCategory' | sed 's/[\t]/,/g' > opt/data/joinedCategory.csv
hive -e 'set hive.cli.print.header=true; select * from groupByCity' | sed 's/[\t]/,/g' > opt/data/groupByCity.csv
hive -e 'set hive.cli.print.header=true; select * from groupByCountry' | sed 's/[\t]/,/g' > opt/data/groupByCountry.csv
hive -e 'set hive.cli.print.header=true; select * from cityMap' | sed 's/[\t]/,/g' > opt/data/cityMap.csv
