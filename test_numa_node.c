#include <numaif.h>
#include <numa.h>
#include <utmpx.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

void print_bits(unsigned int n);


// A test code to programatically restrict memory usage to 
// the socket a process is bound to. This is potential required for 
// MPI applications as they run multiple processes across numa nodes so a 
// numactl membind command is not straight forward, whereas the code below 
// looks up the numa node a process is running on and then binds the memory 
// to that node. This program really is just testing out the numa api.
int main(int argc, char **argv){

  int tempnum;
  int rank;
  int size;
  int cpu = sched_getcpu();
  int node = numa_node_of_cpu(cpu);
  struct bitmask *bitmask, *memmask, *tempmask;
 
  MPI_Init(&argc, &argv);

  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);


  printf("a\n");
  bitmask = numa_allocate_nodemask();
  memmask = numa_allocate_nodemask();
  printf("b\n");


  bitmask = numa_get_run_node_mask();
  memmask = numa_get_membind();

  printf("c\n");


  tempmask = numa_allocate_cpumask(); 

  printf("d\n");

  tempnum = 0;
  numa_node_to_cpus(tempnum, tempmask);
  printf("rank: %d node %d %lu\n", rank, tempnum, *tempmask->maskp);
  DisplayBinary(*tempmask->maskp);
  printf("\n");
  tempnum = 1;
  numa_node_to_cpus(tempnum, tempmask);
  printf("rank: %d node %d %lu\n", rank, tempnum, *tempmask->maskp);
  DisplayBinary(*tempmask->maskp);
  printf("\n");

  numa_bitmask_free(tempmask);
 
  printf("rank: %d %d %d current memmask %lu nodemask %lu\n", rank, cpu, node, *memmask->maskp, *bitmask->maskp);
  DisplayBinary(*memmask->maskp);
  printf("\n");
  DisplayBinary(*bitmask->maskp);
  printf("\n");
  numa_set_membind(bitmask);
  memmask = numa_get_membind();

  printf("rank: %d %d %d current memmask %lu\n", rank, cpu, node, *memmask->maskp);
  DisplayBinary(*memmask->maskp);
  printf("\n");

  MPI_Finalize();

  numa_bitmask_free(bitmask);
  numa_bitmask_free(memmask);

  return 0;
}



// Print out a bitmask in bits so individual
// node or CPU settings are visible
void print_bits(unsigned int n)
{
    int l = sizeof(n) * 8;
    for (int i = l - 1 ; i >= 0; i--) {
        printf("%x", (n & (1 << i)) >> i);
    }
}


