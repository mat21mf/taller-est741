
# ###
# ### kmodes ==> kproto
# ###
# ### - archivos incluidos

# ### cargar variables entorno
# source src/Kproto/VarEnv.sh

# ### renombrar rutinas kproto
# if [[ -f src/ClusterKproto.R          ]] ; then mv src/ClusterKproto.R             src/KprotoCluster.R    ; fi
# if [[ -f src/ClusterKproto.sh         ]] ; then mv src/ClusterKproto.sh            src/KprotoCluster.sh   ; fi
# if [[ -f src/ClusterKproto_Load.R   ]] ; then mv src/ClusterKproto_Load.R      src/KprotoLoad.R     ; fi
# if [[ -f src/ClusterKprotoParallel.sh ]] ; then mv src/ClusterKprotoParallel.sh    src/KprotoParallel.sh  ; fi

  ### replicar rutinas kproto
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0001.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0001.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0001.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0002.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0002.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0002.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0003.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0003.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0003.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0004.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0004.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0004.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0005.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0005.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0005.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0006.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0006.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0006.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0007.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0007.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0007.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0008.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0008.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0008.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0009.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0009.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0009.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0010.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0010.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0010.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0011.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0011.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0011.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0012.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0012.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0012.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0013.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0013.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0013.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0014.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0014.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0014.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0015.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0015.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0015.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0016.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0016.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0016.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0017.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0017.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0017.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0018.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0018.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0018.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0019.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0019.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0019.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0020.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0020.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0020.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0021.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0021.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0021.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0022.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0022.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0022.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0023.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0023.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0023.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0024.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0024.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0024.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0025.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0025.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0025.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0026.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0026.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0026.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0027.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0027.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0027.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0028.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0028.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0028.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0029.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0029.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0029.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0030.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0030.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0030.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0031.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0031.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0031.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0032.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0032.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0032.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0033.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0033.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0033.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0034.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0034.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0034.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0035.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0035.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0035.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0036.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0036.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0036.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0037.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0037.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0037.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0038.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0038.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0038.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0039.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0039.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0039.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0040.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0040.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0040.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0041.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0041.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0041.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0042.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0042.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0042.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0043.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0043.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0043.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0044.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0044.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0044.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0045.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0045.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0045.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0046.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0046.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0046.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0047.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0047.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0047.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0048.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0048.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0048.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0049.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0049.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0049.R
  scp src/KprotoCluster.R src/Kproto/KprotoCluster_seed0050.R ; scp src/KprotoCluster.sh src/Kproto/KprotoCluster_seed0050.sh ; scp src/KprotoLoad.R src/Kproto/KprotoLoad_seed0050.R

  ### funcion editar rutinas replicadas
  function EditarRutinasKproto ()
  {
    strnum=$(printf %04d $((${2}-0)))
    #echo ${strnum}
    bash -c "sed -r -i 's/semillas\[1,1\]/semillas["${2}",1]/' "${1}""
    bash -c "sed -r -i 's/seed0001/seed"${strnum}"/g'          "${1}""
    ### no ejecutar todas las corridas , comentar algunas corridas
    sed -r -i '10,$s/^  /# /' "${1}"
  }
  export -f EditarRutinasKproto

  ### aplicar funcion editar
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0001.R 1  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0001.sh 1  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0001.R 1
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0002.R 2  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0002.sh 2  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0002.R 2
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0003.R 3  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0003.sh 3  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0003.R 3
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0004.R 4  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0004.sh 4  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0004.R 4
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0005.R 5  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0005.sh 5  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0005.R 5
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0006.R 6  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0006.sh 6  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0006.R 6
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0007.R 7  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0007.sh 7  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0007.R 7
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0008.R 8  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0008.sh 8  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0008.R 8
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0009.R 9  ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0009.sh 9  ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0009.R 9
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0010.R 10 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0010.sh 10 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0010.R 10
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0011.R 11 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0011.sh 11 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0011.R 11
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0012.R 12 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0012.sh 12 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0012.R 12
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0013.R 13 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0013.sh 13 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0013.R 13
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0014.R 14 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0014.sh 14 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0014.R 14
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0015.R 15 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0015.sh 15 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0015.R 15
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0016.R 16 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0016.sh 16 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0016.R 16
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0017.R 17 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0017.sh 17 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0017.R 17
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0018.R 18 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0018.sh 18 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0018.R 18
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0019.R 19 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0019.sh 19 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0019.R 19
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0020.R 20 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0020.sh 20 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0020.R 20
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0021.R 21 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0021.sh 21 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0021.R 21
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0022.R 22 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0022.sh 22 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0022.R 22
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0023.R 23 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0023.sh 23 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0023.R 23
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0024.R 24 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0024.sh 24 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0024.R 24
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0025.R 25 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0025.sh 25 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0025.R 25
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0026.R 26 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0026.sh 26 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0026.R 26
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0027.R 27 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0027.sh 27 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0027.R 27
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0028.R 28 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0028.sh 28 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0028.R 28
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0029.R 29 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0029.sh 29 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0029.R 29
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0030.R 30 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0030.sh 30 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0030.R 30
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0031.R 31 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0031.sh 31 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0031.R 31
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0032.R 32 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0032.sh 32 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0032.R 32
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0033.R 33 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0033.sh 33 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0033.R 33
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0034.R 34 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0034.sh 34 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0034.R 34
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0035.R 35 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0035.sh 35 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0035.R 35
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0036.R 36 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0036.sh 36 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0036.R 36
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0037.R 37 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0037.sh 37 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0037.R 37
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0038.R 38 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0038.sh 38 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0038.R 38
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0039.R 39 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0039.sh 39 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0039.R 39
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0040.R 40 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0040.sh 40 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0040.R 40
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0041.R 41 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0041.sh 41 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0041.R 41
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0042.R 42 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0042.sh 42 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0042.R 42
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0043.R 43 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0043.sh 43 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0043.R 43
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0044.R 44 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0044.sh 44 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0044.R 44
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0045.R 45 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0045.sh 45 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0045.R 45
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0046.R 46 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0046.sh 46 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0046.R 46
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0047.R 47 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0047.sh 47 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0047.R 47
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0048.R 48 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0048.sh 48 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0048.R 48
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0049.R 49 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0049.sh 49 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0049.R 49
  EditarRutinasKproto src/Kproto/KprotoCluster_seed0050.R 50 ; EditarRutinasKproto src/Kproto/KprotoCluster_seed0050.sh 50 ; EditarRutinasKproto src/Kproto/KprotoLoad_seed0050.R 50
