#!/bin/bash
#SBATCH -N 1
#SBATCH -C cpu
#SBATCH -q shared
#SBATCH -J US1
#SBATCH -t 48:00:00
#SBATCH --account=m1864
#SBATCH --output="/pscratch/sd/s/seokjin/logs/log_%j.log"
#SBATCH --ntasks-per-node=128
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1

module load gcc
module load openmpi

njobs=16
parallel -j $njobs < ../commands/commands1.lst
