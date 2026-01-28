#!/bin/bash
echo "RUNNING PROFILER HOOK."

exec /lustre/orion/csc688/world-shared/library-interceptors/perf-libs-tools/tools/perf-libs-run --sync-gpu --detailed-sim --detailed-sim-file $ROCHPL_ROOT/adam_sim_markers.txt --probe "$@"
