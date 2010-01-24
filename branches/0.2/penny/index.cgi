#!/bin/sh
printf "Content-Type: text/html\n\n"
rm -f penny.awk
wget -qO penny.awk http://knit.googlecode.com/svn/tags/penny/0.1/penny
gawk -f penny.awk -v Seed="$RANDOM" --source 'BEGIN { 
    penny("knit.googlecode.com/svn/branches/0.2/site/etc/config.txt")
    }'
