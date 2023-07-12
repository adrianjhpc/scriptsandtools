#!/bin/python3

import sys

if(len(sys.argv) != 2):
    print("Expecting a filename to convert.")
    exit

filename = sys.argv[1]
output_filename = filename.split('.',1)[0]+'.f90'

print("Input file is: "+filename)
print("Output file is: "+output_filename)
 

input_file = open(filename, 'r')
input_lines = input_file.readlines()
number_of_input_lines =  len(input_lines)
input_file.close()

output_lines = []
for i,line in enumerate(input_lines):
    temp_line = list(line)
    add_continue = False
    if(i != number_of_input_lines-1):
        temp_next_line = list(input_lines[i+1])
        if(len(temp_next_line) > 5):
            if(temp_next_line[5] == '&'):
                add_continue = True
    if(temp_line[0] == 'c' or temp_line[0] == 'C' or temp_line[0] == '*' or temp_line[0] == 'd' or temp_line[0] == 'D'):
        temp_line[0] = '!'
    if(len(temp_line) > 5):
        if(temp_line[5] == '&'):
            if(temp_line.count("'")%2 == 0):
                temp_line[5] = ' '
    output_temp_line = ''.join(temp_line)
    if(add_continue):
        output_temp_line = output_temp_line.rstrip() + ' &\n'
    else:
        output_temp_line = output_temp_line
    output_lines.append(output_temp_line)

output_file = open(output_filename, 'w')
for line in output_lines:
    output_file.write(line)
output_file.close()

 
