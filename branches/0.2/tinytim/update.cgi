#!/bin/sh

printf "Content-type: text/html\n\n\n";
 
date
echo "<pre>"
svn update
echo "</pre>"
echo "<a href=index.cgi>Continue to site</a>."
