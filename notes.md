# Debugging (e.g. MoveIt)
1. Add `prefix="gdbserver localhost:3000"` to the `move_group` node launch description
1. Recompile with `bin/compile.sh` if the launch file was changed
1. Launch `move_group`
1. Go to the "Run and Debug" tab in vscode
1. Under "RUN AND DEBUG" dropdown, select "Debug MoveIt"
1. Click the Play icon

# Custom rosdep
- <http://docs.ros.org/en/independent/api/rosdep/html/contributing_rules.html>
- <http://docs.ros.org/en/ros2_documentation/rolling/Tutorials/Intermediate/Rosdep.html>
- <https://github.com/ros-infrastructure/ros_buildfarm/blob/master/doc/custom_rosdistro.rst>

# Misc
- Do not `source /ros_entrypoint.sh` in your `.bashrc` because it contains `set -e` which causes bash to exit whenever a command fails
- [`.devcontainer.json`](https://aka.ms/vscode-remote/devcontainer.json) not used because we are starting the container with `rocker` via `bin/start_container.sh`
  - There doesn't seem to be a way for vscode to automatically attach to a container without also having vscode start the container
- [`rocker`](https://github.com/osrf/rocker) is used to avoid having to manually set up users, nvidia, graphics, etc.
