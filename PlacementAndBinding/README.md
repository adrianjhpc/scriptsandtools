# PlacementAndBinding
This directory contains versions of the xthi tool to display MPI process placements and OpenMP thread binding.

xthi implemented hybrid (MPI + OpenMP) functionality, enabling hybrid placement and binding to be investigated.

xthi-mpi-only implements MPI functionality, enabling process placement to be investigated.

xthi-openmp-only implements OpenMP functionality, enabling thread binding to be investigated.

To build the executables simply type `make`. You may need to modify the `Makefile` to change the compilers (`CC` and `MPICC`) to reference appropriate compilers for you system.

