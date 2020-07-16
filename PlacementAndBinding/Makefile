CC=gcc
MPICC=mpicc
CFLAGS=-fopenmp
CFLAGSNOOMP=

all: xthi xthi-mpi-only xthi-openmp-only

xthi: xthi.c  Makefile
	$(MPICC) $(CFLAGS) -o $@ $<

xthi-mpi-only: xthi-mpi-only.c Makefile
	$(MPICC) $(CFLAGSNOOMP) -o $@ $<

xthi-openmp-only: xthi-openmp-only.c Makefile
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -fr xthi xthi-mpi-only xthi-openmp-only *.o
