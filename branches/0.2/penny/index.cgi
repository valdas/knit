#!/bin/sh

echo "Content-Type: text/html"
echo ""

Base="http://knit.googlecode.com/svn"

wget -O penny.awk $Base/tags/penny/0.1/penny.awk
gawk -f penny.awk
