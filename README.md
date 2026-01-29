# library-interceptor-bench

This project contains a series of HPC applications, and a number of scripts for configuring, running, and hooking into these benchmarks to extract HPC library calls and GPU kernel activity during the applications' runtime.

## Files

```bash
library-interceptor-bench/
├─ li-hpg-mxp/            # The HPG-MxP benchmark
│   ├── compile.sh
│   └── run.sh
├── li-lsms/              # The LSMS benchmark
│   ├── compile.sh
│   └── run.sh
├── li-qmcpack/           # The QMCPACK benchmark
│   ├── compile.sh
│   └── run.sh
├── li-rochpl/            # The rocHPL benchmark
│   ├── compile.sh
│   └── run.sh
│
├── library-interceptors/ # The profiler
│
├── compile-all.sh        # Compile all benchmarks and interceptor
│
├── profiler-hook.sh      # A script that wraps an executable and
│                         # sets up the probe with `LD_PRELOAD`
│
├── profiler-injector.sh  # Injects the profiler-hook into all srun calls
│
├── run-all.sh            # Runs all the benchmarks with SLURM
│
├── setup-build-env.sh    # Sets up the build environment for the benchmarks
└── setup-run-env.sh.     # Sets up the runtime environment for the benchmarks
```

## Installing

```bash
git clone --recursive https://github.com/adam-mcdaniel/library-interceptor-bench
cd library-interceptor-bench
./compile-all.sh
```

> [!WARNING]
> **This configuration is for the Frontier supercomputer!**
> You will need to modify the `setup-build-env.sh` and `setup-run-env.sh` to compile and run
> all the benchmarks successfully on your machines. You may also have to change other paths
> in some of the hook scripts -- there are likely some path differences that will need to be adjusted
> for non-Cray-EX machines.

## Running

```
./run-all.sh
```

This should create a number of CSVs in each benchmark directory.
