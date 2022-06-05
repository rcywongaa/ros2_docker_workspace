DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

source "${DIR}"/config.sh
source /opt/ros/"${ROS_DISTRO}"/setup.bash
source /${WORKSPACE_NAME}/install/setup.bash
alias run="source /${WORKSPACE_NAME}/install/setup.bash && ros2 launch dual_arm_husky_description main_launch.py"
