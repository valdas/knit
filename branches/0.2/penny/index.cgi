#!/bin/sh

echo "Content-Type: text/html"
echo ""

Base="knit.googlecode.com/svn"

rm -rf penny
wget -q http://$Base/tags/penny/0.1/penny
gawk -f penny --source 'BEGIN { penny("'$Base'/branches/0.2/site/etc/config.txt")}'
