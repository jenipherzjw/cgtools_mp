# Author: Zun-Jing Wang
# 2011 Dec
# 72 POPC bilayer with walp23 peptide.
#
::mmsg::send [namespace current] "loading parameter file .. " nonewline
flush stdout

# lipid input file
set numberoflipid 1 
set lipidfile "popc"
append lipidfile $numberoflipid
append lipidfile ".init.crd"

# peptide input file
#set numberofpeptide 4 
#set peptidefile  "walp23_4.init.crd"
set numberofpeptide 1 
set peptidefile  "walp23_1.init.crd"
#set peptidefile  "walp23.init.crd"
#set peptidefile  "walp23.spanning.m15.crd"
#set peptidefile  "walp23.spanning.init.crd"

# Specify the name of the job <ident> the location of forcetables and
# the output and scripts directories, dir and filename of the initial positions
#set currentrundir "runcode"
set ident "popc[set numberoflipid]_walp[set numberofpeptide]"

set tabledir "./forcetables"
set overlapdir "./overlapcoffs"
set outputdir "./$ident"
set topofile "$ident.top"
set readpdbdir "./readfiles"
set readpdbname [list "$lipidfile" "$peptidefile"]
# Specify how we want to use vmd for visualization: allowable values
# are "interactive" "offline" "none".  interactive rarely works
set use_vmd "offline"


#########################################################
######## Specify a global key for molecule types ########
#########################################################
# In this line we specify the details of all molecule types in the
# system.  In this example molecule type 0 is assigned to be a popc lipid.

# --- Specify mole type: POPC lipid -----#
# set molpopclist
source configs/popc.tcl
# --- Specify mole type: Walp protein -----#
# set molrespartlist
source configs/walp23.tcl

# moltypelists is used for setting global variable moltypeskey in generataion namespace
lappend moltypelists $molpopclist
lappend moltypelists $molpeptidepartlist
puts "moltypelists::: $moltypelists"
#exit
unset molpopclist
unset molpeptidepartlist

#########################################################
########## Specify the geometry and composition ##########
#########################################################
# --- Specify the lipid+protein geometry and composition ----#
### Set the geometry 
# geometry structure:    {geometry  "geometry characteristic" }
set howtoset "\"fromfile\""
set aspace " "
set geometryconponent "geometry" 
set lipidfile "$ident/$lipidfile"
set geometry [set geometryconponent][set aspace][set howtoset][set aspace][set lipidfile] 
unset howtoset  aspace geometryconponent
#puts "geometry::: $geometry "
#exit
### Set the n_molslist 
#n_molslist structure:   { n_molslist {  { 0 $numberoflipid } } }
#moltypeid
set componet_n_molslist 0
lappend componet_n_molslist $numberoflipid
lappend vector_n_molslist $componet_n_molslist
set n_molslist "n_molslist"
lappend n_molslist $vector_n_molslist
unset componet_n_molslist vector_n_molslist
#puts "n_molslist::: $n_molslist"
#exit
### Now bundle the above info into a list
lappend lipidspec $geometry
lappend lipidspec $n_molslist
unset geometry n_molslist

# Set the box size 
# Notice, should be the same as the values in the bilayer readfile
set lengthx 54.53
lappend setbox_l $lengthx
lappend setbox_l $lengthx
lappend setbox_l 166.9462 
unset lengthx
set linetension 0

# --- Specify geometry and compositions of the peptide ----#
### Set the geometry 
# geometry structure:    {geometry  "geometry characteristic" }
set howtoset "\"fromfile\""
set aspace " "
set geometryconponent "geometry" 
set peptidefile "$ident/$peptidefile"
set geometry [set geometryconponent][set aspace][set howtoset][set aspace][set peptidefile] 
unset howtoset  aspace geometryconponent
#puts "geometry::: $geometry "
#exit
### Set the n_molslist 
#n_molslist structure:   { n_molslist {  { 0 $numberofpeptide} } }
#moltypeid
set componet_n_molslist 1
# 1 molecule
lappend componet_n_molslist $numberofpeptide
lappend vector_n_molslist $componet_n_molslist
set n_molslist "n_molslist"
lappend n_molslist $vector_n_molslist
unset componet_n_molslist vector_n_molslist
#puts "n_molslist::: $n_molslist"
#exit
### Now bundle the above info into a list
lappend peptidespec $geometry
lappend peptidespec $n_molslist
unset geometry n_molslist

# Now group the lipidspec with peptidespec into a list of such
# systems (we can have multiple systems if we like each with different
# composition of molecule types
lappend system_specs $lipidspec
lappend system_specs $peptidespec
#puts "system_specs: $system_specs"
#exit
unset lipidspec peptidespec


# Warmup parameters
#----------------------------------------------------------#
set warm_time_step 0.1
set warmup_temp 1.
set warmup_freq 5
set warmsteps 50
set warmtimes 20
set free_warmsteps 10
set free_warmtimes 20

# ------ Integration parameters -----------------#
## timestep for membrane-only simulations or fixed peptide
set main_time_step 0.1
## timestep for membrane-peptide simulations
set sys_time_step 0.01
set verlet_skin 2.0 
# -------Constant Temperature-----------------#
set langevin_gamma 0.2
set systemtemp 1.
# -------Constant Pressure-----------------#
set npt "on"
set p_ext 0.000
set piston_mass 0.0005
set gamma_0 0.2
set gamma_v 0.00004


# -------DPD-----------------#
##DPD does not work on peptide hydrogen bond, generate wrong structures
#set thermo "DPD"
#set dpd_gamma 1.0 

# Simulation time (in units of tau) while peptide is frozen
# main_time_step will be set to 0.01 after that.
set fix_time_step 10000

# -------- Set the espresso integration steps and times 
# The number of steps to integrate with each call to integrate
set int_steps   50000
# The number of times to call integrate
set int_n_times 10000

# -------- Frequency of backup and analysis
# backup frequency 
set write_frequency 1
# analysis frequency 
set analysis_write_frequency 1

# MPI distribution
# MPI distribution of bilayer
if { [lindex geometry 1] != "random"} {
        if {[setmd n_nodes]==2} {
            setmd node_grid 2 1 1
        } elseif {[setmd n_nodes]==4} {
            setmd node_grid 2 2 1
        } elseif {[setmd n_nodes]==6} {
            setmd node_grid 3 2 1
        } elseif {[setmd n_nodes]==8} {
            setmd node_grid 4 2 1
        } elseif {[setmd n_nodes]==16} {
            setmd node_grid 4 4 1
        } elseif {[setmd n_nodes]==32} {
            setmd node_grid 8 4 1
        } elseif {[setmd n_nodes]==64} {
            setmd node_grid 8 8 1
        }
}

# MPI distribution of random 
if { [lindex geometry 1] == "random"} {
        if {[setmd n_nodes]==8} {
            setmd node_grid 2 2 2
        } elseif {[setmd n_nodes]==64} {
            setmd node_grid 4 4 4
        }
}

##########################################################
# Analysis Parameters
#----------------------------------------------------------# 
set mgrid 8
set stray_cut_off 30.

# These are are parameters that will be passed to the setup_analysis
lappend analysis_flags boxl
lappend analysis_flags temperature
#lappend analysis_flags energy

::mmsg::send [namespace current] "done"
