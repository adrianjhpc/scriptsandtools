#!/bin/bash

# Script assumes the following environment variables were set in the jobscript:
# (?) is the number of the job to be run, currently this JobWrapper is set up to 
# run 24 jobs, so ? will be from 1 to 24.
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

    8)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE9} ${ARGS9} with OMP_NUM_THREADS=$NTHREADS_9"
        env OMP_NUM_THREADS=$NTHREADS_9 ${EXE9} ${ARGS9} > ${JOB9OUT} 2> ${JOB9ERR}
        ;;

    9)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE10} ${ARGS10} with OMP_NUM_THREADS=$NTHREADS_10"
        env OMP_NUM_THREADS=$NTHREADS_10 ${EXE10} ${ARGS10} > ${JOB10OUT} 2> ${JOB10ERR}
        ;;

    10)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE11} ${ARGS11} with OMP_NUM_THREADS=$NTHREADS_11"
        env OMP_NUM_THREADS=$NTHREADS_11 ${EXE11} ${ARGS11} > ${JOB11OUT} 2> ${JOB11ERR}
        ;;

    11)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE12} ${ARGS12} with OMP_NUM_THREADS=$NTHREADS_12"
        env OMP_NUM_THREADS=$NTHREADS_12 ${EXE12} ${ARGS12} > ${JOB12OUT} 2> ${JOB12ERR}
        ;;

    12)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE13} ${ARGS13} with OMP_NUM_THREADS=$NTHREADS_13"
        env OMP_NUM_THREADS=$NTHREADS_13 ${EXE13} ${ARGS13} > ${JOB13OUT} 2> ${JOB13ERR}
        ;;

    13)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE14} ${ARGS14} with OMP_NUM_THREADS=$NTHREADS_14"
        env OMP_NUM_THREADS=$NTHREADS_14 ${EXE14} ${ARGS14} > ${JOB14OUT} 2> ${JOB14ERR}
        ;;

    14)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE15} ${ARGS15} with OMP_NUM_THREADS=$NTHREADS_15"
        env OMP_NUM_THREADS=$NTHREADS_15 ${EXE15} ${ARGS15} > ${JOB15OUT} 2> ${JOB15ERR}
        ;;

    15)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE16} ${ARGS16} with OMP_NUM_THREADS=$NTHREADS_16"
        env OMP_NUM_THREADS=$NTHREADS_16 ${EXE16} ${ARGS16} > ${JOB16OUT} 2> ${JOB16ERR}
        ;;

    16)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE17} ${ARGS17} with OMP_NUM_THREADS=$NTHREADS_17"
        env OMP_NUM_THREADS=$NTHREADS_17 ${EXE17} ${ARGS17} > ${JOB17OUT} 2> ${JOB17ERR}
        ;;

    17)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE18} ${ARGS18} with OMP_NUM_THREADS=$NTHREADS_18"
        env OMP_NUM_THREADS=$NTHREADS_18 ${EXE18} ${ARGS18} > ${JOB18OUT} 2> ${JOB18ERR}
        ;;

    18)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE19} ${ARGS19} with OMP_NUM_THREADS=$NTHREADS_19"
        env OMP_NUM_THREADS=$NTHREADS_19 ${EXE19} ${ARGS19} > ${JOB19OUT} 2> ${JOB19ERR}
        ;;

    19)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE20} ${ARGS20} with OMP_NUM_THREADS=$NTHREADS_20"
        env OMP_NUM_THREADS=$NTHREADS_20 ${EXE20} ${ARGS20} > ${JOB20OUT} 2> ${JOB20ERR}
        ;;

    20)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE21} ${ARGS21} with OMP_NUM_THREADS=$NTHREADS_21"
        env OMP_NUM_THREADS=$NTHREADS_21 ${EXE21} ${ARGS21} > ${JOB21OUT} 2> ${JOB21ERR}
        ;;

    21)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE22} ${ARGS22} with OMP_NUM_THREADS=$NTHREADS_22"
        env OMP_NUM_THREADS=$NTHREADS_22 ${EXE22} ${ARGS22} > ${JOB22OUT} 2> ${JOB22ERR}
        ;;

    22)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE23} ${ARGS23} with OMP_NUM_THREADS=$NTHREADS_23"
        env OMP_NUM_THREADS=$NTHREADS_23 ${EXE23} ${ARGS23} > ${JOB23OUT} 2> ${JOB23ERR}
        ;;

    23)
        echo "$(hostname) [ rank $MY_PROCID ] is ${EXE24} ${ARGS24} with OMP_NUM_THREADS=$NTHREADS_24"
        env OMP_NUM_THREADS=$NTHREADS_24 ${EXE24} ${ARGS24} > ${JOB24OUT} 2> ${JOB24ERR}
        ;;


    *) 
	echo "We had a problem, please contact the helpdesk (helpdesk@login.archer.ac.uk)"
        echo "or adrianj@epcc.ed.ac.uk if you need help sorting this problem out.  It is likely"
	echo "that the problem is due to the number of cores per process"
	echo "or nthreads variables, or that the aprun command has been altered in a way that"
	echo "does not work with this script and the associated programs."
	;;
esac
exit 0
#EOF

