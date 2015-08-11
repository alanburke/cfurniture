#!/usr/bin/env bash
# Clean up
RAW=scripts/raw
rm $RAW/*.xls
rm $RAW/*.csv*

# Get the Raw data in xls format
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/sources/details.xls -O $RAW/details.xls

in2csv $RAW/details.xls > $RAW/ranges-commas.csv
# Replace pipes with br tags
sed -ie 's/|/<br \/>/g' $RAW/ranges-commas.csv 
# Send to data folder
cp $RAW/ranges-commas.csv app/_data/ranges.csv
# Convert to pipe seperated csv minus first row
csvformat -D '|' $RAW/ranges-commas.csv | tail -n +2 > $RAW/ranges-pipes.csv

# Products 
in2csv --sheet products $RAW/details.xls  > $RAW/products-commas.csv
# Replace pipes with br tags
sed -ie 's/|/<br \/>/g' $RAW/products-commas.csv 
# Send to data folder
cp $RAW/products-commas.csv app/_data/products.csv
# Convert to pipe seperated csv minus first row
csvformat -D '|' $RAW/products-commas.csv | tail -n +2 > $RAW/products-pipes.csv
