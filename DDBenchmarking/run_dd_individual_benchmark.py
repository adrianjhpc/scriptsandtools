
import sys
import os
import subprocess
import matplotlib.pyplot as plt
import numpy as np
import re

num_args = len(sys.argv)

if(num_args != 4):
	print("Expecting the following arguments: output_file local, number of iterations, size of the file")
	sys.exit(1)

arguments =  sys.argv
file_location = arguments[1]
num_iter = int(arguments[2])

if(num_iter < 1):
	print("Error, expecting the number of iterations to be non-zero")
	sys.exit(1)

file_size = int(arguments[3])

if(file_size < 1):
        print("Error, expecting the file size to be non-zero")
        sys.exit(1)

time = []
bandwidth = []

for x in range(0, num_iter):
    exec_string = 'dd if=/dev/zero of=' + file_location + ' bs=' + str(file_size) + 'KB count=1 oflag=dsync'
    res = subprocess.Popen(exec_string, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    out, err = res.communicate()
    err = err.decode()
    lines = err.splitlines()
    if 'failed' in err:
        print(err)
        sys.exit(1)
    split = lines[2].split(" ")
    if(len(split) == 11):
        time.append(split[7])
        bandwidth.append(split[9]+split[10])
    elif(len(split) == 9):
        time.append(split[5])
        bandwidth.append(split[7]+split[8])
    else:
        print('dd output not as expected, exiting')
        sys.exit(1)


os.remove(file_location)

# Convert the times from strings to floating point numbers for graphing
time = [float(i) for i in time] 

# Split the bandwidth string up so that the bandwidth and it's units are separate
for i,string in enumerate(bandwidth):
	bandwidth[i] = re.sub( r"([a-zA-Z])", r" \1", string).split()

final_bandwidth = []

# Process the bandwidth entries and make them all the same unit.
# At the moment we are converting to MB
for entry in bandwidth:
	if 'K' in entry[1].upper():
		final_bandwidth.append(float(entry[0])/1024)
	elif 'M' in entry[1].upper():
		final_bandwidth.append(float(entry[0]))
	elif 'G' in entry[1].upper():
		final_bandwidth.append(float(entry[0])*1024)
	elif 'T' in entry[1].upper():
		final_bandwidth.append(float(entry[0])*1024*1024)
	else:
		print("Unknown bandwidth quantity")
		sys.exit(1)

plt.style.use('ggplot')
fig, ax1 = plt.subplots()

ax1.set_facecolor('lightblue')
ax1.set_title("dd benchmarking - file: " + file_location + " block size: " + str(file_size))

label = list(range(0, num_iter))

color='lightslategray'
y_pos = np.arange(len(label))
ax1.bar(y_pos, time, color=color)
ax1.set_xlabel("Run")
ax1.set_ylabel("Runtime (seconds)", color=color)
ax1.set_axisbelow(True)

color='black'

ax2 = ax1.twinx()  
ax2.set_ylabel('Bandwidth (MB/s)', color=color)  # we already handled the x-label with ax1
ax2.plot(y_pos, final_bandwidth, color=color)
ax2.set_axisbelow(True)
ax2.grid(None)


fig.tight_layout()

plt.savefig('dd-results-'+file_location.replace('/','-')+'-bs-'+str(file_size))
