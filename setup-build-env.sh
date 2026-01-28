module purge
module reset

export ROCM_VERSION=6.4.1
export ROCM_PATH=/opt/rocm-$ROCM_VERSION

module load \
    PrgEnv-cray \
    amd/6.4.1 \
    rocm/6.4.1 \
    craype-accel-amd-gfx90a \
    cray-hdf5 \
    cray-mpich \
    openblas \
    cray-fftw \
    PrgEnv-amd/8.6.0

export CC=hipcc
export CXX=hipcc

export MPICH_GPU_SUPPORT_ENABLED=1
export CRAY_MPICH_PREFIX=$(dirname $(dirname $(which mpicc)))

echo "------------ BUILD CONFIGURATION ------------"
echo "ROCM_VERSION: $ROCM_VERSION"
echo "ROCM_PATH: $ROCM_PATH"
echo "CRAY_MPICH_PREFIX: $CRAY_MPICH_PREFIX"

module list
echo "------------ END BUILD CONFIGURATION ------------"
