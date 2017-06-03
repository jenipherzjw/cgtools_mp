# Zun-Jing Wang 
# 2011 Septembor 

# Magainin-H2 23 peptide
#two magainin analogues with enhanced hydrophobicity: 
#MG-H1 (GIKKFLHIIWKFIKAFVGEIMNS) and MG-H2 (IIKKFLHSIWKFGKAFVGEIMNI)
# NO ionizable residue.
# The atom types in this peptide are respectively 8:N, 9:CA, 10: Pro-N (no H-bond), 11:C, 12:O, 15:term-N, 16:term-C
# 20-39: CB (Side chain beads)
#
############
# WARNING: ionizable residues are parametrized in their charged form.
#   *** END CAPS ADDED ***
###########
#
#
source configs/peptide2popc.tcl

set resilist [list ILE ILE LYS LYS PHE LEU HIS SER ILE TRP LYS PHE GLY LYS ALA PHE VAL GLY GLU ILE MET ASN ILE]
#puts "resilist: $resilist"
set beadlist {}
foreach resname $resilist {
	foreach partinfo_this_resi $partlist_per_res3letter {
	     set this_resi_name [lindex $partinfo_this_resi 0]
	     #puts "this_resi_name: $this_resi_name"
	     #puts "resname: $resname"
	     if { $resname == $this_resi_name } {
		     set beadlist_this_resi [lindex $partinfo_this_resi 1]
		     foreach thispartnum $beadlist_this_resi {
			lappend beadlist $thispartnum
	    	     }
	     }
	}
}
#puts "beadlist: $beadlist"
unset partlist_per_res3letter
# Don't specify topology here
set bondlist [list ]
set angllist [list ]
set dihelist [list ]
lappend respartlist $beadlist
lappend respartlist $bondlist
lappend respartlist $angllist
lappend respartlist $dihelist
lappend respartlist $resilist
unset beadlist
unset bondlist
unset angllist
unset dihelist
unset resilist 

#moltypeid
lappend molpeptidepartlist "1" 
#molspec
lappend molpeptidepartlist "PROT" 
#
lappend molpeptidepartlist $respartlist 
lappend molpeptidepartlist $resparttypelist 
lappend molpeptidepartlist $respartcharmmbeadlist 
#puts "molpeptidepartlist: $molpeptidepartlist"
#exit
unset respartlist
unset resparttypelist
unset respartcharmmbeadlist
::mmsg::send [namespace current] "molpeptidepartlist set"


