#!/bin/bash
## Job Name
#SBATCH --job-name=simple_test
## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=stf
## Resources
## Nodes
#SBATCH --nodes=1      
## Tasks per node (Slurm assumes you want to run 28 tasks, remove 2x # and adjust parameter if needed)
#SBATCH --ntasks-per-node=1
## Set number of cores per task to allow multithreading
#SBATCH --cpus-per-task=28
## Walltime (eight hours)
#SBATCH --time=8:00:00
# E-mail Notification, see man sbatch for options
 

##turn on e-mail notification

#SBATCH --mail-type=ALL

#SBATCH --mail-user=UWNETID@uw.edu


## Memory per node
#SBATCH --mem=100G
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/stf/UWNETID/qermserver-hyak-tutorial

/gscratch/stf/UWNETID/qermserver-hyak-tutorial/Hyak_simple.R