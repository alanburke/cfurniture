#!/usr/bin/env bash
# Clean up
RAW=scripts/raw
rm $RAW/*.xls
rm $RAW/*.csv*

# Get the Raw data in xls format
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/sources/details.xls -O $RAW/details.xls

# Get Homepage image
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/home.jpg -O app/media/images/categories/home.jpg

# Get Flooring and Matress images
image='flooring.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/flooring.jpg -O app/media/images/products/flooring.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
image='flooring1.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/flooring1.jpg -O app/media/images/products/flooring1.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
image='flooring2.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/flooring2.jpg -O app/media/images/products/flooring2.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
image='matts.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/matts.jpg -O app/media/images/products/matts.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
image='matts1.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/matts1.jpg -O app/media/images/products/matts1.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
image='matts2.jpg'
wget https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/matts2.jpg -O app/media/images/products/matts2.jpg
convert app/media/images/products/$image -resize "495x330^" -gravity center -crop 495x330+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image


in2csv --sheet ranges $RAW/details.xls > $RAW/ranges-commas.csv
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

# Departments
in2csv --sheet departments $RAW/details.xls  > $RAW/departments-commas.csv
# Replace pipes with br tags
sed -ie 's/|/<br \/>/g' $RAW/departments-commas.csv
# Send to data folder
cp $RAW/departments-commas.csv app/_data/departments.csv
# Convert to pipe seperated csv minus first row
csvformat -D '|' $RAW/departments-commas.csv | tail -n +2 > $RAW/departments-pipes.csv

# Categories
in2csv --sheet categories $RAW/details.xls  > $RAW/categories-commas.csv
# Replace pipes with br tags
sed -ie 's/|/<br \/>/g' $RAW/categories-commas.csv
# Send to data folder
cp $RAW/categories-commas.csv app/_data/categories.csv
# Convert to pipe seperated csv minus first row
csvformat -D '|' $RAW/categories-commas.csv | tail -n +2 > $RAW/categories-pipes.csv

# subcategories
in2csv --sheet subcategories $RAW/details.xls  > $RAW/subcategories-commas.csv
# Replace pipes with br tags
sed -ie 's/|/<br \/>/g' $RAW/subcategories-commas.csv
# Send to data folder
cp $RAW/subcategories-commas.csv app/_data/subcategories.csv
# Convert to pipe seperated csv minus first row
csvformat -D '|' $RAW/subcategories-commas.csv | tail -n +2 > $RAW/subcategories-pipes.csv
