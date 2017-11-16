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
  PERMALINK=$(echo $range | sed 's/[^a-zA-Z0-9]/-/g' |  tr '[:upper:]' '[:lower:]')
  SOURCEIMAGE=https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images/$image
  wget $SOURCEIMAGE -O app/media/images/ranges/$image
  convert app/media/images/ranges/$image -resize "255x170^" -gravity center -crop 255x170+0+0 +repage -quality 80 app/media/generated/thumbs/ranges/$image
  SOURCESPECSHEET=https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/pdfs/$specsheet
  wget $SOURCESPECSHEET -O app/media/specsheets/$specsheet
  echo "---" > $DESTFILE
  echo "layout: range" >> $DESTFILE
  echo "title: $range" >> $DESTFILE
  echo "code: $code" >> $DESTFILE
  echo "permalink: $category/$PERMALINK.html" >> $DESTFILE
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
while read code name desc tagline image image2 image3 range RRP displayRRP Unit displayUnit Sale displaySale Special pricingNote category subcategory
do
  DESTFILE=app/_posts/products/0001-01-01-$code.md
  SOURCEPATH=https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images
  SOURCEIMAGE1=$SOURCEPATH/$image
  SOURCEIMAGE2=$SOURCEPATH/$image2
  SOURCEIMAGE3=$SOURCEPATH/$image3
  PERMALINK=$(echo $name | sed 's/[^a-zA-Z0-9]/-/g' |  tr '[:upper:]' '[:lower:]')
  wget $SOURCEIMAGE1 -O app/media/images/products/$image
  convert app/media/images/products/$image -resize "255x170^" -gravity center -crop 255x170+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
  wget $SOURCEIMAGE2 -O app/media/images/products/$image2
  convert app/media/images/products/$image2 -resize "255x170^" -gravity center -crop 255x170+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image2
  wget $SOURCEIMAGE3 -O app/media/images/products/$image3
  convert app/media/images/products/$image3 -resize "255x170^" -gravity center -crop 255x170+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image3
  echo "---" > $DESTFILE
  echo "layout: product" >> $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "title: $name" >> $DESTFILE
  echo "name: $name" >> $DESTFILE
  echo "permalink : product/$PERMALINK.html" >> $DESTFILE
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
  echo "category: $category" >> $DESTFILE
  echo "subcategory: $subcategory" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS

# Clean up
rm -rf app/_posts/departments/*
INPUT=$RAW/departments-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code department image desc
do
  DESTFILE=app/_posts/departments/0001-01-01-$code.md
  SOURCEPATH=https://s3-eu-west-1.amazonaws.com/raw.cfurniture.ie/www.cfurniture.ie/images
  SOURCEIMAGE1=$SOURCEPATH/$image
  PERMALINK=$(echo $code | sed 's/[^a-zA-Z0-9]/-/g' |  tr '[:upper:]' '[:lower:]')
  wget $SOURCEIMAGE1 -O app/media/images/products/$image
  convert app/media/images/products/$image -resize "255x170^" -gravity center -crop 255x170+0+0 +repage -quality 80 app/media/generated/thumbs/products/$image
  echo "---" > $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "layout: department" >> $DESTFILE
  echo "permalink : $PERMALINK.html" >> $DESTFILE
  echo "category: $code" >> $DESTFILE
  echo "title: $department " >> $DESTFILE
  echo "image: $image" >> $DESTFILE
  echo "description: $desc" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS

# Clean up
rm -rf app/_posts/categories/*
INPUT=$RAW/categories-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code department title desc image
do
  DESTFILE=app/_posts/categories/0001-01-01-$code.md
  PERMALINK=$(echo $code | sed 's/[^a-zA-Z0-9]/-/g' |  tr '[:upper:]' '[:lower:]')
  echo "---" > $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "layout: department" >> $DESTFILE
  echo "permalink : $PERMALINK" >> $DESTFILE
  echo "department: $department" >> $DESTFILE
  echo "title: $title" >> $DESTFILE
  echo "description: $desc" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS

# Clean up
rm -rf app/_posts/subcategories/*
INPUT=$RAW/subcategories-pipes.csv
OLDIFS=$IFS
IFS="|"
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read code category title desc image
do
  DESTFILE=app/_posts/subcategories/0001-01-01-$code.md
  PERMALINK=$(echo $code | sed 's/[^a-zA-Z0-9]/-/g' |  tr '[:upper:]' '[:lower:]')
  echo "---" > $DESTFILE
  echo "code : $code" >> $DESTFILE
  echo "layout: department" >> $DESTFILE
  echo "permalink : $PERMALINK" >> $DESTFILE
  echo "category: $category" >> $DESTFILE
  echo "title: $title" >> $DESTFILE
  echo "description: $desc" >> $DESTFILE
  echo "---" >> $DESTFILE
done < $INPUT
IFS=$OLDIFS
