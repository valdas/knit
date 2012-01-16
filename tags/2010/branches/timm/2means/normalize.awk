BEGIN { Shuffle=1; OFS=","; IGNORECASE=1 }
END   { srand(Seed ? Seed : 1)
		normalize(Data,Discretes)
		printRows(Data)
}

			 { gsub(/%.*/,"") }
/^[ \t]*$/   { next }
/@attribute/ { ++Data["cols"];
               if ($0 ~ /{/ )
                  Discretes[Data["cols"]] = 1 }
In           { readRow(Discretes,Data) }
/^@data/     { In=1; inits(Data) }
/^@/         { print; next }

function inits(data,   col,cols,i) {
	cols=data["cols"]
	for(col=1;col<=cols;col++) {
		data["max",col] = 10^32 * -1
		data["min",col] = 10^32 }
}
function readRow(discretes,data,  row,i) {
	row = ++data["rows"]
	for(i=1;i<=NF;i++) 
		readCell(row, i,$i,discretes,data)
}
function readCell(row,col,value,discretes,data) {
	data[row,col]=value
	if ( ! (col in discretes) ) {
		data["max",col] = max(data["max",col],value)
		data["min",col] = min(data["min",col],value) }
}

##################################################################
# worker

function normalize(data,discretes,  rows,row,cols,col) {
	rows = data["rows"]
	cols = data["cols"]
	for(row=1;row<=rows;row++)
		for(col=1;col<=cols;col++) 
			if(! (col in discretes))
				data[row,col] = normalize1(data,row,col)
}	
function normalize1(data,row,col,    min,max) {
	min = data["min",col]
	max = data["max",col]
	return min == max ? 1 : (data[row,col] - min) / (max - min)
}
function printRows(data,   row,rows,order) {
	rows=data["rows"]
	for(row=1; row<=rows; row++)
		order[row]=row
	if(Shuffle) 
		shuffle(order,rows)
	for(row =1; row<=rows; row++)
		printRow(order[row],data)
}
function printRow(row,data,   str,col,cols) {
	cols=data["cols"]
	str=data[row,1]
	for(col=2; col<=cols; col++)
		str= str OFS data[row,col]
	print str
}
