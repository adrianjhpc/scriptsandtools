#!/usr/bin/env python

import sys
import json
import itertools
import numpy as np
import subprocess
import argparse
import math



parser = argparse.ArgumentParser()

parser.add_argument('exe', help='1d model executable')
parser.add_argument('data', help='1d sim data input file')
parser.add_argument('param_json', help='JSON file containing parameter sweep info')
parser.add_argument('nsims', type=int, help='Number of simulations per subjob')
parser.add_argument('subjob', type=int, help='PBS subjob index, assuming first starts at 1')


args = parser.parse_args()

def get_values(options, parameter):
    min = options[parameter]['min']
    max = options[parameter]['max']
    step = options[parameter]['step']
    return np.arange(min, max, step)

with open(args.param_json, 'r') as f:
    options = json.load(f)

param = {}

for param_name, param_dict in options.items():
    start = float(param_dict['min'])
    stop = float(param_dict['max'])
    step = float(param_dict['step'])
    stop += step/100.0
    param[param_name] = np.arange(start, stop, step)
   
  

param_names = ['conductivity', 'tau_in', 'tau_out', 'tau_open', 'tau_close']
param_ranges = [param[name] for name in param_names]

# I put 0.85 because i saw that APD max evaluated in this way
# was too big in some cases (e.g. up to BCL=500)
# may be because MS hypothesis are not respected
# when dealing with physical parameters

#APDmax=0.85*(options['tau_close']['max'])*math.log(0.25*(options['tau_out']['max'])/(options['tau_in']['min']) )

APDmax=380.0

param_sweep = list(enumerate(itertools.product(*param_ranges)))

start = (args.subjob-1)* args.nsims # Assuming first subjob index is 1
end = start + args.nsims

if(end>(len(param_sweep))):
  end=(len(param_sweep)	)


chunk = param_sweep[start:end]

