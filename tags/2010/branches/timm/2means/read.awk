BEGIN { OFS=","; IGNORECASE=1 }

			 { gsub(/%.*/,"") }
/^[ \t]*$/   { next }
/@attribute/ { ++Data["cols"];
               if ($0 ~ /{/ )
                  Discretes[Data["cols"]] = 1 }
In           { readRow(Discretes,Data) }
/^@data/     { In=1 }
/^@/         { print; next }

function readRow(discretes,data,  row,i) {
	row = ++data["rows"]
	for(i=1;i<=NF;i++) 
		data[row,i] = $i
}
