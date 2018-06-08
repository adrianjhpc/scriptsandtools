#!/bin/bash

# Script assumes the following environment variables were set in the jobscript:
# (?) is the number of the job to be run, currently this JobWrapper is set up to 
# run 8 so ? will be from 1 to 8.
#  EXE? : name of the ? executable 
#  ARGS? : arguments to be passed to the first executable 
#  JOB?OUT : name of the output file for the first executable
#  JOB?ERR : name of the error file for the first executable
#  NTHREADS_? : number of OpenMP threads for this executable


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
    2)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE3} ${ARGS3} with OMP_NUM_THREADS=$NTHREADS_3"
        env OMP_NUM_THREADS=$NTHREADS_3 ${EXE3} ${ARGS3} > ${JOB3OUT} 2> ${JOB3ERR}
        ;;

    3)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE4} ${ARGS4} with OMP_NUM_THREADS=$NTHREADS_4"
        env OMP_NUM_THREADS=$NTHREADS_4 ${EXE4} ${ARGS4} > ${JOB4OUT} 2> ${JOB4ERR}
        ;;
    4)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE5} ${ARGS5} with OMP_NUM_THREADS=$NTHREADS_5"
        env OMP_NUM_THREADS=$NTHREADS_5 ${EXE5} ${ARGS5} > ${JOB5OUT} 2> ${JOB5ERR}
        ;;
    5)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE6} ${ARGS6} with OMP_NUM_THREADS=$NTHREADS_6"
        env OMP_NUM_THREADS=$NTHREADS_6 ${EXE6} ${ARGS6} > ${JOB6OUT} 2> ${JOB6ERR}
        ;;
    6)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE7} ${ARGS7} with OMP_NUM_THREADS=$NTHREADS_7"
        env OMP_NUM_THREADS=$NTHREADS_7 ${EXE7} ${ARGS7} > ${JOB7OUT} 2> ${JOB7ERR}
        ;;

    7)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE8} ${ARGS8} with OMP_NUM_THREADS=$NTHREADS_8"
        env OMP_NUM_THREADS=$NTHREADS_8 ${EXE8} ${ARGS8} > ${JOB8OUT} 2> ${JOB8ERR}
        ;;

    *) 
	echo "We had a problem, please contact the helpdesk (helpdesk@archer.ac.uk)"
        echo "or a.jackson@epcc.ed.ac.uk if you need help sorting this problem out.  It is likely"
	echo "that the problem is due to the number of cores per process"
	echo "or nthreads variables, or that the aprun command has been altered in a way that"
	echo "does not work with this script and the associated programs."
	;;
esac
exit 0
#EOF

