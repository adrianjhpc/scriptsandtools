#!/bin/bash --login
#You may want to alter the job name below
#PBS -N test
#PBS -l select=1
#It is likely you want to alter the time limit for the job below 
#PBS -l walltime=00:05:00
#You will definitely need to add something on the line below to specify the budget this job should be charged to.
#PBS -A 

cd $PBS_O_WORKDIR

# You must set this environment variable
export PMI_NO_FORK=1

# The script below assumes these are set
# You will need to alter EXE1, EXE2,etc... to set the appropriate 
# executables, and ARGS1, ARGS2, etc... to pass input arguments to 
# those executables if appropriate.  The JOB#OUT and JOB#ERR 
# variables specify where the executable write their output and 
# error text output.  This can be just a file name or a file name 
# with directory path (i.e.. JOB1OUT="job1.out" or 
# JOB1OUT="1stdir/job1.out").  The NTHREADS variables set 
# OMP_NUM_THREADS elsewhere so if you need to change the number 
# of threads that the programs are using you should change these 
# variables (individually they should not exceed 2 for this setup).
export EXE1="xthi"
export ARGS1=""
export JOB1OUT="job1.out"
export JOB1ERR="job1.err"
export NTHREADS_1=2
export EXE2="xthi"
export ARGS2=""
export JOB2OUT="job2.out"
export JOB2ERR="job2.err"
export NTHREADS_2=2
export EXE3="xthi"
export ARGS3=""
export JOB3OUT="job3.out"
export JOB3ERR="job3.err"
export NTHREADS_3=2
export EXE4="xthi"
export ARGS4=""
export JOB4OUT="job4.out"
export JOB4ERR="job4.err"
export NTHREADS_4=2
export EXE5="xthi"
export ARGS5=""
export JOB5OUT="job5.out"
export JOB5ERR="job5.err"
export NTHREADS_5=2
export EXE6="xthi"
export ARGS6=""
export JOB6OUT="job6.out"
export JOB6ERR="job6.err"
export NTHREADS_6=2
export EXE7="xthi"
export ARGS7=""
export JOB7OUT="job7.out"
export JOB7ERR="job7.err"
export NTHREADS_7=2
export EXE8="xthi"
export ARGS8=""
export JOB8OUT="job8.out"
export JOB8ERR="job8.err"
export NTHREADS_8=2
export EXE9="xthi"
export ARGS9=""
export JOB9OUT="job9.out"
export JOB9ERR="job9.err"
export NTHREADS_9=2
export EXE10="xthi"
export ARGS10=""
export JOB10OUT="job10.out"
export JOB10ERR="job10.err"
export NTHREADS_10=2
export EXE11="xthi"
export ARGS11=""
export JOB11OUT="job11.out"
export JOB11ERR="job11.err"
export NTHREADS_11=2
export EXE12="xthi"
export ARGS12=""
export JOB12OUT="job12.out"
export JOB12ERR="job12.err"
export NTHREADS_12=2


# Do not change this value
export NUM_CORES_PER_PROCESSOR=2

# Do not change this line
aprun -n12 -S6 -d2 bash aprun_wrapper.bash

#EOF

