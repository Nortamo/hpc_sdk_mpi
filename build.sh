
set -e
source base_env.sh
bash build_pciaccess.sh  
bash build_hwloc.sh 
bash build_ucx.sh 
