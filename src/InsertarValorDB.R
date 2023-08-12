  getwd()
  setwd( "/home/matbox/PUCV/est741_2019/caso02" )
  source( "VarEnv.R" )
  setwd( file.path( srcdir , "src/Extern" ) )
  setwd( "/home/matbox/mis.sources/contrib-src/R-3.6.1/src/main" )
  ?base::dyn.load
  base::dyn.load( "serialize.so" )
  base::dyn.load( "platform.so" )
  base::dyn.load( "util.so" )

  ### crear objeto de prueba y grabar en rdb/rdx
  env_prueba <- new.env()
  x_prueba <- rnorm( 10 , 0 , 1 )
  x_prueba
  assign( "x_prueba" , x_prueba , envir = env_prueba )
  tools:::makeLazyLoadDB( env_prueba , "rdb/env_prueba" )
  rm(x_prueba)
  rm(env_prueba)

  ### crear un segundo objeto de prueba para insertar en rdb/rdx
  env_prueba <- new.env()
  y_prueba <- rnorm( 10 , 0 , 1 )
  y_prueba

  ### cargar objeto compartido de libreria tools, aqui no esta la
  ### funcion
  base::dyn.load( "/usr/local/R/lib/R/library/tools/libs/tools.so" )

  ### la funcion no esta aqui tampoco
  base::dyn.load( "/usr/local/R/lib/R/lib/libRlapack.so" )
  base::dyn.load( "/usr/local/R/lib/R/lib/libRblas.so" )
  base::dyn.load( "/usr/local/R/lib/R/lib/libR.so" )

  ### la funcion externa esta aqui, pero no reconoce un simbolo
  ### known_to_be_utf8
  base::dyn.load( "/home/matbox/mis.sources/contrib-src/R-3.6.1/src/main/serialize.so" )

  .Call( "R_lazyLoadDBinsertValue" , "rdb/env_prueba" , y_prueba )

  system("ls -ltr")
  .Call( "R_lazyLoadDBinsertValue" , test01 , "test" )
  setwd( file.path( srcdir , "src" ) )
  sessionInfo()
  #??Makevars
  #Rcpp:::CxxFlags()
  #Rcpp:::LdFlags()
  #base::grepl( "R_INCLUDE_DIR" , base::Sys.getenv() )
