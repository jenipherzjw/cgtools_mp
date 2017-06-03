#!/bin/awk -f

# generate P# SF file from topology file
# Assumes mol type 0 is lipid and mol type 1 is protein
# Assumes there is only one protein

BEGIN{
    i=0
}
{
    if ($1=="{"){
	if ($2==0) {
	    # it's a lipid!
	    c[i   ]= $3; c[i+ 1]=$4
	    c[i+ 2]= $4; c[i+ 3]=$5
	    c[i+ 4]= $5; c[i+ 5]=$6
	    c[i+ 6]= $6; c[i+ 7]=$7
	    c[i+ 8]= $7; c[i+ 9]=$8
	    c[i+10]= $8; c[i+11]=$9
	    c[i+12]= $9; c[i+13]=$10
	    c[i+14]=$10; c[i+15]=$11
	    c[i+16]= $5; c[i+17]=$12
	    c[i+18]=$12; c[i+19]=$13
	    c[i+20]=$13; c[i+21]=$14
	    c[i+22]=$14; c[i+23]=$15
	    c[i+24]=$15; c[i+25]=$16
	    c[i+26]=$16; c[i+27]=$17
	    c[i+28]=$17; c[i+29]=$18
	    i+=30		    
	} else if ($2==1) {
	    # it's a protein
	    for (j=0; j<NF-3;j+=5) {
		c[i  ]=$(j+3); c[i+1]=$(j+4)
		c[i+2]=$(j+4); c[i+3]=$(j+5)
		c[i+4]=$(j+4); c[i+5]=$(j+6)
		c[i+6]=$(j+6); c[i+7]=$(j+7)
		if (j<NF-8) {
		    c[i+8]=$(j+6); c[i+9]=$(j+8)
		    i+=2
		}
		i+=8
	    }		    
	} else {
	    print "Error. Unidentified type."
	    exit
	}
    }
}

END{
    printf "%8d\n",i/2
    counter=1
    for (j=0;j<i;j++0) {
	printf "%8d",c[j]+1
	if (counter%8==0) {
	    printf "\n"
	}
	counter++
    }
    printf "\n"
}
 

