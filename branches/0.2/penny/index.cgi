#!/bin/sh

echo "Content-Type: text/html"
echo ""

Base="knit.googlecode.com/svn"

wget -O penny.awk "http://$Base/tags/penny/0.1/penny.awk"
gawk -f penny.awk --source 'BEGIN { penny("'$Base'"branches/0.2/penny/etc/config.txt"}'
