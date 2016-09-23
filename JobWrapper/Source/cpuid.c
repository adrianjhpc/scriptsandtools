/*===============================================================
* cpuid - This C program tries to work out which processor it is
* running on when it is run.  It requires a number to be passed 
* to it that defines how many cores each processor has.  It then
* uses that along with information from sched_getcpu() to work 
* out (and return) the processor number this program is running 
* on.  Processors are numbers from 0 up.
*
*===============================================================
*
*===============================================================
* v1.0 - Initial version, Adrian Jackson
*===============================================================
*
*----------------------------------------------------------------------
* Copyright 2014 EPCC, The University of Edinburgh
*
* cpuid is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* cpuid is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with cpuid.  If not, see <http://www.gnu.org/licenses/>.
*----------------------------------------------------------------------
*/


#include<stdio.h>
#include<stdlib.h>
#include<sched.h>


int main(int argc, char **argv){

  int cpuid, procsize;

  if(argc != 2){
     printf("This program needs to be run with a single argument specifying the number of cores in a single prcoessor.\n");
     printf("You have run with %d arguments so we are aborting the run\n",argc-1);
     return -1;
  }

  procsize = atoi(argv[1]);

  cpuid = sched_getcpu();

  cpuid = cpuid/procsize;

  return cpuid;

}

