#!/bin/bash
#PBS -N test
#PBS -l select=1
#PBS -l walltime=00:05:00
#PBS -A z01-cse 

cd $PBS_O_WORKDIR

# This checks the cpuid program is built
make

# You must set this environment variable
export PMI_NO_FORK=1

# The script below assumes these are set
# You will need to alter EXE1 and EXE2 to set the appropriate 
# executables, and ARGS1 and ARGS2 to pass input arguments to 
# those executables if appropriate.  The JOB#OUT and JOB#ERR 
# variables specify where the executable write their output and 
# error text output.  This can be just a file name or a file name 
# with directory path (i.e.. JOB1OUT="job1.out" or 
# JOB1OUT="1stdir/job1.out").  The NTHREADS variables set 
# OMP_NUM_THREADS elsewhere so if you need to change the number 
# of threads that the programs are using you should change these 
# variables (individually they should not exceed 12).
export EXE1=""
export ARGS1=""
export JOB1OUT="job1.out"
export JOB1ERR="job1.err"
export NTHREADS_1=12
export EXE2=""
export ARGS2=""
export JOB2OUT="job2.out"
export JOB2ERR="job2.err"
export NTHREADS_2=12

# Do not change this value
export NUM_CORES_PER_PROCESSOR=12

# Do not change this line
aprun -n2 -S1 -cc 0-11:12-23 bash aprun_wrapper.bash

#EOF

