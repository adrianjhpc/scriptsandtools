#!/usr/bin/env python
#
# Analyse fileparse files.
#    This python code assumes you have collected the 
#    fileparse data using both the fileparse and pmem_fileparse
#    benchmarks in the same run and dumped the data into a single 
#    file.
#

# System modules for grabbing data
import sys
import os.path
import re
from glob import glob
from datetime import datetime

def main(argv):
    
    files = sys.argv[1:]

    # Loop over files getting data
    for file in files:
        infile = open(file, 'r')
        normal_times = {}
        pmem_times = {}
        pmem_test = False
        sizes = {}
        counter = -1
        for line in infile:
            if re.search('Benchmark is', line):
                tokens = line.split()
                if(tokens[2] == 'fileparse.'):
                    pmem_test = False
                    counter = counter + 1
                else:
                    pmem_test = True
            elif re.search('Size is', line):
                tokens = line.split()
                temp = tokens[2]
                temp = temp[:-1]
                sizes[counter] = temp
            elif re.search('Start: ', line):
                tokens = line.split()
                if pmem_test:
                    pmem_times[counter] = tokens[6]
                else:
                    normal_times[counter] = tokens[6]

        outfile = open(file+".fileparse.data", 'w')
        i = 0
        while i <= counter:
            outfile.write("%s %s\n" % (sizes[i],normal_times[i]))
            i = i + 1

        outfile = open(file+".pmem_fileparse.data", 'w')
        i = 0
        while i <= counter:
            outfile.write("%s %s\n" % (sizes[i],pmem_times[i]))
            i = i + 1
        
        infile.close()
    

    sys.exit(0)
                
if __name__ == "__main__":
    main(sys.argv[1:])
