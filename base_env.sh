#!/bin/bash

export _HPC_SDK_ROOT=/appl/opt/nvidia-hpc/20.7
export _STACK_ROOT=/scratch/project_2001659/nortamoh/HPC_SDK_MPI
export _CUDA_VERSION=10.2
export _BUILD_ROOT=/local_scratch/nortamoh/hpc_sdk
export _MODULE_ROOT=$_STACK_ROOT/modules
export _HCOLL_ROOT=/appl/opt/hcoll/4.5.3043

# NVC fails to build ucx, due to a strange ABI check in libibverbs
# So we build ucx using gcc
export _GCC_VERSION=7.4.0

# System default module trees
export _H_MODULE_T=/appl/spack/modulefiles/linux-rhel7-x86_64/Core
export _F_MODULE_T=/appl/modulefiles

mkdir -p $_STACK_ROOT
cp -r modules $_STACK_ROOT

module purge
module unuse $_F_MODULE_T
module unuse $_H_MODULE_T
module use $_MODULE_ROOT/Core


MODULE_TARGET=$_MODULE_ROOT/Core/nvhpc-nompi/20.7


sed "s@_HPC_SDK_ROOT@$_HPC_SDK_ROOT@g" $MODULE_TARGET.template > $MODULE_TARGET
sed -i "s@_MODULE_ROOT@$_MODULE_ROOT@g" $MODULE_TARGET
sed -i "s@_CUDA_VERSION@$_CUDA_VERSION@g" $MODULE_TARGET
rm $MODULE_TARGET.template


MODULE_TARGET=$_MODULE_ROOT/nvc/openmpi/4.0.3.lua


sed "s@_HPC_SDK_ROOT@$_HPC_SDK_ROOT@g" $MODULE_TARGET.template > $MODULE_TARGET
sed -i "s@_MODULE_ROOT@$_MODULE_ROOT@g" $MODULE_TARGET
sed -i "s@_CUDA_VERSION@$_CUDA_VERSION@g" $MODULE_TARGET
sed -i "s@_STACK_ROOT@$_STACK_ROOT@g" $MODULE_TARGET
rm $MODULE_TARGET.template


module load  nvhpc-nompi

