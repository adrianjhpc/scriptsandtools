JobWrapper is a utility that I wrote to enable single nodes on a HPC system to be shared between multiple executables.

It was written because on our Cray, aprun commands (the program that launches jobs onto the compute nodes) require exclusive access for a single aprun instance to the nodes it is using.  This means you can't run multiple
executables on the same node.

JobWrapper allows you to do that by handling the job launching itself and presenting it as a single aprun job.

Because of the way it works the number of things it can run is hard coded, so there are different versions for running different numbers of executables on a node.

