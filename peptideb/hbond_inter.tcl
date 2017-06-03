# Hydrogen bonding
# Careful with the bonded partners !  
# if {$::cgtools::peptideb::HB_bilayer_dz > 0.} {
#     inter 8 11 lj-angle $::cgtools::peptideb::ljangle_eps \
# 				 $::cgtools::peptideb::hbond_NC $::cgtools::peptideb::ljangle_cut 1 -1 2 \
# 				 -2 0 $::cgtools::peptideb::HB_bilayer_z0 $::cgtools::peptideb::HB_bilayer_dz \
# 				 $::cgtools::peptideb::HB_bilayer_kappa $::cgtools::peptideb::ljangle_eps_bilayer
# } else {
    inter 8 11 lj-angle $::cgtools::peptideb::ljangle_eps \
				 $::cgtools::peptideb::hbond_NC $::cgtools::peptideb::ljangle_cut 1 -1 2 -2
# }


###copy from  ~/mypeptidenew/src/chain_interactions.tcl
### ------------------------------------------------------------------------
# # Hydrogen bonding
#    # Careful with the bonded partners !  
#    if {$HB_bilayer_dz > 0.} {
#        lappend nb_interactions [list 0 2 lj-angle $ljangle_eps \
#                                     $hbond_NC $ljangle_cut 1 -1 1 \
#                                     -2 0 $HB_bilayer_z0 $HB_bilayer_dz \
#                                     $HB_bilayer_kappa $ljangle_eps_bilayer]
#    } else {
#        lappend nb_interactions [list 0 2 lj-angle $ljangle_eps \
#                                     $hbond_NC $ljangle_cut 1 -1 1 -2]
#    }
#
#    # Self interaction - hat potential
#    if {$hat_potential > 0. && $HB_bilayer_dz > 0.} {
#        lappend bonded_parms \
#            [list 17 hat $hat_potential \
#                 $HB_bilayer_z0 $HB_bilayer_dz $HB_bilayer_kappa]
#    }
### ------------------------------------------------------------------------
