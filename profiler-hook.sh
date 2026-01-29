#!/bin/bash
echo "RUNNING PROFILER HOOK."

__HOOK_SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

exec $__HOOK_SCRIPT_DIR/library-interceptors/perf-libs-tools/tools/perf-libs-run --sync-gpu --detailed-sim --detailed-sim-file ./adam_sim_markers.txt --probe "$@"