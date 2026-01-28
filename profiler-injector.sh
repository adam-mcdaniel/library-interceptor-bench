#!/bin/bash

# Define the path to your hook. 
# Using BASH_SOURCE makes it robust relative to where this file is saved.
__SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
__PROFILER_HOOK="$__SCRIPT_DIR/profiler-hook.sh"

echo "Hook script: $__PROFILER_HOOK"

# Define a function named 'srun' to intercept the real command
function srun() {
    # 1. Safety Check: If the hook doesn't exist, run srun normally
    if [ ! -f "$__PROFILER_HOOK" ]; then
        echo "Hook not found!"
        # 'command srun' bypasses the function and uses the real binary
        command srun "$@"
        return $?
    fi

    # 2. Parsing Logic
    # We need to separate srun flags (like -N 1) from the executable (./lsms)
    # so we can sandwich the hook in between.
    
    local srun_opts=()
    local found_exe=false

    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            # Flags that take an argument (shift 2)
            -n|-N|-A|-t|-p|-c|-w|-o|-e|-J|--mem|--job-name|--output|--error|--time|--partition|--account)
                srun_opts+=("$1" "$2")
                shift 2
                ;;
            # Flags that stick together (e.g. -N1) or simple flags (-v)
            -*)
                srun_opts+=("$1")
                shift
                ;;
            # The first argument that doesn't start with '-' is your executable
            *)
                echo "[Profiler Injector] Inserting hook before: $1"
                
                # Run the REAL srun: [SLURM_FLAGS] [HOOK] [EXECUTABLE] [ARGS]
                echo "Command: " srun "${srun_opts[@]}" "$__PROFILER_HOOK" "$@" 
                command srun "${srun_opts[@]}" "$__PROFILER_HOOK" "$@"
                found_exe=true
                break
                ;;
        esac
        echo "Processed argument $key"
    done

    # Fallback: If no executable was found (e.g. user ran 'srun --help'), just run it as is.
    if [ "$found_exe" = false ]; then
        echo "Failed to wrap with hook: " srun "${srun_opts[@]}" "$__PROFILER_HOOK" "$@" 
        command srun "${srun_opts[@]}"
    fi
}