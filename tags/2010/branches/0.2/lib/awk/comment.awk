# Comment.Awk 

# Comment out non-code sections of an awk file.

## Synopsis 
## ========

#     # gawk -f comment.awk Comment="#" code.awk > commentedCode.awk

## Problem 
## =======

## Writing multi-line comments in Awk is a pain. Consider this file,
## for example- each line of comment must start with a "#" character.
## If a paragraph is reformated then all those front-of-line chars
## get scrambled. 

## Another problem is that plain text is just plain dull. There
## are much better ways tp lay out code and comments using, say,
## HTML technology.

## Solution
## ========

## Comment.awk is an automatic tool that works out  what is code,
## and what is comment, and adds the comments chars accordingly.
## It  assumes that paragraphs containing code begin with one
## white space character (a tab or a space) and that all other lines
## must be commented on.

## Comment.awk also knows about verbatim explanatory text. This
## is paragraphs tat begin with more than one white space 
## character (and these are commented on as well).

## As to HTML formatting,  the markdown.awk script converts
## documents in the comment.awk format to .html files.

## Code 
## ====

## The default comment character is the hash symbol

BEGIN { Comment="#" }

## Blank lines are dumped as comments if the proceeding lines are also .
## commented Non-blank lines are accumulated, till the next call to "dump".
## At end of file, there is one last call to "dump" to clear any 
## remaining text.

/^[ \t]*$/ { dump(); next; }
           { text = (text ? text "\n" : "" ) $0 }
END        { dump() }

## The "dump" Function 
## -------------------

## The "dump" function  prints, then clears any accumulated text. 
## If such text exists, then if it starts with only one what space 
## char, then it is printed verbatim. Else, before printing, it replaces 
## front of line with the Comment character.

function dump() {
  if (text) {
    if (text ~ /^[ \t][^ \t]/)
      print text "\n";
    else {
      gsub(/\n/,"\n" Comment,text);
      print Comment text "\n" } }
  text = "";
}  

## Author
## ------

## Tim Menzies, who hopes never to type "#" ever again.
