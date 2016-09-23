#!/bin/bash

# Script assumes the following environment variables were set in the jobscript:
#  EXE1 : name of the first executable 
#  ARGS1 : arguments to be passed to the first executable 
#  JOB1OUT : name of the output file for the first executable
#  JOB1ERR : name of the error file for the first executable
#  NTHREADS_1 : number of OpenMP threads for this executable
#  EXE2 : name of the second executable
#  ARGS2 : arguments to be passed to the first executable 
#  JOB2OUT : name of the output file for the first executable
#  JOB2ERR : name of the error file for the first executable
#  NTHREADS_2 : number of OpenMP threads for this executable


./cpuid.x $NUM_CORES_PER_PROCESSOR
MY_PROCID=$?

case $MY_PROCID in
    0)
	echo "$(hostname) [ rank $MY_PROCID ] is ${EXE1} ${ARGS1} with OMP_NUM_THREADS=$NTHREADS_1"
	env OMP_NUM_THREADS=$NTHREADS_1 ${EXE1} ${ARGS1} > ${JOB1OUT} 2> ${JOB1ERR}
	;;
    1)
	echo "$(hostname) [ rank $MY_PROCID ] is ${EXE2} ${ARGS2} with OMP_NUM_THREADS=$NTHREADS_2"
	env OMP_NUM_THREADS=$NTHREADS_2 ${EXE2} ${ARGS2} > ${JOB2OUT} 2> ${JOB2ERR}
	;;
    *) 
	echo "We had a problem, please contact the helpdesk (helpdesk@login.archer.ac.uk)"
        echo "or adrianj@epcc.ed.ac.uk if you need help sorting this problem out.  It is likely"
	echo "that the problem is due to the number of values of the number of cores per process"
	echo "or nthreads variables, or that the aprun command has been altered in a way that"
	echo "does not work with this script and the associated programs."
	;;
esac
exit 0
#EOF

