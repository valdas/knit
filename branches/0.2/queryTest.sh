QUERY_STRING="steffen" ./hello.cgi # doc/who/steffen.html
QUERY_STRING="steffen2222" ./hello.cgi # returns the default file
QUERY_STRING="Admin" ./hello.cgi # lots of stuff returned
QUERY_STRING="title=I+love+this+bar" ./hello.cgi # lots of stuff returned
QUERY_STRING="doc/who/steffen.html" ./hello.cgi # lots of stuff returned

