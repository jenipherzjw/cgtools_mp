#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=dobby02:ppn=2
##PBS -l nodes=1:ppn=8
##PBS -l walltime=120:00:00,nodes=1:ppn=8
##PBS -l cput=120:00:00,nodes=5:ppn=8
#PBS -j oe
#PBS -N bilayer72_walp
#PBS -m abe

# Author: Zunjing Wang  2010 - 2014

set -x

cd $PBS_O_WORKDIR

echo Beginning job on `hostname` on `date`
echo Job number $PBS_JOBID

#directory the script is submitted from
export WORKDIR=$PBS_O_WORKDIR

# number of processors for vmirun
export NP=`wc -l < $PBS_NODEFILE`
export NAME=$PBS_JOBNAME

#make sure in work directory
cd $WORKDIR
FLAG=$?
echo "cd return value is $FLAG"
if [ $FLAG != 0 ]; then
  echo cd $WORKDIR failed
  exit 1
fi

sleep 5

echo "Scratch Job Directory =" `pwd`
declare -i TIME1=$(date +%s)

# Run the MPI program on all nodes/processors requested by the job  
mpirun -np $NP ~/Espresso.pepmem/obj-Xeon_64-pc-linux/Espresso_bin ./cgtoolsmain.tcl -n $NP configs/$NAME.tcl

declare -i TIME2=$(date +%s)
declare -i TIME=$(($TIME2-$TIME1))
export LOWER_RUN_LIMIT=10

if [ $TIME -le $LOWER_RUN_LIMIT ]; then
    	echo 'Espresso Crash' > error.$JOB
    
else
	echo Processors used:
	cat $PBS_NODEFILE
	echo Job $JOB completed on `date`. 
	
  	echo $NSTEP
	export MPICH_HOME
#	ssh cerberus "(cd $WORKDIR; /opt/pbs/bin/qsub $SCRIPT)"
fi

#done
