#!/bin/bash

#SBATCH --job-name=genInit
#SBATCH --account=co_noneq
#SBATCH --partition=savio3
#SBATCH --time=150:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --output="/global/scratch/users/seokjinmoon/logs/job_%j.out"

module load gcc
module load openmpi

spring=5
centers=($(awk 'BEGIN { for( x=6.96; x>=2.0 - 1e-6; x-=0.16) printf "%.2f ", x}'))

for ((i=0; i<${#centers[@]};i++))
do
  center=${centers[$i]}
  srun --exclusive -n 32 ~/programs/mylammps/build_nitrate/lmp_mpi -in ../input/inputInit.in -var INDEX $i -var SEED $RANDOM -var SPRING $spring -var CENTER $center  > ../dumps/dump$i
  sleep 5
  cp ../restarts/restartb$i ../Init/init$((i+1)).restart
done



