#!/bin/awk -f

# ADDS ONLY ONE PEPTIDE

# pass var from command line
## PDB format
##ATOM   1153 N    NAP     1      25.918  42.425  61.041  1.00  0.00       P1

## CRD format
##   1    1  GLY N     50.21000  61.99100 109.66100 P1   1      0.00000

##./add_peptide.awk walp23.init.spanning.pdb 25 25 115 1 1 > walp23_s1.spanning.crd
##ARGV[1]: PDB input file name
##ARGV[2]: dx 
##ARGV[3]: dy 
##ARGV[4]: dz 
##ARGV[5]: number_index of first particle 
##ARGV[6]: number_index of molecule 

BEGIN{
    if (ARGC != 7) {
	print "Error: need arguments:"
	print "-x translation"
	print "-y translation"
	print "-z translation"
	print "first ID of new particle"
	print "ID of peptide"
	exit
    }
    part=ARGV[5]
}
{
    if ($1=="ATOM") {
	printf "%5d%5d %4s %-4s%10.5f%10.5f%10.5f P%-3d %-3d%11.5f\n",part,$5,$4,$3,$6+ARGV[2],$7+ARGV[3],$8+ARGV[4],ARGV[6],ARGV[6],0.00;
	part++
    }
}
END{
    exit
}
