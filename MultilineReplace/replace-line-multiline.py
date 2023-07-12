#!/bin/python3

import sys

if(len(sys.argv) != 2):
    print("Expecting a filename to convert.")
    exit

filename = sys.argv[1]
output_filename = filename+'.new'

print("Input file is: "+filename)
print("Output file is: "+output_filename)
 
outputstring = '      use cosa_precision\n\n      implicit none\n'
inputstring = 'implicit none'


input_file = open(filename, 'r')
input_lines = input_file.readlines()
number_of_input_lines =  len(input_lines)
input_file.close()

output_lines = []
check_next_line = False
append = True
for i,line in enumerate(input_lines):
    if(check_next_line):
        if(len(line.strip()) == 0):
            append = False
        check_next_line = False
    if(line.strip() == inputstring):
        line = outputstring
    elif('use' in line):
        check_next_line = True
    if(append):
        output_lines.append(line)
    append =  True

output_file = open(output_filename, 'w')
for line in output_lines:
    output_file.write(line)
output_file.close()

 
