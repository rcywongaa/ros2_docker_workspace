# Using the template
1. Install and set up [`rocker`](https://github.com/osrf/rocker)
1. Update `bin/config.sh` to suit your needs
1. Edit `bin/extra_bashrc.sh` if necessary (e.g. custom `source`/`export`/`alias`, etc.)
   - This file will be sourced in the `.bashrc` of the container
1. Modify `docker/base.dockerfile` if necessary
1. Run `bin/build_base.sh` to build the image
   - This may take up to 15 mins.  I have yet to find a way to optimize this...
1. Run `bin/start_container.sh` to start the container (by default named `${IMAGE_NAME}`)
   - The `bash` shell entered defines the lifetime of the container.  Exiting the shell automatically stops the container.
   - This entire repository will be mounted under `/${WORKSPACE_NAME}`.
   - *Be sure to double check that modification from within the container are visible in the host* , e.g. `touch` a new file in `/${WORKSPACE_NAME}` in the container and check if the file appears locally.
1. In vscode, run command "Remote-Container: Attach to Running Container..." and select container
1. Run `bin/enter_container.sh` to attach additional shells to the container
1. (optional) Use `bin/compile.sh` to compile the code in the container


