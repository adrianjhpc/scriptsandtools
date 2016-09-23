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
# variables (individually they should not exceed 1 for this setup).
export EXE1=""
export ARGS1=""
export JOB1OUT="job1.out"
export JOB1ERR="job1.err"
export NTHREADS_1=1
export EXE2=""
export ARGS2=""
export JOB2OUT="job2.out"
export JOB2ERR="job2.err"
export NTHREADS_2=1
export EXE3=""
export ARGS3=""
export JOB3OUT="job3.out"
export JOB3ERR="job3.err"
export NTHREADS_3=1
export EXE4=""
export ARGS4=""
export JOB4OUT="job4.out"
export JOB4ERR="job4.err"
export NTHREADS_4=1
export EXE5=""
export ARGS5=""
export JOB5OUT="job5.out"
export JOB5ERR="job5.err"
export NTHREADS_5=1
export EXE6=""
export ARGS6=""
export JOB6OUT="job6.out"
export JOB6ERR="job6.err"
export NTHREADS_6=1
export EXE7=""
export ARGS7=""
export JOB7OUT="job7.out"
export JOB7ERR="job7.err"
export NTHREADS_7=1
export EXE8=""
export ARGS8=""
export JOB8OUT="job8.out"
export JOB8ERR="job8.err"
export NTHREADS_8=1
export EXE9=""
export ARGS9=""
export JOB9OUT="job9.out"
export JOB9ERR="job9.err"
export NTHREADS_9=1
export EXE10=""
export ARGS10=""
export JOB10OUT="job10.out"
export JOB10ERR="job10.err"
export NTHREADS_10=1
export EXE11=""
export ARGS11=""
export JOB11OUT="job11.out"
export JOB11ERR="job11.err"
export NTHREADS_11=1
export EXE12=""
export ARGS12=""
export JOB12OUT="job12.out"
export JOB12ERR="job12.err"
export NTHREADS_12=1
export EXE13=""
export ARGS13=""
export JOB13OUT="job13.out"
export JOB13ERR="job13.err"
export NTHREADS_13=1
export EXE14=""
export ARGS14=""
export JOB14OUT="job14.out"
export JOB14ERR="job14.err"
export NTHREADS_14=1
export EXE15=""
export ARGS15=""
export JOB15OUT="job15.out"
export JOB15ERR="job15.err"
export NTHREADS_15=1
export EXE16=""
export ARGS16=""
export JOB16OUT="job16.out"
export JOB16ERR="job16.err"
export NTHREADS_16=1
export EXE17=""
export ARGS17=""
export JOB17OUT="job17.out"
export JOB17ERR="job17.err"
export NTHREADS_17=1
export EXE18=""
export ARGS18=""
export JOB18OUT="job18.out"
export JOB18ERR="job18.err"
export NTHREADS_18=1
export EXE19=""
export ARGS19=""
export JOB19OUT="job19.out"
export JOB19ERR="job19.err"
export NTHREADS_19=1
export EXE20=""
export ARGS20=""
export JOB20OUT="job20.out"
export JOB20ERR="job20.err"
export NTHREADS_20=1
export EXE21=""
export ARGS21=""
export JOB21OUT="job21.out"
export JOB21ERR="job21.err"
export NTHREADS_21=1
export EXE22=""
export ARGS22=""
export JOB22OUT="job22.out"
export JOB22ERR="job22.err"
export NTHREADS_22=1
export EXE23=""
export ARGS23=""
export JOB23OUT="job23.out"
export JOB23ERR="job23.err"
export NTHREADS_23=1
export EXE24=""
export ARGS24=""
export JOB24OUT="job24.out"
export JOB24ERR="job24.err"
export NTHREADS_24=1


# Do not change this value
export NUM_CORES_PER_PROCESSOR=1

# Do not change this line
aprun -n24 -S12 -d1 bash aprun_wrapper.bash

#EOF

