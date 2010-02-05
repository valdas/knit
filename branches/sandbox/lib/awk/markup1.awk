BEGIN               { RS=""; FS="\n";P=1; OFS="\n"; Aka[2]="ul"}
                    { P++;

		    $(NF+1) = "!!!!!!!"
		    $(NF+2) = P;
		    $NF +=2;
		    print $0
		      }
