#!/usr/bin/env bash
# Clean up
RAW=scripts/raw
rm $RAW/*.xls
rm $RAW/*.csv*

# Get the Raw data in xls format
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/sources/details.xls -O $RAW/details.xls

# Get Homepage image
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/home.jpg -O app/media/images/categories/home.jpg

# Get Flooring and Matress images
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/flooring.jpg -O app/media/images/products/flooring.jpg
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/flooring1.jpg -O app/media/images/products/flooring1.jpg
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/flooring2.jpg -O app/media/images/products/flooring2.jpg
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/matts.jpg -O app/media/images/products/matts.jpg
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/matts1.jpg -O app/media/images/products/matts1.jpg
wget https://dl.dropboxusercontent.com/u/$DROPBOX_UID/www.cfurniture.ie/images/matts2.jpg -O app/media/images/products/matts2.jpg


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
