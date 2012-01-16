javac ${PROJNAME}.java
cat tests/$1.in | java -classpath . ${PROJNAME}


