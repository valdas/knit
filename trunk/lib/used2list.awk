/^@uses/ { gsub(/\"/,"") 
		   print "\t+ " $2
           next} 
         {print}  
