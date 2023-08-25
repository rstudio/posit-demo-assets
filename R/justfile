r_version := "4.2.3"

default:
    just --list

# set up virtual environment in working directory
bootstrap:
    if [ ! -d {{invocation_directory()}}/renv/ ]; then rig run -r {{r_version}} -e "renv::init(project = '{{invocation_directory()}}', repos = 'https://p3m.dev/cran/latest')"; fi

restore:
    if [ -f {{invocation_directory()}}/renv.lock ]; then rig run -r {{r_version}} -e "renv::restore(repos = 'https://p3m.dev/cran/latest')"; fi

# remove renv from working directory
clean:
    rm -rf {{invocation_directory()}}/renv {{invocation_directory()}}/renv.lock {{invocation_directory()}}/.Rprofile

# deploy manifest in current directory to target server
deploy connect:
    rsconnect deploy manifest {{invocation_directory()}}/manifest.json -n {{connect}}
