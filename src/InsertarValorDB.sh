  ### Primero compilar el proyecto R completo con lo cual
  ### se generan objetos ejecutables.
  ### Copiar el objeto ejecutable al directorio actual y
  ### cargar sus funciones con dyn.load()

  ### variables entorno
  declare -gx srcdir="$HOME/PUCV/est741_2019/caso02"

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/main/serialize.c \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/serialize.c

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/main/serialize.d \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/serialize.d

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/main/serialize.o \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/serialize.o

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/main/serialize.so \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/serialize.so

  ###
  ### Nueva compilacion ==> respaldar headers
  ###

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Defn.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/Defn.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Complex.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Complex.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Print.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Print.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Print.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Print.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rinternals.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rinternals.h
  sed -r -i 's/<(R_ext\/Print.h)>/\"\1\"/' ${srcdir}/src/Extern/Rinternals.h
  sed -r -i 's/R_ext\/Print.h/Print.h/' ${srcdir}/src/Extern/Rinternals.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Rdynload.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Rdynload.h

  sed -r -i 's/<(R_ext\/Rdynload.h)>/\"\1\"/' ${srcdir}/src/Extern/Rinternals.h
 #sed -r -i 's/R_ext\/Rdynload.h/Rdynload.h/' ${srcdir}/src/Extern/Rinternals.h

  sed -r -i 's/<(R_ext\/libextern.h)>/\"\1\"/' ${srcdir}/src/Extern/Rinternals.h
 #sed -r -i 's/R_ext\/libextern.h/libextern.h/' ${srcdir}/src/Extern/Rinternals.h

  sed -r -i 's/<(R_ext\/Boolean.h)>/\"\1\"/' ${srcdir}/src/Extern/R_ext/Rdynload.h
  sed -r -i 's/R_ext\/Boolean.h/Boolean.h/' ${srcdir}/src/Extern/R_ext/Rdynload.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/PrtUtil.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/PrtUtil.h
  sed -r -i 's/<(R_ext\/PrtUtil.h)>/\"\1\"/' ${srcdir}/src/Extern/Print.h
  sed -r -i 's/<(R_ext\/Print.h)>/\"\1\"/' ${srcdir}/src/Extern/Print.h

  sed -r -i 's/<(Rinternals.h)>/\"\.\.\/\1\"/' ${srcdir}/src/Extern/R_ext/PrtUtil.h
  sed -r -i 's/<R_ext\/Complex.h>/\"Complex.h\"/' ${srcdir}/src/Extern/R_ext/PrtUtil.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rconfig.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rconfig.h

  sed -r -i 's/<(Rconfig.h)>/\"\1\"/' ${srcdir}/src/Extern/Rinternals.h
  sed -r -i 's/<(Rconfig.h)>/\"\.\.\/\1\"/' ${srcdir}/src/Extern/R_ext/RS.h
  sed -r -i 's/<(R_ext\/Error.h)>/\"\1\"/' ${srcdir}/src/Extern/R_ext/RS.h
  sed -r -i 's/R_ext\/Error.h/Error.h/' ${srcdir}/src/Extern/R_ext/RS.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rconnections.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rconnections.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rinlinedfuns.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rinlinedfuns.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Errormsg.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Errormsg.h

  sed -r -i 's/<(R_ext\/libextern.h)>/\"\1\"/' ${srcdir}/src/Extern/Defn.h
 #sed -r -i 's/R_ext\/libextern.h/libextern.h/' ${srcdir}/src/Extern/Defn.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rmath.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rmath.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Fileio.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Fileio.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/Rversion.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/Rversion.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Riconv.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Riconv.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/RS.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/RS.h

  rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Connections.h \
    $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Connections.h

  sed -r -i 's/<(Rconnections.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c
  sed -r -i 's/<(R_ext\/RS.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c
  sed -r -i 's/<(R_ext\/Riconv.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c
  sed -r -i 's/<(Rversion.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c
  sed -r -i 's/<(Fileio.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c
  sed -r -i 's/<(Rmath.h)>/\"\1\"/' ${srcdir}/src/Extern/serialize.c

  sed -r -i 's/<(R_ext\/Boolean.h)>/\"\1\"/' ${srcdir}/src/Extern/Rmath.h

  sed -r -i 's/<(R_ext\/Connections.h)>/\"\1\"/' ${srcdir}/src/Extern/Rconnections.h

  sed -r -i 's/<(Boolean.h)>/\"\.\.\/\1\"/' ${srcdir}/src/Extern/R_ext/Connections.h
  sed -r -i 's/<R_ext\/Boolean.h>/\"Boolean.h\"/' ${srcdir}/src/Extern/R_ext/Connections.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Arith.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Arith.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/libextern.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/libextern.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Boolean.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Boolean.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Error.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Error.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Memory.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Memory.h

# rsync -rltvz -O --update $HOME/mis.sources/contrib-src/R-3.6.1/src/include/R_ext/Utils.h \
#   $HOME/PUCV/est741_2019/caso02/src/Extern/R_ext/Utils.h
# sed -r -i 's/<(R_ext\/Boolean.h)>/\"\1\"/' ${srcdir}/src/Extern/R_ext/Utils.h
# sed -r -i 's/R_ext\/Boolean.h/Boolean.h/' ${srcdir}/src/Extern/R_ext/Utils.h
# sed -r -i 's/<(R_ext\/Complex.h)>/\"\1\"/' ${srcdir}/src/Extern/R_ext/Utils.h
# sed -r -i 's/R_ext\/Complex.h/Complex.h/' ${srcdir}/src/Extern/R_ext/Utils.h


  ### En vez de copiar cada directiva en un archivo de usuario
  ### colocar todas las directivas en un directorio del sistema
  ### root de R donde se encuentren las demás directivas que R
  ### instala por defecto. Ahora contendrá también las que R
  ### no instala por defecto.

  ### Descargar R mas reciente , debe ser el mismo del sistema
  ### R-3.6.1.tar.gz
  ###

# tar -zxvf $HOME/mis.sources/contrib-tar/R-3.6.1.tar.gz \
#   -C $HOME/mis.sources/contrib-src/

  ### procedemos con la compilacion

 #cd $HOME/mis.sources/contrib-src/R-3.6.1/src/main
  cd $HOME/PUCV/est741_2019/caso02/src/Extern
  R CMD SHLIB serialize.c
 #ccache gcc -g -O2 -Wall -c serialize.c
  # -L/home/matbox/mis.sources/contrib-src/R-3.6.1/src/main \
  # -I/home/matbox/mis.sources/contrib-src/R-3.6.1/src/include \
  # -I/home/matbox/mis.sources/contrib-src/R-3.6.1/src/include/R_ext
  cd -

# cd $HOME/PUCV/est741_2019/caso02/src/Extern
# ccache gcc -I"/usr/include" -I"/usr/share/R/include" -I"/usr/share/R/include/R_ext" -DNDEBUG     -fpic  -g -O2 -fdebug-prefix-map=/home/jranke/git/r-backports/stretch/r-base-3.6.1=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c serialize_copy.c -o serialize_copy.o
# cd -

# cd $HOME/PUCV/est741_2019/caso02/src/Extern
# gcc -g -Wall -I/usr/include -I/usr/share/R/include -c serialize_copy.c
# cd -
