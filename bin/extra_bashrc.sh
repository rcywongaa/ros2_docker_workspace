DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

source "${DIR}"/config.sh
source /opt/ros/"${ROS_DISTRO}"/setup.bash
source /${WORKSPACE_NAME}/install/setup.bash
alias run="source /${WORKSPACE_NAME}/install/setup.bash && ros2 launch dual_arm_husky_description main_launch.py"

# CycloneDDS
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Drake exports
export LD_LIBRARY_PATH="/opt/drake/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
export PATH="/opt/drake/bin${PATH:+:${PATH}}"
export PYTHONPATH="/opt/drake/lib/python$(python3 -c 'import sys; print("{0}.{1}".format(*sys.version_info))')/site-packages${PYTHONPATH:+:${PYTHONPATH}}"
