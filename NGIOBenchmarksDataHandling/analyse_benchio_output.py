#!/usr/bin/env python
#
# Analyse IOR output files
#

# System modules for grabbing data
import sys
import os.path
import re
from glob import glob
from datetime import datetime
import datetime as dt
import calendar

# Modules for analysing and visualising data
import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from matplotlib.finance import date2num
matplotlib.rcParams.update({'font.size': 9})
matplotlib.rcParams.update({'figure.autolayout': True})
from matplotlib import dates
import seaborn as sns

def main(argv):

    maxsize = 10000
    
    resdir = sys.argv[1]
    files = get_filelist(resdir, "benchio_", maxsize)
    
    mpi_max_stripecount = 0
    mpi_max_stripemin = np.empty(maxsize)
    mpi_max_stripemax = np.empty(maxsize)
    mpi_max_stripeav = np.empty(maxsize)
    mpi_max_striperate = np.empty(maxsize)
    mpi_max_stripedate = [None] * maxsize
    
    mpi_4_stripecount = 0
    mpi_4_stripemin = np.empty(maxsize)
    mpi_4_stripemax = np.empty(maxsize)
    mpi_4_stripeav = np.empty(maxsize)
    mpi_4_striperate = np.empty(maxsize)
    mpi_4_stripedate =  [None] * maxsize

    hdf5_max_stripecount = 0
    hdf5_max_stripemin = np.empty(maxsize)
    hdf5_max_stripemax = np.empty(maxsize)
    hdf5_max_stripeav = np.empty(maxsize)
    hdf5_max_striperate = np.empty(maxsize)
    hdf5_max_stripedate = [None] * maxsize

    hdf5_4_stripecount = 0
    hdf5_4_stripemin = np.empty(maxsize)
    hdf5_4_stripemax = np.empty(maxsize)
    hdf5_4_stripeav = np.empty(maxsize)
    hdf5_4_striperate = np.empty(maxsize)
    hdf5_4_stripedate = [None] * maxsize
    
    netcdf_max_stripecount = 0
    netcdf_max_stripemin = np.empty(maxsize)
    netcdf_max_stripemax = np.empty(maxsize)
    netcdf_max_stripeav = np.empty(maxsize)
    netcdf_max_striperate = np.empty(maxsize)
    netcdf_max_stripedate = [None] * maxsize

    netcdf_4_stripecount = 0
    netcdf_4_stripemin = np.empty(maxsize)
    netcdf_4_stripemax = np.empty(maxsize)
    netcdf_4_stripeav = np.empty(maxsize)
    netcdf_4_striperate = np.empty(maxsize)
    netcdf_4_stripedate = [None] * maxsize

    cmin = 0
    cmax = 0
    cav = 0
    ccount = 0
    
    # Loop over files getting data    
    for file in files:
       infile = open(file, 'r')
       # Get date of test from file name
       tokens = file.split('_')
       datestring = tokens[-1].split('.')[0]
       runtime = datetime.strptime(datestring, "%Y%m%d%H%M%S")
       resdict = {}
       resdict['JobID'] = 'Unknown'
       header = True
       striping = 0

       for line in infile:
          if header:
              if re.search('Running', line):
                  tokens = line.split()
                  resdict['Writers'] = int(tokens[2])
              elif re.search('Array', line):
                  tokens = line.split()
                  x = int(tokens[4])
                  y = int(tokens[6])
                  z = int(tokens[8])
                  resdict['LocalSize'] = (x, y, z)
              elif re.search('Global', line):
                  tokens = line.split()
                  x = int(tokens[4])
                  y = int(tokens[6])
                  z = int(tokens[8])
                  resdict['GlobalSize'] = (x, y, z)
              elif re.search('Total', line):
                  tokens = line.split()
                  resdict['TotData'] = float(tokens[5])
              elif re.search('MPI-IO', line):
                  mpiio = True
                  header = False
                  cmin = 0
                  cmax = 0
                  cav = 0
                  ccount = 0
                  delete_count = 0
              elif re.search('HDF5', line):
                  hdf5 = True
                  header = False
                  cmin = 0
                  cmax = 0                
                  cav = 0
                  ccount = 0
                  delete_count = 0
              elif re.search('NetCDF', line):
                  netcdf = True
                  header = False                
                  cmin = 0
                  cmax = 0
                  cav = 0
                  ccount = 0
                  delete_count = 0
          else:
              if re.search('Writing to', line):
                  tokens = line.split()
                  if re.match('striped', tokens[2]):
                      striping = -1
                  elif re.match('defstriped', tokens[2]):
                      striping = 4
              elif(re.search('time', line) and not re.search('mintime', line) and not re.search('avgtime', line) and not re.search('utime', line)):
                  tokens = line.split()
                  time = float(tokens[2])
                  if(cmin == 0):
                      cmin = time
                  elif(time < cmin):
                      cmin = time                  
                  if(cmax == 0):
                      cmax = time
                  elif(time > cmax):
                      cmax = time
                  cav = cav + time
                  ccount = ccount + 1
              elif re.search('Deleting', line):
                   delete_count = delete_count + 1
                   ccount = ccount
                   cav = cav / ccount

                   if(mpiio):
                       if(striping == -1):
                           mpi_max_stripemin[mpi_max_stripecount] = cmin
                           mpi_max_stripemax[mpi_max_stripecount] = cmax
                           mpi_max_stripeav[mpi_max_stripecount] = cav
                           mpi_max_stripedate[mpi_max_stripecount] = runtime
                           mpi_max_stripecount = mpi_max_stripecount + 1
                       else:
                           mpi_4_stripemin[mpi_4_stripecount] = cmin
                           mpi_4_stripemax[mpi_4_stripecount] = cmax
                           mpi_4_stripeav[mpi_4_stripecount] = cav
                           mpi_4_stripedate[mpi_4_stripecount] = runtime
                           mpi_4_stripecount = mpi_4_stripecount + 1
                           mpiio = False                
                   elif(hdf5):
                       if(striping == -1):
                           hdf5_max_stripemin[hdf5_max_stripecount] = cmin
                           hdf5_max_stripemax[hdf5_max_stripecount] = cmax
                           hdf5_max_stripeav[hdf5_max_stripecount] = cav
                           hdf5_max_stripedate[hdf5_max_stripecount] = runtime
                           hdf5_max_stripecount = hdf5_max_stripecount + 1
                       else:
                           hdf5_4_stripemin[hdf5_4_stripecount] = cmin
                           hdf5_4_stripemax[hdf5_4_stripecount] = cmax
                           hdf5_4_stripeav[hdf5_4_stripecount] = cav
                           hdf5_4_stripedate[hdf5_4_stripecount] = runtime
                           hdf5_4_stripecount = hdf5_4_stripecount + 1
                           hdf5 = False
                   elif(netcdf):
                       if(striping == -1):
                           netcdf_max_stripemin[netcdf_max_stripecount] = cmin
                           netcdf_max_stripemax[netcdf_max_stripecount] = cmax
                           netcdf_max_stripeav[netcdf_max_stripecount] = cav
                           netcdf_max_stripedate[netcdf_max_stripecount] = runtime
                           netcdf_max_stripecount = netcdf_max_stripecount + 1
                       else:
                           netcdf_4_stripemin[netcdf_4_stripecount] = cmin
                           netcdf_4_stripemax[netcdf_4_stripecount] = cmax
                           netcdf_4_stripeav[netcdf_4_stripecount] = cav
                           netcdf_4_stripedate[netcdf_4_stripecount] = runtime
                           netcdf_4_stripecount = netcdf_4_stripecount + 1
                           netcdf = False
                   if(delete_count == 2):
                       header = True
                   elif(delete_count == 1):
                       cmin = 0
                       cmax = 0
                       cav = 0
                       ccount = 0

       if(mpiio != False):
           if(ccount != 0):
               cav = cav / ccount
               if(striping == -1):
                   mpi_max_stripemin[mpi_max_stripecount] = cmin
                   mpi_max_stripemax[mpi_max_stripecount] = cmax
                   mpi_max_stripeav[mpi_max_stripecount] = cav
                   mpi_max_stripedate[mpi_max_stripecount] = runtime
                   mpi_max_stripecount = mpi_max_stripecount + 1
               else:
                   mpi_4_stripemin[mpi_4_stripecount] = cmin
                   mpi_4_stripemax[mpi_4_stripecount] = cmax
                   mpi_4_stripeav[mpi_4_stripecount] = cav
                   mpi_4_stripedate[mpi_4_stripecount] = runtime
                   mpi_4_stripecount = mpi_4_stripecount + 1
           mpiio = False                
       elif(hdf5 != False):
           if(ccount != 0):
               cav = cav / ccount
               if(striping == -1):
                   hdf5_max_stripemin[hdf5_max_stripecount] = cmin
                   hdf5_max_stripemax[hdf5_max_stripecount] = cmax
                   hdf5_max_stripeav[hdf5_max_stripecount] = cav
                   hdf5_max_stripedate[hdf5_max_stripecount] = runtime
                   hdf5_max_stripecount = hdf5_max_stripecount + 1
               else:
                   hdf5_4_stripemin[hdf5_4_stripecount] = cmin
                   hdf5_4_stripemax[hdf5_4_stripecount] = cmax
                   hdf5_4_stripeav[hdf5_4_stripecount] = cav
                   hdf5_4_stripedate[hdf5_4_stripecount] = runtime
                   hdf5_4_stripecount = hdf5_4_stripecount + 1
           hdf5 = False
       elif(netcdf != False):
           if(ccount != 0):
               cav = cav / ccount
               if(striping == -1):
                   netcdf_max_stripemin[netcdf_max_stripecount] = cmin
                   netcdf_max_stripemax[netcdf_max_stripecount] = cmax
                   netcdf_max_stripeav[netcdf_max_stripecount] = cav
                   netcdf_max_stripedate[netcdf_max_stripecount] = runtime
                   netcdf_max_stripecount = netcdf_max_stripecount + 1
               else:
                   netcdf_4_stripemin[netcdf_4_stripecount] = cmin
                   netcdf_4_stripemax[netcdf_4_stripecount] = cmax
                   netcdf_4_stripeav[netcdf_4_stripecount] = cav
                   netcdf_4_stripedate[netcdf_4_stripecount] = runtime
                   netcdf_4_stripecount = netcdf_4_stripecount + 1
           netcdf = False                 
               
           
       infile.close()

    plot_data(mpi_max_stripedate, mpi_max_stripemin, mpi_max_stripemax, mpi_max_stripeav, mpi_max_stripecount, 'mpiio_max_stripe')
    plot_data(mpi_max_stripedate, mpi_max_stripemin, mpi_max_stripemax, mpi_max_stripeav, mpi_max_stripecount, 'mpiio_4_stripe')
    plot_data(hdf5_max_stripedate, hdf5_max_stripemin, hdf5_max_stripemax, hdf5_max_stripeav, hdf5_max_stripecount, 'hdf5_max_stripe')
    plot_data(hdf5_max_stripedate, hdf5_max_stripemin, hdf5_max_stripemax, hdf5_max_stripeav, hdf5_max_stripecount, 'hdf5_max_stripe')
    plot_data(netcdf_max_stripedate, netcdf_max_stripemin, netcdf_max_stripemax, netcdf_max_stripeav, netcdf_max_stripecount, 'netcdf_max_stripe')
    plot_data(netcdf_max_stripedate, netcdf_max_stripemin, netcdf_max_stripemax, netcdf_max_stripeav, netcdf_max_stripecount, 'netcdf_max_stripe')

    sys.exit(0)

