#!/bin/bash --login
#PBS -N pytask
# Request the number of cores that you need in total
#PBS -l select=2
#PBS -l walltime=0:02:00
#PBS -A z01-cse

module load python

cd /work/z01/z01/adrianj/PythonTaskFarm
cp /home/z01/z01/adrianj/PythonTaskFarm/taskfarm .
cp /home/z01/z01/adrianj/PythonTaskFarm/pythonfile.py .

export EXE=hello.exe
export DATAFILE=bob.txt
export SWEEPOPT=4
export SUBJOB=0
export NSIMS=3

aprun -n 48 -N 24 ./taskfarm pythonfile.py $EXE $DATAFILE $SWEEPOPT $SUBJOB $NSIMS
