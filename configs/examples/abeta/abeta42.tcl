# Zun-Jing Wang 
# 2012 Jan 

# Abeta42 peptide
# ASP ALA GLU PHE ARG HIS ASP SER GLY TYR GLU VAL HIS\
#     HIS GLN LYS LEU VAL PHE PHE ALA GLU ASP VAL GLY SER\
#     ASN LYS GLY ALA ILE ILE GLY LEU MET VAL GLY GLY VAL\
#     VAL ILE ALA 
# ionizable residues: GLU, APN, LYS, ARG
# 20-39: CB (Side chain beads)
#
############
# WARNING: ionizable residues are parametrized in their charged form.
#   *** END CAPS ADDED ***
###########
#
source configs/peptide2pclipid.tcl

set resilist [list NAP ASP ALA GLU PHE ARG HIS ASP SER GLY TYR GLU VAL HIS HIS GLN LYS LEU VAL PHE PHE ALA GLU ASP VAL GLY SER ASN LYS GLY ALA ILE ILE GLY LEU MET VAL GLY GLY VAL VAL ILE ALA CAP]
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