def plot_data(date, min, max, av, ccount, filename):
    outfile = open(filename, 'w')
    i = 0
    while i < ccount:
        outfile.write("%s %s %s %s\n" % (date[i],min[i],max[i],av[i]))
        i = i + 1
    plt.plot(date[0:ccount],max[0:ccount],c='r',ls='--',label='max')
    plt.plot(date[0:ccount],min[0:ccount],c='g',ls='--',label='min')
    plt.plot(date[0:ccount],av[0:ccount],c='b',marker='s',label='average');
    plt.xlabel('Date')
    plt.ylabel('Runtime (seconds)')
    legend = plt.legend(loc='upper left', shadow=True)
    plt.savefig(filename+'.png')

    x1,x2,y1,y2 = plt.axis()
    plt.axis((x1,x2,0,20))
    plt.savefig(filename+'_zoom.png')

    current_date = date[0]
    end_date = date[ccount-1]
    while current_date < end_date:
        next_month = add_months(current_date,1)
        plt.xticks(rotation=70)
        plt.axis((np.float64(date2num(current_date)),np.float64(date2num(next_month)),y1,y2))
        plt.savefig(filename+current_date.strftime("%B")+current_date.strftime("%Y")+'.png')
        current_date = next_month
    plt.close()

        
def add_months(sourcedate,months):
    new_date = dt.date(sourcedate.year + (sourcedate.month/12),(sourcedate.month%12) + 1,1)
    return datetime.strptime(new_date.strftime('%Y%m%d'), '%Y%m%d')
    
def get_filelist(dir, stem, maxsize):
    """
    Get list of date files in the specified directory
    """

    files = []
    if os.path.exists(dir):
        files = glob(os.path.join(dir, stem + '*' ))
        files.sort()
        if(len(files) > maxsize):
            sys.stderr.write("Need to increase the maxsize (maximum number of files this program can process)")
            sys.exit()
    else:
        sys.stderr.write("Directory does not exist: {1}".format(dir))
        sys.exit(1)

    return files

def get_date_from_string(datestring):
    y = datestring[0:4]
    m = datestring[4:6]
    d = datestring[6:8]
    return strptime(datestring, "%Y%m%d%H%M%S")

if __name__ == "__main__":
    main(sys.argv[1:])
