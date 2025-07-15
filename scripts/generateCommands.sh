#!/bin/bash

spring=5
centers=($(awk 'BEGIN { for( x=6.96; x>=2.0 - 1e-6; x-=0.16) printf "%.2f ", x}'))

rm ../commands/command.lst
for ((i=0; i<${#centers[@]};i++))
do
  center=${centers[$i]}
  if (( $(echo "$center >= 2.7" | bc -l ) )) && (( $(echo "$center <= 3.6" | bc -l ) ));
  then
    spring=10
    echo "srun --exclusive -n 8 ~/programs/lammps/build_colvars/lmp_mpi -in ../input/input.in -var INDEX $i -var SEED $RANDOM -var SPRING $spring -var CENTER $center  -log ../dumps/dump$i" >> ../commands/command.lst
  else
    spring=5
    echo "srun --exclusive -n 8 ~/programs/lammps/build_colvars/lmp_mpi -in ../input/input.in -var INDEX $i -var SEED $RANDOM -var SPRING $spring -var CENTER $center  -log ../dumps/dump$i" >> ../commands/command.lst
  fi

done



