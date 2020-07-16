# PlacementAndBinding
This directory contains versions of the xthi tool to display MPI process placements and OpenMP thread binding. All the programs in here are based on a tool that was original provided by Cray, [xthi](https://pubs.cray.com/content/S-2496/CLE%206.0.UP01/xctm-series-user-application-placement-guide-cle-60up01/run-an-openmp-application).

xthi implemented hybrid (MPI + OpenMP) functionality, enabling hybrid placement and binding to be investigated.

xthi-mpi-only implements MPI functionality, enabling process placement to be investigated.

xthi-openmp-only implements OpenMP functionality, enabling thread binding to be investigated.

To build the executables simply type `make`. You may need to modify the `Makefile` to change the compilers (`CC` and `MPICC`) to reference appropriate compilers for you system.

