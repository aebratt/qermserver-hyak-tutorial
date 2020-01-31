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
#SBATCH --cpus-per-task=1
## Walltime (eight hours)
#SBATCH --time=0:01:00
# E-mail Notification, see man sbatch for options
 

##turn on e-mail notification

#SBATCH --mail-type=ALL

#SBATCH --mail-user=aebratt@uw.edu


## Memory per node
#SBATCH --mem=10G
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/stf/aebratt/qermserver-hyak-tutorial
module load  r_3.6.0
Rscript > Hyak_simple_output.txt 2>&1 /gscratch/stf/aebratt/qermserver-hyak-tutorial/Hyak_simple.R
