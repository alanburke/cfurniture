#!/bin/bash
# Clean up
rm -rf app/_posts/ranges/*
RAW=scripts/raw

INPUT=$RAW/ranges-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code range desc options tagline image category specsheet
do
  DESTFILE=app/_posts/ranges/0001-01-01-$code.md
  SOURCEIMAGE=https://dl.dropboxusercontent.com/u/8703195/www.cfurniture.ie/media/images/$image
  wget $SOURCEIMAGE -O app/media/images/ranges/$image
  SOURCESPECSHEET=https://dl.dropboxusercontent.com/u/8703195/www.cfurniture.ie/media/pdfs/$specsheet
  wget $SOURCESPECSHEET -O app/media/specsheets/$specsheet
  echo "---" > $DESTFILE
  echo "layout: range" >> $DESTFILE
  echo "title: $range" >> $DESTFILE
  echo "code: $code" >> $DESTFILE
  echo "permalink: $category/$code.html" >> $DESTFILE
  echo "range: $range" >> $DESTFILE
  echo "desc: $desc" >> $DESTFILE
  echo "options: $options" >> $DESTFILE
  echo "tagline: $tagline" >> $DESTFILE
  echo "image: $image" >> $DESTFILE
  echo "category: $category" >> $DESTFILE
  echo "specsheet: $specsheet" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS

# Clean up
rm -rf app/_posts/products/*
INPUT=$RAW/products-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code name desc tagline image image2 image3 range RRP displayRRP Unit displayUnit Sale displaySale Special pricingNote
do
  DESTFILE=app/_posts/products/0001-01-01-$code.md
  SOURCEPATH=https://dl.dropboxusercontent.com/u/8703195/www.cfurniture.ie/media/images/products
  SOURCEIMAGE1=$SOURCEPATH/$image
  SOURCEIMAGE2=$SOURCEPATH/$image2
  SOURCEIMAGE3=$SOURCEPATH/$image3
  wget $SOURCEIMAGE1 -O app/media/images/ranges/$image
  wget $SOURCEIMAGE2 -O app/media/images/ranges/$image2
  wget $SOURCEIMAGE3 -O app/media/images/ranges/$image3
  echo "---" > $DESTFILE
  echo "layout: product" >> $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "name: $name" >> $DESTFILE
  echo "permalink : product/$code.html" >> $DESTFILE
  echo "desc : $desc" >> $DESTFILE
  echo "tagline: $tagline" >> $DESTFILE
  echo "image: $image" >> $DESTFILE
  echo "image2: $image2" >> $DESTFILE
  echo "image3: $image3" >> $DESTFILE
  echo "range: $range" >> $DESTFILE
  echo "RRP: $RRP" >> $DESTFILE
  echo "displayRRP: $displayRRP" >> $DESTFILE
  echo "Unit: $Unit" >> $DESTFILE
  echo "displayUnit: $displayUnit" >> $DESTFILE
  echo "Sale: $Sale" >> $DESTFILE
  echo "displaySale: $displaySale" >> $DESTFILE
  echo "Special: $Special" >> $DESTFILE
  echo "pricingNote: $pricingNote" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS
