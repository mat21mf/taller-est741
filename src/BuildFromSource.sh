  declare -gx my_R_path="$HOME/mis.sources/contrib-src/R-3.6.1"
  declare -gx srcdir="$HOME/PUCV/est741_2019/caso02"

# setenv CFLAGS -O2
# setenv FFLAGS -O2

  cd $my_R_path
  if [[ ! -d build ]] ; then mkdir build ; fi

# ./configure \
#  --prefix=/usr/local/R \
#  --with-readline \
#  --enable-R-shlib \
#  --enable-BLAS-shlib \
#  --with-system-zlib \
#  --with-system-bzlib \
#  --with-system-pcre \
#  2>&1 | tee ${srcdir}/src/configure_log

# ### etc/Makeconf.  Generated from Makeconf.in by configure.
# ###
# ### ${R_HOME}/etc/Makeconf
# ###
# ### R was configured using the following call
# ### (not including env. vars and site configuration)
# ./configure  '--prefix=/usr' '--with-cairo' '--with-jpeglib' '--with-readline' '--with-tcltk' '--with-system-bzlib' '--with-system-pcre' '--with-system-zlib' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--datadir=/usr/share/R/share' '--includedir=/usr/share/R/include' '--with-blas' '--with-lapack' '--enable-R-profiling' '--enable-R-shlib' '--enable-memory-profiling' '--without-recommended-packages' '--build' 'x86_64-linux-gnu' 'build_alias=x86_64-linux-gnu' 'R_PRINTCMD=/usr/bin/lpr' 'R_PAPERSIZE=letter' 'TAR=/bin/tar' 'R_BROWSER=xdg-open' 'LIBnn=lib' 'JAVA_HOME=/usr/lib/jvm/default-java' 'R_SHELL=/bin/bash' 'CC=gcc -std=gnu99' 'CFLAGS=-g -O2 -fdebug-prefix-map=/home/jranke/git/r-backports/stretch/r-base-3.6.1=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g' 'LDFLAGS=-Wl,-z,relro' 'CPPFLAGS=' 'FC=gfortran' 'FCFLAGS=-g -O2 -fdebug-prefix-map=/home/jranke/git/r-backports/stretch/r-base-3.6.1=. -fstack-protector-strong' 'CXX=g++' 'CXXFLAGS=-g -O2 -fdebug-prefix-map=/home/jranke/git/r-backports/stretch/r-base-3.6.1=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g' \
#  2>&1 | tee ${srcdir}/src/configure_log

# make -j4 \
#  2>&1 | tee ${srcdir}/src/makefile_log

 #sudo make install

  sudo unlink /usr/local/bin/R
  sudo unlink /usr/local/bin/Rscript

  sudo ln -s /usr/local/R/bin/R       /usr/local/bin/R
  sudo ln -s /usr/local/R/bin/Rscript /usr/local/bin/Rscript

  sudo unlink /usr/local/lib/libR.so
  sudo unlink /usr/local/lib/libRblas.so
  sudo unlink /usr/local/lib/libRlapack.so

  sudo ln -s /usr/local/R/lib/R/lib/libR.so       /usr/local/lib/libR.so
  sudo ln -s /usr/local/R/lib/R/lib/libRblas.so   /usr/local/lib/libRblas.so
  sudo ln -s /usr/local/R/lib/R/lib/libRlapack.so /usr/local/lib/libRlapack.so
