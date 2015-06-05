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
  SOURCEIMAGE=https://dl.dropboxusercontent.com/u/8703195/www.cfurniture.ie/media/images/ranges/$image
  echo "image : $image" 
  echo "sourceimage:  $SOURCEIMAGE"
  wget $SOURCEIMAGE -O app/media/images/ranges/$image
  echo "---" > $DESTFILE
  echo "layout: range" >> $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "permalink : range/$category/$code.html" >> $DESTFILE
  echo "range : $range" >> $DESTFILE
  echo "desc : $desc" >> $DESTFILE
  echo "image : $image" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS

# Clean up
rm -rf app/_posts/products/*
INPUT=$RAW/products-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code name desc tagline image image2 image3 range RRP displayRRP Unit displayUnit Sale displaySale Special
do
  DESTFILE=app/_posts/products/0001-01-01-$code.md
  echo "---" > $DESTFILE
  echo "layout: range" >> $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "name: $range" >> $DESTFILE
  echo "permalink : product/$code.html" >> $DESTFILE
  echo "desc : $desc" >> $DESTFILE
  echo "tagline: $tagline" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS
