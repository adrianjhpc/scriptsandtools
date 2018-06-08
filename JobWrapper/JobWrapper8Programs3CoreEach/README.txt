The programs and scripts in this directory are designed to allow you run multiple applications inside 
a single node on ARCHER.  They are not designed to run multiple MPI programs inside a single node, the 
way ARCHER is setup means this is not possible with this program (you need to use aprun to launch MPI 
programs and aprun will not run something on a node if another aprun command is already using that node).
Currently the script is setup to run 8 applications in a node, each using 3 cores.  
To use this utility follow the steps below.

1. Edit the jobscript.sh batch job file script appropriately
   Specifically, add the correct executable names and locations to the EXE1,EXE2,EXE3,etc...,EXE8 variables
   You can also add arguments to be passed to each executable and change where they write output 
   text and error text.
   It is likely you will also have to alter the PBS budget and walltime settings.

2. Submit the job. Type:
   qsub jobscript.sh

3. Your programs should now run together on a single node.

