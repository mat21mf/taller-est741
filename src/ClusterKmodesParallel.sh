  ### variables entorno
  declare -gx srcdir="$HOME/PUCV/est741_2019/caso02"

# ###
# ### kmodes
# ###
# ### - archivos incluidos
# ClusterKmodes.R
# ClusterKmodes.sh
# ClusterKmodesParallel.sh

  parallel --bar --block -4 -j4 --pipepart -a ${srcdir}/src/ClusterKmodes.sh LANG=C bash
