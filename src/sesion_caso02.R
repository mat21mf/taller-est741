# convert .RData -> .rdb/.rdx
# source("/home/matbox/mis.sources/contrib-src/R-3.6.0/src/library/tools/R/makeLazyLoad.R")
#library(archivist)
#?archivist:::
#library(tools)
#??makeLazyLoadDB
#tools:::makeLazyLoadDB
#?tools:::makeLazyLoadDB
sesion = local({load("Sesion.RData"); environment()})
sesion = local({load("C:/cygwin64/home/matias.rebolledo/PUCV/est741_2019/caso02/src/Sesion.RData"); environment()})
tools:::makeLazyLoadDB(sesion, "Sesion")

### conversion .RData ==> .rdb/.rdx
### - resulto solamente en windows
### - no es necesario volver a crear datos desde .xlsx/.csv
base::lazyLoad("Sesion" , envir = envsess01 )
length(ls())
#library(pryr)
pryr::mem_used()

###
### datos originales
###
### - obsoleto
### - se cargan con base::lazyLoad()
### - hay casi 30.000 objetos
### - algunos no sirven
###

### cadfmpndrgar datos xlsx
dfmbio <- openxlsx::read.xlsx( "../xlsx/base_datos_1.xlsx" )

### diccionario , levels , labels , tipo datos
source( "DiccionarioDatos.R" )

### dejar variable de respuesta al final del dataframe
dfmbio <- dfmbio [ , c(1:18,20:21,19) ]
str( dfmbio )

### quitar non unicode de nombres de variables no soporta autocompletado
colnames( dfmbio     ) <- nombres_abreviados
str( dfmbio )

### buscar comas para reemplazar - corregido OK
print( paste( "ANO.PROC"                        , sum( grepl( " , " , dfmbio$ANO.PROC           )  )  )  )
print( paste( "EDAD"                            , sum( grepl( " , " , dfmbio$EDAD               )  )  )  )
print( paste( "DIABETES"                        , sum( grepl( " , " , dfmbio$DIABETES           )  )  )  )
print( paste( "HOSP.ULT.MES"                    , sum( grepl( " , " , dfmbio$HOSP.ULT.MES       )  )  )  )
print( paste( "PSA"                             , sum( grepl( " , " , dfmbio$PSA                )  )  )  )
print( paste( "BIOP.PREV"                       , sum( grepl( " , " , dfmbio$BIOP.PREV          )  )  )  )
print( paste( "VOL.PROST"                       , sum( grepl( " , " , dfmbio$VOL.PROST          )  )  )  )
print( paste( "ANTIB.PROFI"                     , sum( grepl( " , " , dfmbio$ANTIB.PROFI        )  )  )  )
print( paste( "NUM.MUESTRAS"                    , sum( grepl( " , " , dfmbio$NUM.MUESTRAS       )  )  )  )
print( paste( "CUP"                             , sum( grepl( " , " , dfmbio$CUP                )  )  )  )
print( paste( "EPOC"                            , sum( grepl( " , " , dfmbio$EPOC               )  )  )  )
print( paste( "BIOPSIA"                         , sum( grepl( " , " , dfmbio$BIOPSIA            )  )  )  )
print( paste( "NUM.DIAS.POST.BIOP"              , sum( grepl( " , " , dfmbio$NUM.DIAS.POST.BIOP )  )  )  )
print( paste( "FIEBRE"                          , sum( grepl( " , " , dfmbio$FIEBRE             )  )  )  )
print( paste( "ITU"                             , sum( grepl( " , " , dfmbio$ITU                )  )  )  )
print( paste( "TIPO.CULTIVO"                    , sum( grepl( " , " , dfmbio$TIPO.CULTIVO       )  )  )  )
print( paste( "AGENTE.AISLADO"                  , sum( grepl( " , " , dfmbio$AGENTE.AISLADO     )  )  )  )
print( paste( "PATR.RESIST"                     , sum( grepl( " , " , dfmbio$PATR.RESIST        )  )  )  )
print( paste( "DIAS.HOSP.MQ"                    , sum( grepl( " , " , dfmbio$DIAS.HOSP.MQ       )  )  )  )
print( paste( "DIAS.HOSP.UPC"                   , sum( grepl( " , " , dfmbio$DIAS.HOSP.UPC      )  )  )  )
print( paste( "HOSPITALIZACION"                 , sum( grepl( " , " , dfmbio$HOSPITALIZACION    )  )  )  )

### reemplazar coma por punto y coma para exportar csv - corregido OK
dfmbio$EPOC        <- gsub( "," , ";" , dfmbio$EPOC        )
dfmbio$PATR.RESIST <- gsub( "," , ";" , dfmbio$PATR.RESIST )
### revisar reemplazos
print( paste( "EPOC"        , sum( grepl( " , " , dfmbio$EPOC        )  )  )  )
print( paste( "PATR.RESIST" , sum( grepl( " , " , dfmbio$PATR.RESIST )  )  )  )

### exportar csv
write.table( dfmbio , file="../csv/dfmbio.csv" , sep="," , col.names=T, row.names=F , quote=F )

### limpieza datos, casos donde un mismo registro esta escrito de 2 formas diferentes por presencia de espacio en blanco
### Ejecutar: bash LimpiarDatos.sh
system( "bash LimpiarDatos.sh" )

### cargar datos de nuevo corregidos
dfmbio <- read.table( file="../csv/dfmbio.csv" , header=T , sep="," , stringsAsFactors=F )
str( dfmbio )

### valores unicos
 #sort( unique( dfmbio$ANO.PROC           )  ) ### integer    ### 01
 #sort( unique( dfmbio$EDAD               )  ) ### integer    ### 02
  sort( unique( dfmbio$DIABETES           )  ) ### character  ### 03
  sort( unique( dfmbio$HOSP.ULT.MES       )  ) ### character  ### 04
 #sort( unique( dfmbio$PSA                )  ) ### numeric    ### 05
  sort( unique( dfmbio$BIOP.PREV          )  ) ### character  ### 06
  sort( unique( dfmbio$VOL.PROST          )  ) ### character  ### 07
  sort( unique( dfmbio$ANTIB.PROFI        )  ) ### character  ### 08
 #sort( unique( dfmbio$NUM.MUESTRAS       )  ) ### integer    ### 09
  sort( unique( dfmbio$CUP                )  ) ### character  ### 10
  sort( unique( dfmbio$EPOC               )  ) ### character  ### 11
  sort( unique( dfmbio$BIOPSIA            )  ) ### character  ### 12
  sort( unique( dfmbio$NUM.DIAS.POST.BIOP )  ) ### character  ### 13
  sort( unique( dfmbio$FIEBRE             )  ) ### character  ### 14
  sort( unique( dfmbio$ITU                )  ) ### character  ### 15
  sort( unique( dfmbio$TIPO.CULTIVO       )  ) ### character  ### 16
  sort( unique( dfmbio$AGENTE.AISLADO     )  ) ### character  ### 17
  sort( unique( dfmbio$PATR.RESIST        )  ) ### character  ### 18
  sort( unique( dfmbio$DIAS.HOSP.MQ       )  ) ### integer    ### 19
  sort( unique( dfmbio$DIAS.HOSP.UPC      )  ) ### integer    ### 20
  sort( unique( dfmbio$HOSPITALIZACION    )  ) ### character  ### 21

### tipo de dato
class( dfmbio$ANO.PROC           )
class( dfmbio$EDAD               )
class( dfmbio$DIABETES           )
class( dfmbio$HOSP.ULT.MES       )
class( dfmbio$PSA                )
class( dfmbio$BIOP.PREV          )
class( dfmbio$VOL.PROST          )
class( dfmbio$ANTIB.PROFI        )
class( dfmbio$NUM.MUESTRAS       )
class( dfmbio$CUP                )
class( dfmbio$EPOC               )
class( dfmbio$BIOPSIA            )
class( dfmbio$NUM.DIAS.POST.BIOP )
class( dfmbio$FIEBRE             )
class( dfmbio$ITU                )
class( dfmbio$TIPO.CULTIVO       )
class( dfmbio$AGENTE.AISLADO     )
class( dfmbio$PATR.RESIST        )
class( dfmbio$DIAS.HOSP.MQ       )
class( dfmbio$DIAS.HOSP.UPC      )
class( dfmbio$HOSPITALIZACION    )

### recuento por tipo de variables
#?Filter
length( colnames( Filter( is.numeric   , dfmbio ) ) )
length( colnames( Filter( is.character , dfmbio ) ) )

###
### Análisis descriptivo
###

### edad es un factor de riesgo
max( dfmbio$EDAD )
min( dfmbio$EDAD )
### graficar las dos distribuciones de edad traslapadas
aggregate( dfmbio$EDAD ~ dfmbio$HOSPITALIZACION , dfmbio , mean )
aggregate( dfmbio$EDAD ~ dfmbio$HOSPITALIZACION , dfmbio , sd   )
aggregate( dfmbio$EDAD ~ dfmbio$HOSPITALIZACION , dfmbio , median )
dev.off()
col01 <- rgb(0,0,1,0.2)
col02 <- rgb(1,0,0,0.2)
plot.new()

plot(    density( dfmbio$EDAD [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01 , xlim=c(35,85) , main="" )
polygon( density( dfmbio$EDAD [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01 , xlim=c(35,85) )
polygon( density( dfmbio$EDAD [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col02 , xlim=c(35,85) )
legend('topleft', legend = levels( as.factor( dfmbio$HOSPITALIZACION ) ) , col=c(col01,col02) , cex=.8 , pch=1 )
title( main = "Densidad de Edad entre casos versus controles" )

plot.new()
plot(    density( dfmbio$PSA [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01                 )
polygon( density( dfmbio$PSA [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01                 )
polygon( density( dfmbio$PSA [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$NUM.MUESTRAS [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01                 )
polygon( density( dfmbio$NUM.MUESTRAS [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01                 )
polygon( density( dfmbio$NUM.MUESTRAS [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$DIAS.HOSP.MQ [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.MQ [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.MQ [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$DIAS.HOSP.UPC [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.UPC [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.UPC [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$EDAD [ dfmbio$ANO.PROC == "2012" ] ) , col=col01 , xlim=c(35,85) )
polygon( density( dfmbio$EDAD [ dfmbio$ANO.PROC == "2012" ] ) , col=col01 , xlim=c(35,85) )
polygon( density( dfmbio$EDAD [ dfmbio$ANO.PROC == "2013" ] ) , col=col02 , xlim=c(35,85) )
plot.new()
plot(    density( dfmbio$PSA [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$PSA [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$PSA [ dfmbio$ANO.PROC == "2013" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$NUM.MUESTRAS [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$NUM.MUESTRAS [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$NUM.MUESTRAS [ dfmbio$ANO.PROC == "2013" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$DIAS.HOSP.MQ [ dfmbio$ANO.PROC == "2013" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.MQ [ dfmbio$ANO.PROC == "2013" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.MQ [ dfmbio$ANO.PROC == "2012" ] ) , col=col02                 )
plot.new()
plot(    density( dfmbio$DIAS.HOSP.UPC [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.UPC [ dfmbio$ANO.PROC == "2012" ] ) , col=col01                 )
polygon( density( dfmbio$DIAS.HOSP.UPC [ dfmbio$ANO.PROC == "2013" ] ) , col=col02                 )

### PSA sera factor de riesgo
plot(    density( dfmbio$PSA  [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01 , xlim=c(0,100) )
polygon( density( dfmbio$PSA  [ dfmbio$HOSPITALIZACION == "SI" ] ) , col=col01 , xlim=c(0,100) )
polygon( density( dfmbio$PSA  [ dfmbio$HOSPITALIZACION == "NO" ] ) , col=col02 , xlim=c(0,100) )

### dimensiones
colnames( dfmbio )
#View( dfmbio )
dim( dfmbio )
tail( dfmbio )
head( dfmbio )

### faltantes
apply( dfmbio , 2 , function(x) sum( is.na(x) ) )

### histogramas
hist( as.numeric( as.factor( dfmbio[,19] ) ) )

#?table
table( dfmbio$DIABETES , dnn=colnames( dfmbio )[3] )
with( dfmbio , table( DIABETES ) )
with( dfmbio , table( cut( EDAD , quantile( EDAD ) ) , DIABETES ) )
table( dfmbio$ANO.PROC )

### histogramas
ifelse( class( dfmbio$ANO.PROC           ) == "numeric" , hist( dfmbio$ANO.PROC           )  , hist( as.numeric( as.factor( dfmbio$ANO.PROC           )  )  )  )
ifelse( class( dfmbio$EDAD               ) == "numeric" , hist( dfmbio$EDAD               )  , hist( as.numeric( as.factor( dfmbio$EDAD               )  )  )  )
ifelse( class( dfmbio$DIABETES           ) == "numeric" , hist( dfmbio$DIABETES           )  , hist( as.numeric( as.factor( dfmbio$DIABETES           )  )  )  )
ifelse( class( dfmbio$HOSP.ULT.MES       ) == "numeric" , hist( dfmbio$HOSP.ULT.MES       )  , hist( as.numeric( as.factor( dfmbio$HOSP.ULT.MES       )  )  )  )
ifelse( class( dfmbio$PSA                ) == "numeric" , hist( dfmbio$PSA                )  , hist( as.numeric( as.factor( dfmbio$PSA                )  )  )  )
ifelse( class( dfmbio$BIOP.PREV          ) == "numeric" , hist( dfmbio$BIOP.PREV          )  , hist( as.numeric( as.factor( dfmbio$BIOP.PREV          )  )  )  )
ifelse( class( dfmbio$VOL.PROST          ) == "numeric" , hist( dfmbio$VOL.PROST          )  , hist( as.numeric( as.factor( dfmbio$VOL.PROST          )  )  )  )
ifelse( class( dfmbio$ANTIB.PROFI        ) == "numeric" , hist( dfmbio$ANTIB.PROFI        )  , hist( as.numeric( as.factor( dfmbio$ANTIB.PROFI        )  )  )  )
ifelse( class( dfmbio$NUM.MUESTRAS       ) == "numeric" , hist( dfmbio$NUM.MUESTRAS       )  , hist( as.numeric( as.factor( dfmbio$NUM.MUESTRAS       )  )  )  )
ifelse( class( dfmbio$CUP                ) == "numeric" , hist( dfmbio$CUP                )  , hist( as.numeric( as.factor( dfmbio$CUP                )  )  )  )
ifelse( class( dfmbio$EPOC               ) == "numeric" , hist( dfmbio$EPOC               )  , hist( as.numeric( as.factor( dfmbio$EPOC               )  )  )  )
ifelse( class( dfmbio$BIOPSIA            ) == "numeric" , hist( dfmbio$BIOPSIA            )  , hist( as.numeric( as.factor( dfmbio$BIOPSIA            )  )  )  )
ifelse( class( dfmbio$NUM.DIAS.POST.BIOP ) == "numeric" , hist( dfmbio$NUM.DIAS.POST.BIOP )  , hist( as.numeric( as.factor( dfmbio$NUM.DIAS.POST.BIOP )  )  )  )
ifelse( class( dfmbio$FIEBRE             ) == "numeric" , hist( dfmbio$FIEBRE             )  , hist( as.numeric( as.factor( dfmbio$FIEBRE             )  )  )  )
ifelse( class( dfmbio$ITU                ) == "numeric" , hist( dfmbio$ITU                )  , hist( as.numeric( as.factor( dfmbio$ITU                )  )  )  )
ifelse( class( dfmbio$TIPO.CULTIVO       ) == "numeric" , hist( dfmbio$TIPO.CULTIVO       )  , hist( as.numeric( as.factor( dfmbio$TIPO.CULTIVO       )  )  )  )
ifelse( class( dfmbio$AGENTE.AISLADO     ) == "numeric" , hist( dfmbio$AGENTE.AISLADO     )  , hist( as.numeric( as.factor( dfmbio$AGENTE.AISLADO     )  )  )  )
ifelse( class( dfmbio$PATR.RESIST        ) == "numeric" , hist( dfmbio$PATR.RESIST        )  , hist( as.numeric( as.factor( dfmbio$PATR.RESIST        )  )  )  )
ifelse( class( dfmbio$DIAS.HOSP.MQ       ) == "numeric" , hist( dfmbio$DIAS.HOSP.MQ       )  , hist( as.numeric( as.factor( dfmbio$DIAS.HOSP.MQ       )  )  )  )
ifelse( class( dfmbio$DIAS.HOSP.UPC      ) == "numeric" , hist( dfmbio$DIAS.HOSP.UPC      )  , hist( as.numeric( as.factor( dfmbio$DIAS.HOSP.UPC      )  )  )  )
ifelse( class( dfmbio$HOSPITALIZACION    ) == "numeric" , hist( dfmbio$HOSPITALIZACION    )  , hist( as.numeric( as.factor( dfmbio$HOSPITALIZACION    )  )  )  )

### boxplot segun variable respuesta
ifelse( class( dfmbio$ANO.PROC           ) == "numeric" , boxplot( dfmbio$ANO.PROC           ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$ANO.PROC           )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$EDAD               ) == "numeric" , boxplot( dfmbio$EDAD               ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$EDAD               )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$DIABETES           ) == "numeric" , boxplot( dfmbio$DIABETES           ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$DIABETES           )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$HOSP.ULT.MES       ) == "numeric" , boxplot( dfmbio$HOSP.ULT.MES       ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$HOSP.ULT.MES       )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$PSA                ) == "numeric" , boxplot( dfmbio$PSA                ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$PSA                )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$BIOP.PREV          ) == "numeric" , boxplot( dfmbio$BIOP.PREV          ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$BIOP.PREV          )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$VOL.PROST          ) == "numeric" , boxplot( dfmbio$VOL.PROST          ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$VOL.PROST          )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$ANTIB.PROFI        ) == "numeric" , boxplot( dfmbio$ANTIB.PROFI        ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$ANTIB.PROFI        )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$NUM.MUESTRAS       ) == "numeric" , boxplot( dfmbio$NUM.MUESTRAS       ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$NUM.MUESTRAS       )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$CUP                ) == "numeric" , boxplot( dfmbio$CUP                ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$CUP                )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$EPOC               ) == "numeric" , boxplot( dfmbio$EPOC               ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$EPOC               )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$BIOPSIA            ) == "numeric" , boxplot( dfmbio$BIOPSIA            ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$BIOPSIA            )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$NUM.DIAS.POST.BIOP ) == "numeric" , boxplot( dfmbio$NUM.DIAS.POST.BIOP ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$NUM.DIAS.POST.BIOP )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$FIEBRE             ) == "numeric" , boxplot( dfmbio$FIEBRE             ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$FIEBRE             )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$ITU                ) == "numeric" , boxplot( dfmbio$ITU                ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$ITU                )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$TIPO.CULTIVO       ) == "numeric" , boxplot( dfmbio$TIPO.CULTIVO       ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$TIPO.CULTIVO       )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$AGENTE.AISLADO     ) == "numeric" , boxplot( dfmbio$AGENTE.AISLADO     ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$AGENTE.AISLADO     )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$PATR.RESIST        ) == "numeric" , boxplot( dfmbio$PATR.RESIST        ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$PATR.RESIST        )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$DIAS.HOSP.MQ       ) == "numeric" , boxplot( dfmbio$DIAS.HOSP.MQ       ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$DIAS.HOSP.MQ       )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$DIAS.HOSP.UPC      ) == "numeric" , boxplot( dfmbio$DIAS.HOSP.UPC      ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$DIAS.HOSP.UPC      )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )
ifelse( class( dfmbio$HOSPITALIZACION    ) == "numeric" , boxplot( dfmbio$HOSPITALIZACION    ) ~ as.factor( dfmbio$HOSPITALIZACION )  , boxplot( as.numeric( as.factor( dfmbio$HOSPITALIZACION    )  ) ~ as.factor( dfmbio$HOSPITALIZACION )  )  )

###
### Variables numeric
###
### - R siempre empieza desde 1 y no desde 0
### - variables de interes deben comenzar desde 0
### - recodificar en bash y cargar en R o usar en Bash solamente
### - recodificacion se encuentra en LimpiarDatos.sh
### - Python es opcion 2 ademas de Bash opcion 1
### ==> Bash LimpiarDatos.sh OK
###   - Desde aqui agregar nuevos levels y labels
###   - dfmbio_num ==> dfmbio_fac
###

### dataframe solo como numeric
### volver a leer y cambiar tipo datos
dfmbio_num <- read.table( file="../csv/dfmbio_num.csv" , header=T , sep=","                      )
### quitar acentos de nombres
colnames( dfmbio_num ) <- nombres_abreviados
str( dfmbio_num )

### verificar tipo dato
class( dfmbio_num$ANO.PROC           )
class( dfmbio_num$EDAD               )
class( dfmbio_num$DIABETES           )
class( dfmbio_num$HOSP.ULT.MES       )
class( dfmbio_num$PSA                )
class( dfmbio_num$BIOP.PREV          )
class( dfmbio_num$VOL.PROST          )
class( dfmbio_num$ANTIB.PROFI        )
class( dfmbio_num$NUM.MUESTRAS       )
class( dfmbio_num$CUP                )
class( dfmbio_num$EPOC               )
class( dfmbio_num$BIOPSIA            )
class( dfmbio_num$NUM.DIAS.POST.BIOP )
class( dfmbio_num$FIEBRE             )
class( dfmbio_num$ITU                )
class( dfmbio_num$TIPO.CULTIVO       )
class( dfmbio_num$AGENTE.AISLADO     )
class( dfmbio_num$PATR.RESIST        )
class( dfmbio_num$DIAS.HOSP.MQ       )
class( dfmbio_num$DIAS.HOSP.UPC      )
class( dfmbio_num$HOSPITALIZACION    )

### cuantos factor y cuantos numeric
length( colnames( Filter( is.factor  , dfmbio_num ) ) )
length( colnames( Filter( is.numeric , dfmbio_num ) ) )

### valores unicos para factor
 #sort( unique( dfmbio_num$ANO.PROC           )  ) ### integer
 #sort( unique( dfmbio_num$EDAD               )  ) ### integer
  sort( unique( dfmbio_num$DIABETES           )  ) ### factor
  sort( unique( dfmbio_num$HOSP.ULT.MES       )  ) ### factor
 #sort( unique( dfmbio_num$PSA                )  ) ### numeric
  sort( unique( dfmbio_num$BIOP.PREV          )  ) ### factor
  sort( unique( dfmbio_num$VOL.PROST          )  ) ### factor
  sort( unique( dfmbio_num$ANTIB.PROFI        )  ) ### factor
 #sort( unique( dfmbio_num$NUM.MUESTRAS       )  ) ### integer
  sort( unique( dfmbio_num$CUP                )  ) ### factor
  sort( unique( dfmbio_num$EPOC               )  ) ### factor
  sort( unique( dfmbio_num$BIOPSIA            )  ) ### factor
  sort( unique( dfmbio_num$NUM.DIAS.POST.BIOP )  ) ### factor
  sort( unique( dfmbio_num$FIEBRE             )  ) ### factor
  sort( unique( dfmbio_num$ITU                )  ) ### factor
  sort( unique( dfmbio_num$TIPO.CULTIVO       )  ) ### factor
  sort( unique( dfmbio_num$AGENTE.AISLADO     )  ) ### factor
  sort( unique( dfmbio_num$PATR.RESIST        )  ) ### factor
 #sort( unique( dfmbio_num$DIAS.HOSP.MQ       )  ) ### integer
 #sort( unique( dfmbio_num$DIAS.HOSP.UPC      )  ) ### integer
  sort( unique( dfmbio_num$HOSPITALIZACION    )  ) ### factor

# ### factor a numeric - obsoleto - se usa codigo con levels y labels mas abajo
# ### dfmbio_num$DIABETES           <- as.numeric( dfmbio_num$DIABETES           )
# ### dfmbio_num$HOSP.ULT.MES       <- as.numeric( dfmbio_num$HOSP.ULT.MES       )
# ### dfmbio_num$BIOP.PREV          <- as.numeric( dfmbio_num$BIOP.PREV          )
# ### dfmbio_num$VOL.PROST          <- as.numeric( dfmbio_num$VOL.PROST          )
# ### dfmbio_num$ANTIB.PROFI        <- as.numeric( dfmbio_num$ANTIB.PROFI        )
# ### dfmbio_num$CUP                <- as.numeric( dfmbio_num$CUP                )
# ### dfmbio_num$EPOC               <- as.numeric( dfmbio_num$EPOC               )
# ### dfmbio_num$BIOPSIA            <- as.numeric( dfmbio_num$BIOPSIA            )
# ### dfmbio_num$NUM.DIAS.POST.BIOP <- as.numeric( dfmbio_num$NUM.DIAS.POST.BIOP )
# ### dfmbio_num$FIEBRE             <- as.numeric( dfmbio_num$FIEBRE             )
# ### dfmbio_num$ITU                <- as.numeric( dfmbio_num$ITU                )
# ### dfmbio_num$TIPO.CULTIVO       <- as.numeric( dfmbio_num$TIPO.CULTIVO       )
# ### dfmbio_num$AGENTE.AISLADO     <- as.numeric( dfmbio_num$AGENTE.AISLADO     )
# ### dfmbio_num$PATR.RESIST        <- as.numeric( dfmbio_num$PATR.RESIST        )
# ### dfmbio_num$HOSPITALIZACION    <- as.numeric( dfmbio_num$HOSPITALIZACION    )

### grabar numerico sin col.names para mlpack - obsoleto
### write.table( dfmbio_num , file="../csv/dfmbio_num.csv" , sep="," , col.names=F, row.names=F , quote=F )

length( colnames( Filter( is.numeric   , dfmbio_num ) ) )
length( colnames( Filter( is.factor    , dfmbio_num ) ) )

###
### Variables factor
###
### - definirlas solamente con levels y labels, no con stringsAsFactors
### - solo para modelacion dentro de R
### - dfmbio_num ==> dfmbio_num
###

### cargar diccionarios levels y labels
source( "DiccionarioDatos.R" )

### dataframe solo como factor - cambiar por levels y labels - usar stringsAsFactors=F
dfmbio_fac <- read.table( file="../csv/dfmbio.csv" , header=T , sep="," , colClasses = TipoDatosFac , stringsAsFactors = T )
### quitar non unicode de nombres de variables no soporta autocompletado
colnames( dfmbio_fac ) <- nombres_abreviados
str( dfmbio_fac )
#?gl
#gl(2,1,10)

# dfmbio_fac$HOSPITALIZACION <- factor( dfmbio_fac$HOSPITALIZACION , levels = c(0,1) , labels = c("NO","SI") )
# levels( dfmbio_fac$HOSPITALIZACION )

  ### convertir variables a factor usando levels y labels
 #dfmbio_fac$ANO.PROC           <- factor( dfmbio_fac$ANO.PROC           , levels=            (DiccFactor01.lev )  , labels=DiccFactor01.lab ) ### integer
 #dfmbio_fac$EDAD               <- factor( dfmbio_fac$EDAD               , levels=            (DiccFactor02.lev )  , labels=DiccFactor02.lab ) ### integer
  dfmbio_fac$DIABETES           <- factor( dfmbio_fac$DIABETES           , levels=            (DiccFactor03.lev )  , labels=DiccFactor03.lab ) ### factor
  dfmbio_fac$HOSP.ULT.MES       <- factor( dfmbio_fac$HOSP.ULT.MES       , levels=            (DiccFactor04.lev )  , labels=DiccFactor04.lab ) ### factor
 #dfmbio_fac$PSA                <- factor( dfmbio_fac$PSA                , levels=            (DiccFactor05.lev )  , labels=DiccFactor05.lab ) ### numeric
  dfmbio_fac$BIOP.PREV          <- factor( dfmbio_fac$BIOP.PREV          , levels=            (DiccFactor06.lev )  , labels=DiccFactor06.lab ) ### factor
  dfmbio_fac$VOL.PROST          <- factor( dfmbio_fac$VOL.PROST          , levels=            (DiccFactor07.lev )  , labels=DiccFactor07.lab ) ### factor
  dfmbio_fac$ANTIB.PROFI        <- factor( dfmbio_fac$ANTIB.PROFI        , levels=            (DiccFactor08.lev )  , labels=DiccFactor08.lab ) ### factor
 #dfmbio_fac$NUM.MUESTRAS       <- factor( dfmbio_fac$NUM.MUESTRAS       , levels=            (DiccFactor09.lev )  , labels=DiccFactor09.lab ) ### integer
  dfmbio_fac$CUP                <- factor( dfmbio_fac$CUP                , levels=            (DiccFactor10.lev )  , labels=DiccFactor10.lab ) ### factor
  dfmbio_fac$EPOC               <- factor( dfmbio_fac$EPOC               , levels=            (DiccFactor11.lev )  , labels=DiccFactor11.lab ) ### factor
  dfmbio_fac$BIOPSIA            <- factor( dfmbio_fac$BIOPSIA            , levels=            (DiccFactor12.lev )  , labels=DiccFactor12.lab ) ### factor
  dfmbio_fac$NUM.DIAS.POST.BIOP <- factor( dfmbio_fac$NUM.DIAS.POST.BIOP , levels=            (DiccFactor13.lev )  , labels=DiccFactor13.lab ) ### factor
  dfmbio_fac$FIEBRE             <- factor( dfmbio_fac$FIEBRE             , levels=            (DiccFactor14.lev )  , labels=DiccFactor14.lab ) ### factor
  dfmbio_fac$ITU                <- factor( dfmbio_fac$ITU                , levels=            (DiccFactor15.lev )  , labels=DiccFactor15.lab ) ### factor
  dfmbio_fac$TIPO.CULTIVO       <- factor( dfmbio_fac$TIPO.CULTIVO       , levels=            (DiccFactor16.lev )  , labels=DiccFactor16.lab ) ### factor
  dfmbio_fac$AGENTE.AISLADO     <- factor( dfmbio_fac$AGENTE.AISLADO     , levels=            (DiccFactor17.lev )  , labels=DiccFactor17.lab ) ### factor
  dfmbio_fac$PATR.RESIST        <- factor( dfmbio_fac$PATR.RESIST        , levels=            (DiccFactor18.lev )  , labels=DiccFactor18.lab ) ### factor
 #dfmbio_fac$DIAS.HOSP.MQ       <- factor( dfmbio_fac$DIAS.HOSP.MQ       , levels=            (DiccFactor19.lev )  , labels=DiccFactor19.lab ) ### integer
 #dfmbio_fac$DIAS.HOSP.UPC      <- factor( dfmbio_fac$DIAS.HOSP.UPC      , levels=            (DiccFactor20.lev )  , labels=DiccFactor20.lab ) ### integer
  dfmbio_fac$HOSPITALIZACION    <- factor( dfmbio_fac$HOSPITALIZACION    , levels=            (DiccFactor21.lev )  , labels=DiccFactor21.lab ) ### factor

length( colnames( Filter( is.numeric   , dfmbio_fac ) ) )
length( colnames( Filter( is.factor    , dfmbio_fac ) ) )

str( dfmbio_fac )

### faltantes
apply( dfmbio_fac , 2 , function(x) sum( is.na(x) ) )

### valores unicos dfmbio_fac
 #sort( unique( dfmbio_fac$ANO.PROC           )  ) ### integer
 #sort( unique( dfmbio_fac$EDAD               )  ) ### integer
  sort( unique( dfmbio_fac$DIABETES           )  ) ### factor
  sort( unique( dfmbio_fac$HOSP.ULT.MES       )  ) ### factor
 #sort( unique( dfmbio_fac$PSA                )  ) ### numeric
  sort( unique( dfmbio_fac$BIOP.PREV          )  ) ### factor
  sort( unique( dfmbio_fac$VOL.PROST          )  ) ### factor
  sort( unique( dfmbio_fac$ANTIB.PROFI        )  ) ### factor
 #sort( unique( dfmbio_fac$NUM.MUESTRAS       )  ) ### integer
  sort( unique( dfmbio_fac$CUP                )  ) ### factor
  sort( unique( dfmbio_fac$EPOC               )  ) ### factor
  sort( unique( dfmbio_fac$BIOPSIA            )  ) ### factor
  sort( unique( dfmbio_fac$NUM.DIAS.POST.BIOP )  ) ### factor
  sort( unique( dfmbio_fac$FIEBRE             )  ) ### factor
  sort( unique( dfmbio_fac$ITU                )  ) ### factor
  sort( unique( dfmbio_fac$TIPO.CULTIVO       )  ) ### factor
  sort( unique( dfmbio_fac$AGENTE.AISLADO     )  ) ### factor
  sort( unique( dfmbio_fac$PATR.RESIST        )  ) ### factor
 #sort( unique( dfmbio_fac$DIAS.HOSP.MQ       )  ) ### integer
 #sort( unique( dfmbio_fac$DIAS.HOSP.UPC      )  ) ### integer
  sort( unique( dfmbio_fac$HOSPITALIZACION    )  ) ### factor

# ### comparar
# as.numeric( as.factor( dfmbio$HOSPITALIZACION ) )
# as.numeric( dfmbio_fac$HOSPITALIZACION )
# dfmbio_num$HOSPITALIZACION
# dfmbio_fac [ dfmbio_fac$HOSPITALIZACION == "SI" , 21 ] <- levels( c(

boxplot( dfmbio_fac$EDAD , dfmbio_fac$HOSPITALIZACION )

###
with( dfmbio_fac , table( PATR.RESIST    , BIOPSIA        )  )
with( dfmbio_fac , table( BIOPSIA        , AGENTE.AISLADO )  )
with( dfmbio_fac , table( BIOPSIA        , TIPO.CULTIVO   )  )
with( dfmbio_fac , table( AGENTE.AISLADO , TIPO.CULTIVO   )  )
with( dfmbio_fac , table( AGENTE.AISLADO , ANTIB.PROFI    )  )
with( dfmbio_fac , table( TIPO.CULTIVO   , ANTIB.PROFI    )  )
with( dfmbio_fac , table( PATR.RESIST    , TIPO.CULTIVO   )  )
with( dfmbio_fac , table( PATR.RESIST    , AGENTE.AISLADO )  )
with( dfmbio_fac , table( PATR.RESIST    , FIEBRE         )  )
with( dfmbio_fac , table( PATR.RESIST    , ITU            )  )
with( dfmbio_fac , table( FIEBRE         , ITU            )  )

###
### k-means
###
### kmodes ==> paquete klaR
### - en variables categoricas hay que usar k-modes ==> paquete klaR
### - archivos incluidos estimacion kmodes
###   ==> ClusterKmodes.R
###   ==> ClusterKmodes.sh
###   ==> ClusterKmodesParallel.sh
### - problema kmodes es solo para variables categoricas, no numericas
###
### kproto ==> paquete clustMixType
### - k-means para tipo de datos mixtos
### - archivos incluidos estimacion kproto
###   ==> ClusterKproto.R
###   ==> ClusterKproto.sh
###   ==> ClusterKprotoParallel.sh
###   ==> ClusterKproto_Concat.R
###
### hamming distance ==> mlpack
### - require solo variables dummies con model.matrix
###
### gower distance ==> cluster::daisy
### - distance matrix variables mixtas
###
###

library(klaR)
#utils::help( package = "klaR" )
#?klaR::kmodes
library(clustMixType)
#?clustMixType::kproto
#?clustMixType::silhouette_kproto
#?save
colnames( dfmbio_ctr_nnzv_x )
colnames( dfmbio_ctr_nnzv   )
### incluir semillas en RData
save( dfmbio_ctr_nnzv_x , semillas , file="../RData/dfmbio_ctr_nnzv_x.RData" )
save( dfmbio_ctr_nnzv   , semillas , file="../RData/dfmbio_ctr_nnzv.RData" )

### matriz distancias euclideana
dfmbio_num_dist <- stats::dist( dfmbio_num )
str( dfmbio_num_dist )

### matriz distancias gower
colnames(dfmbio_ctr_nnzv  )
colnames(dfmbio_ctr_nnzv_x)
library(cluster)
#?cluster::daisy
dfmbio_ctr_nnzv_dist_gower   <- cluster::daisy( dfmbio_ctr_nnzv  [,-c(10)] , metric="gower" , stand=F , type=list(numeric=c(1,2,4,8)) )
dfmbio_ctr_nnzv_x_dist_gower <- cluster::daisy( dfmbio_ctr_nnzv_x[,-c(1) ] , metric="gower" , stand=F )
str(dfmbio_ctr_nnzv_x_dist_gower)
class(dfmbio_ctr_nnzv_x_dist_gower)
dfmbio_ctr_nnzv_x_mat_gower <- as.matrix( dfmbio_ctr_nnzv_x_dist_gower )
str(dfmbio_ctr_nnzv_x_mat_gower)
class(dfmbio_ctr_nnzv_x_mat_gower)

###
### k-means final opcion 01 ==> e1071::hamming + clustMixType::kproto  + stats::silhouette
### k-means final opcion 02 ==> cluster::daisy + cluster::pam          + stats::silhouette
###

### hamming distance
### - solo para vectores de a pares , no para data.frames
library(e1071)
#?e1071::hamming.distance

### carga de archivos kpt {{{
### source("KprotoLoad.R")
source("Kproto/KprotoLoad_seed0001.R")
source("Kproto/KprotoLoad_seed0002.R")
source("Kproto/KprotoLoad_seed0003.R")
source("Kproto/KprotoLoad_seed0004.R")
source("Kproto/KprotoLoad_seed0005.R")
source("Kproto/KprotoLoad_seed0006.R")
source("Kproto/KprotoLoad_seed0007.R")
source("Kproto/KprotoLoad_seed0008.R")
source("Kproto/KprotoLoad_seed0009.R")
source("Kproto/KprotoLoad_seed0010.R")
source("Kproto/KprotoLoad_seed0011.R")
source("Kproto/KprotoLoad_seed0012.R")
source("Kproto/KprotoLoad_seed0013.R")
source("Kproto/KprotoLoad_seed0014.R")
source("Kproto/KprotoLoad_seed0015.R")
source("Kproto/KprotoLoad_seed0016.R")
source("Kproto/KprotoLoad_seed0017.R")
source("Kproto/KprotoLoad_seed0018.R")
source("Kproto/KprotoLoad_seed0019.R")
source("Kproto/KprotoLoad_seed0020.R")
source("Kproto/KprotoLoad_seed0021.R")
source("Kproto/KprotoLoad_seed0022.R")
source("Kproto/KprotoLoad_seed0023.R")
source("Kproto/KprotoLoad_seed0024.R")
source("Kproto/KprotoLoad_seed0025.R")
source("Kproto/KprotoLoad_seed0026.R")
source("Kproto/KprotoLoad_seed0027.R")
source("Kproto/KprotoLoad_seed0028.R")
source("Kproto/KprotoLoad_seed0029.R")
source("Kproto/KprotoLoad_seed0030.R")
source("Kproto/KprotoLoad_seed0031.R")
source("Kproto/KprotoLoad_seed0032.R")
source("Kproto/KprotoLoad_seed0033.R")
source("Kproto/KprotoLoad_seed0034.R")
source("Kproto/KprotoLoad_seed0035.R")
source("Kproto/KprotoLoad_seed0036.R")
source("Kproto/KprotoLoad_seed0037.R")
source("Kproto/KprotoLoad_seed0038.R")
source("Kproto/KprotoLoad_seed0039.R")
source("Kproto/KprotoLoad_seed0040.R")
source("Kproto/KprotoLoad_seed0041.R")
source("Kproto/KprotoLoad_seed0042.R")
source("Kproto/KprotoLoad_seed0043.R")
source("Kproto/KprotoLoad_seed0044.R")
source("Kproto/KprotoLoad_seed0045.R")
source("Kproto/KprotoLoad_seed0046.R")
source("Kproto/KprotoLoad_seed0047.R")
source("Kproto/KprotoLoad_seed0048.R")
source("Kproto/KprotoLoad_seed0049.R")
source("Kproto/KprotoLoad_seed0050.R")
### }}}

### concatenacion kproto desde archivos externos
source("KprotoConcat.R")
dfmbio_ctr_nnzv_kpt_seed0001_sil
as.data.frame(dfmbio_ctr_nnzv_kpt_seed0001_sil)
as.data.frame(dfmbio_ctr_nnzv_kpt_seed0002_sil)
str(dfmbio_ctr_nnzv_kpt_seed0001_sil)
str(dfmbio_ctr_nnzv_kpt0001_sil)
str(dfmbio_ctr_nnzv_kpt0002_sil)
ls(pattern="*kpt\\d+_sil")
dfmbio_ctr_nnzv_kpt_seed0001_sil_pat <- ls(pattern="*kpt\\d+_sil")
dfmbio_ctr_nnzv_kpt_seed0001_sil <- `row.names<-`(do.call(rbind,mget(dfmbio_ctr_nnzv_kpt_seed0001_sil_pat)), NULL)
str(dfmbio_ctr_nnzv_kpt_seed0001_sil)
dfmbio_ctr_nnzv_kpt_seed0001_sil

### reunir metricas de kpt para 50 semillas distintas {{{
dfmbio_ctr_nnzv_kpt_metricas <- data.frame( seed = matrix( nrow=50 ) )
source("KprotoMetricas.R")
head(dfmbio_ctr_nnzv_kpt_metricas,50)
table(dfmbio_ctr_nnzv_kpt_metricas$k_max)
dplyr::arrange( dfmbio_ctr_nnzv_kpt_metricas , desc( sil_max ) )
dfmbio_ctr_nnzv_kpt_metricas [ dfmbio_ctr_nnzv_kpt_metricas$k_max == 2 , ]
dfmbio_ctr_nnzv_kpt_metricas [ dfmbio_ctr_nnzv_kpt_metricas$k_max == 3 , ]
dfmbio_ctr_nnzv_kpt_metricas [ dfmbio_ctr_nnzv_kpt_metricas$k_max == 4 , ]
dfmbio_ctr_nnzv_kpt_metricas [ which.max(dfmbio_ctr_nnzv_kpt_metricas$sil_max) , ]
#?base::which.max
source("KprotoPrecision450.R")
### }}}

### graficar silhouette promedio kproto
plot( 2:31 , dfmbio_ctr_nnzv_kpt_seed0001_sil , type="l" , las=1 )
axis( 1 , xaxp=c(2,31,29) )

### predict kproto
### - solo nos falta tener un predict especifico para kmeans probaremos ==> SwarmSVM - descartado
### - no se puede obtener un predict para kmeans porque lo que se calculan son distancias entre
###   observaciones y no un vector como LDA. Las distancias solo sirven para graficarlas en dispersion.
### - estos objetos ya no corren , ahora tienen otros nombres en corrida total ; solo ejemplo
### - no podemos obtener un predict basado en probabilidades , pero si basado en clases
###   para esto usaremos caret::confusionMatrix que entrega varias metricas sin tener que calcularlas
attributes(dfmbio_ctr_nnzv_kpt0001)
dfmbio_ctr_nnzv_kpt0001$dists
dfmbio_ctr_nnzv_kpt0001_seed0001_pred <- predict( dfmbio_ctr_nnzv_kpt0001 , dfmbio_ctr_nnzv[,-10] )
base::rowMeans(dfmbio_ctr_nnzv_kpt0001_seed0001_pred$dists)
str(dfmbio_ctr_nnzv_kpt0001_seed0001_pred)
str(dfmbio_ctr_nnzv_kpt0001)
### SwarmSVM
save.image()
savehistory()
#library(SwarmSVM)
#?SwarmSVM::kmeans.predict
class(as.matrix(dfmbio_ctr_nnzv_kpt0001$centers))
head (dfmbio_ctr_nnzv_kpt0001$centers)
### descartado SwarmSVM - continuaremos con LDA - o probar ROCR::performance-class
#SwarmSVM:::kmeans.predict( dfmbio_ctr_nnzv[,-10] , as.matrix(dfmbio_ctr_nnzv_kpt0001$centers) )
### objeto kproto tiene 10 slots mientras que kproto predict tiene 2 slots
### habria que usar cualquiera de las 2 para obtener una prediccion usando ROCR::prediction
### decartado performance porque requiere probabilidades y solo tenemos clases
dfmbio_ctr_nnzv_kpt0001_seed0001_prediction <- ROCR::prediction( dfmbio_ctr_nnzv_kpt0001$dists[,1] , dfmbio_ctr_nnzv$HOSPITALIZACION )
### objeto ROCR::prediction tiene 11 slots
str(dfmbio_ctr_nnzv_kpt0001_seed0002_prediction)
### ROCR::performance
dfmbio_ctr_nnzv_kpt0001_seed0001_perf <- ROCR::performance( dfmbio_ctr_nnzv_kpt0001_seed0001_prediction , "tpr" , "fpr" )
str(dfmbio_ctr_nnzv_kpt0001_seed0001_perf)
plot(dfmbio_ctr_nnzv_kpt0001_seed0001_perf)
#?base::rowMeans

### recode cluster
### - para que calce con el comando table y clases de caso y control
### - para que calce con el comando caret::confusionMatrix y clases de caso y control
dfmbio_ctr_nnzv_kpt0001_class <- ifelse( dfmbio_ctr_nnzv_kpt0001$cluster == 1 , "NO" , "SI" )

### precision predict kproto versus variable dependiente
mean( dfmbio_ctr_nnzv_kpt0001_class == dfmbio_ctr_nnzv$HOSPITALIZACION )

### tabulacion cruzada de variable dependiente con prediccion kproto
table( dfmbio_ctr_nnzv_kpt0001_class   , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )

### usamos caret::confusionMatrix
str(  dfmbio_ctr_nnzv_kpt0001_class)
class(dfmbio_ctr_nnzv_kpt0001_class)
dfmbio_ctr_nnzv_kpt0001_confmat <- caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_kpt0001_class) , dfmbio_ctr_nnzv$HOSPITALIZACION , positive="SI" )
dfmbio_ctr_nnzv_kpt0001_confmat
### objeto caret::confusionMatrix tiene 6 slots
str(dfmbio_ctr_nnzv_kpt0001_confmat)
### slot accuracy
dfmbio_ctr_nnzv_kpt0001_confmat$overall[["Accuracy"]]
dfmbio_ctr_nnzv_kpt0001_confmat$overall[[1]]
### overall tiene 6 slots
data.frame(overall = names(dfmbio_ctr_nnzv_kpt0001_confmat$overall))
### byClass tiene 11 slots
data.frame(byClass = names(dfmbio_ctr_nnzv_kpt0001_confmat$byClass))

### graficar dispersion predict kproto seleccionados 3
### - detalle esta en KprotoPrecision450.R
### - se puede graficar las dos distancias en cada eje distinguiendo clases
### - no corresponde graficar las distancias promediadas , ni variables originales solas
### - no necesitamos predicciones para resultado kmeans ni kproto solamente clases
### - este es solo un ejemplo , los seleccionados estan en KprotoPrecision450.R
plot( dfmbio_ctr_nnzv_kpt0001$dists[,1] , dfmbio_ctr_nnzv_kpt0001$dists[,2] , ylab="Kproto(k=2)" , col=dfmbio_ctr_nnzv_kpt0001$cluster )
legend('topleft' , legend = levels(as.factor(dfmbio_ctr_nnzv_kpt0001$cluster)), col = 1:2, cex = 0.8, pch = 1)

### Kmeans y Kproto conclusiones.
### - Faltaria usar sub muestreo y sobre muestreo.
### - Haremos el mismo ejercicio con LDA para obtener metricas usando clases y
###   graficar usando LD1 y LD2.

###
### Correlaciones
###

### matriz correlaciones
### - revisar que se use solamente spearman para variables categoricas
dev.off()
colnames( dfmbio_num ) <- NULL
library(corrplot)
#?corrplot::corrplot
#?corrplot::corrMatOrder
corrplot::corrplot( cor( dfmbio_num ) , order="hclust" , type = "upper"                                  )
cor( dfmbio_num )[colnames(cor(dfmbio_num))=="FIEBRE",colnames(cor(dfmbio_num))=="HOSPITALIZACION"]
str( dfmbio_num )
#?stats::cor
library(Hmisc)
#?Hmisc::rcorr
dfmbio_num_mat <- Hmisc::rcorr( as.matrix(dfmbio_num) , type = c("pearson", "spearman")  )
str( dfmbio_num_mat )
dim( dfmbio_num_mat$r )
attributes( dfmbio_num_mat )
dfmbio_num_cor <- data.frame( matrix( nrow=nrow(dfmbio_num_mat$r)*(nrow(dfmbio_num_mat$r)-1)/2 , ncol=4 ) )
colnames(dfmbio_num_cor) <- c( "cor_x" , "cor_y" , "cor" , "Pval" )

### convertir matrix cor en dataframe para ordenar por mayor correlacion
strmatinc=1
for( strmatcol in 1:(ncol(dfmbio_num_mat$r)-1) ){
  for( strmatrow in (1+strmatcol):nrow(dfmbio_num_mat$r) ){
   #print( paste( strmatcol , strmatrow , strmatinc ) )
    dfmbio_num_cor[strmatinc,1] <- rownames(dfmbio_num_mat$r)[strmatrow]
    dfmbio_num_cor[strmatinc,2] <- colnames(dfmbio_num_mat$r)[strmatcol]
    dfmbio_num_cor[strmatinc,3] <-          dfmbio_num_mat$r [strmatrow,strmatcol]
    dfmbio_num_cor[strmatinc,4] <-          dfmbio_num_mat$P [strmatrow,strmatcol]
    strmatinc=strmatinc+1
  }
}

### ordenar decreciente por mayor correlacion positiva
dfmbio_num_cor <- dplyr::arrange( dfmbio_num_cor , desc( cor ) )
#dfmbio_num_cor <- dfmbio_num_cor [ dfmbio_num_cor$cor < 1 , ]
dim( dfmbio_num_cor )
head( dfmbio_num_cor                              , 80 )
### mostrar colineales con variable dependiente
head( dfmbio_num_cor [ dfmbio_num_cor$cor_x == "HOSPITALIZACION" , ] ,  6 )
### mostrar colineales entre covariables
head( dfmbio_num_cor [ dfmbio_num_cor$cor_x != "HOSPITALIZACION" , ] , 14 )
tail( dfmbio_num_cor                              , 80 )

#?abbreviate
abbreviate( sort( unique( dfmbio$PATR.RESIST ) ) , 4 , strict=T )
abbreviate( sort( unique( dfmbio$TIPO.CULTIVO       ) ) , 4 , strict=T )

library(knitr)
#?knitr::kable

### repetir ejercicio excluyendo variables mas colineales
### para variables categoricas usar Spearman en vez de Pearson
dfmbio_num_mat_pro <- Hmisc::rcorr( as.matrix( dfmbio_num [ , -c(13,14,16,18,19,20) ] ) , type = c( "pearson" , "spearman" ) )
str(dfmbio_num_mat_pro)
corrplot::corrplot( dfmbio_num_mat_pro$r , order = "FPC" , type = "upper" )

### PerformanceAnalytics tiene otras visualizaciones pero son muchas variables
library(PerformanceAnalytics)
PerformanceAnalytics::chart.Correlation( dfmbio_num [ , -c(13,14,16,18,19,20) ] , histogram=T )

###
### colinealidad con la variable dependiente
### - se observan 3 variables muy colineales con la variable dependiente
### - tampoco es util crear dummies a partir de ellas porque son combinaciones
###   lineales con la variable dependiente
str( dfmbio_num )
with( dfmbio_num , table( HOSPITALIZACION , FIEBRE ) )
with( dfmbio_num , table( HOSPITALIZACION , DIAS.HOSP.MQ ) )
with( dfmbio_num , table( HOSPITALIZACION , NUM.DIAS.POST.BIOP ) )
dfmbio_num_dum <- dfmbio_num [ , c(21,19,13) ]
str(dfmbio_num_dum)
dfmbio_num_dum$DIAS.HOSP.MQ.DUM <- 0
dfmbio_num_dum$DIAS.HOSP.MQ.DUM [ dfmbio_num_dum$DIAS.HOSP.MQ > 0 ] <- 1
dfmbio_num_dum$NUM.DIAS.POST.BIOP.DUM <- 0
dfmbio_num_dum$NUM.DIAS.POST.BIOP.DUM [ dfmbio_num_dum$NUM.DIAS.POST.BIOP > 0 ] <- 1
with( dfmbio_num_dum , table( HOSPITALIZACION , DIAS.HOSP.MQ.DUM ) )
with( dfmbio_num_dum , table( HOSPITALIZACION , NUM.DIAS.POST.BIOP.DUM ) )

###
### colinealidad entre variables independientes
###
with( dfmbio_num , table( PATR.RESIST , TIPO.CULTIVO ) )
with( dfmbio_num , table( PATR.RESIST , AGENTE.AISLADO ) )
with( dfmbio_num , table( PATR.RESIST , ITU ) )
with( dfmbio_num , table( FIEBRE , NUM.DIAS.POST.BIOP ) )
with( dfmbio_num , table( AGENTE.AISLADO , ITU ) )

###
### PCA
###

###
### PCA
### - agregar seccion PCA para separar nube de datos y comparar
###   con otros modelos la separacion
### - aplicar skewness para medir simetria y transformar variables
###   numericas en caso de ser necesario
### - las variables estan correlacionadas y poco significativas
###

### skewness variables numericas
#?e1071::skewness
posnum01 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[1] , colnames( dfmbio ) ) ### ANO.PROC
posnum02 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[2] , colnames( dfmbio ) ) ### EDAD
posnum03 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[3] , colnames( dfmbio ) ) ### PSA
posnum04 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[4] , colnames( dfmbio ) ) ### NUM.MUESTRAS
posnum05 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[5] , colnames( dfmbio ) ) ### DIAS.HOSP.MQ
posnum06 <- match( colnames( base::Filter( is.numeric , dfmbio ) )[6] , colnames( dfmbio ) ) ### DIAS.HOSP.UPC

### skewness
e1071::skewness( dfmbio [ , posnum01 ] ) ### ANO.PROC
e1071::skewness( dfmbio [ , posnum02 ] ) ### EDAD
e1071::skewness( dfmbio [ , posnum03 ] ) ### PSA
e1071::skewness( dfmbio [ , posnum04 ] ) ### NUM.MUESTRAS
e1071::skewness( dfmbio [ , posnum05 ] ) ### DIAS.HOSP.MQ
e1071::skewness( dfmbio [ , posnum06 ] ) ### DIAS.HOSP.UPC

### kurtosis
e1071::kurtosis( dfmbio [ , posnum01 ] ) ### ANO.PROC
e1071::kurtosis( dfmbio [ , posnum02 ] ) ### EDAD
e1071::kurtosis( dfmbio [ , posnum03 ] ) ### PSA
e1071::kurtosis( dfmbio [ , posnum04 ] ) ### NUM.MUESTRAS
e1071::kurtosis( dfmbio [ , posnum05 ] ) ### DIAS.HOSP.MQ
e1071::kurtosis( dfmbio [ , posnum06 ] ) ### DIAS.HOSP.UPC

### skewness
e1071::skewness( dfmbio_ctr [ , posnum01 ] ) ### ANO.PROC
e1071::skewness( dfmbio_ctr [ , posnum02 ] ) ### EDAD
e1071::skewness( dfmbio_ctr [ , posnum03 ] ) ### PSA
e1071::skewness( dfmbio_ctr [ , posnum04 ] ) ### NUM.MUESTRAS
e1071::skewness( dfmbio_ctr [ , posnum05 ] ) ### DIAS.HOSP.MQ
e1071::skewness( dfmbio_ctr [ , posnum06 ] ) ### DIAS.HOSP.UPC

### kurtosis
e1071::kurtosis( dfmbio_ctr [ , posnum01 ] ) ### ANO.PROC
e1071::kurtosis( dfmbio_ctr [ , posnum02 ] ) ### EDAD
e1071::kurtosis( dfmbio_ctr [ , posnum03 ] ) ### PSA
e1071::kurtosis( dfmbio_ctr [ , posnum04 ] ) ### NUM.MUESTRAS
e1071::kurtosis( dfmbio_ctr [ , posnum05 ] ) ### DIAS.HOSP.MQ
e1071::kurtosis( dfmbio_ctr [ , posnum06 ] ) ### DIAS.HOSP.UPC

library(forecast)
#?forecast::BoxCox
### - usar forecast en vez de MASS

### boxcox
BC.ANO.PROC      <- forecast::BoxCox( dfmbio [ , posnum01 ] , lambda = "auto" ) ### ANO.PROC
BC.EDAD          <- forecast::BoxCox( dfmbio [ , posnum02 ] , lambda = "auto" ) ### EDAD
BC.PSA           <- forecast::BoxCox( dfmbio [ , posnum03 ] , lambda = "auto" ) ### PSA
BC.NUM.MUESTRAS  <- forecast::BoxCox( dfmbio [ , posnum04 ] , lambda = "auto" ) ### NUM.MUESTRAS
BC.DIAS.HOSP.MQ  <- forecast::BoxCox( dfmbio [ , posnum05 ] , lambda = "auto" ) ### DIAS.HOSP.MQ
BC.DIAS.HOSP.UPC <- forecast::BoxCox( dfmbio [ , posnum06 ] , lambda = "auto" ) ### DIAS.HOSP.UPC

### skewness boxcox
e1071::skewness( BC.ANO.PROC      )
e1071::skewness( BC.EDAD          )
e1071::skewness( BC.PSA           )
e1071::skewness( BC.NUM.MUESTRAS  )
e1071::skewness( BC.DIAS.HOSP.MQ  )
e1071::skewness( BC.DIAS.HOSP.UPC )

### kurtosis boxcox
e1071::kurtosis( BC.ANO.PROC      )
e1071::kurtosis( BC.EDAD          )
e1071::kurtosis( BC.PSA           )
e1071::kurtosis( BC.NUM.MUESTRAS  )
e1071::kurtosis( BC.DIAS.HOSP.MQ  )
e1071::kurtosis( BC.DIAS.HOSP.UPC )

### #?MASS::boxcox
### set.seed(321)
### tmp <- exp(rnorm(10))
### out <- MASS::boxcox(lm(tmp~1))
### ran <- range( out$x[out$y > max(out$y)-qchisq(0.95,1)/2] )
### out$x [ match( out$x , ran ) ]
### vec <- c(99.64,49.71,246.84,96.17,16.67,352.00,421.25,81.77,105.00,37.85)
### out <- MASS::boxcox( lm( vec~1 ) )
### ran <- range( out$x[out$y > max(out$y)-qchisq(0.95,1)/2] )
### max( out$y )
### max( out$x )
### min( out$y )
### min( out$x )

library(polycor)
#?polycor::hetcor

### polycor::hetcor
### - objeto hetcor tiene 7 slots
### - faltaria aplanar matrix correlaciones heterogenea hetcor
###   y rankear segun mayor correlacion
str( dfmbio_ctr )
dfmbio_ctr_hetcor <- polycor::hetcor( dfmbio_ctr )
str( dfmbio_ctr_hetcor )
class( dfmbio_ctr_hetcor$correlations )

### library(homals)
### #?homals::homals
### length( dimnames( dfmbio_ctr )[[1]] )
### length( dimnames( dfmbio_ctr )[[2]] )
### dfmbio_ctr_homals <- homals::homals( dfmbio_ctr , active=c(rep(TRUE,20),FALSE) , sets=list(c(3:4,6:8,10:18,21),c(1:2,5,9,19:20)) )

library(Gifi)
#?Gifi::princals
#?Gifi::homals

dfmbio_ctr_princals <- Gifi::princals( dfmbio_ctr )
str(dfmbio_ctr_princals)
attributes(dfmbio_ctr_princals)
head( dfmbio_ctr_princals$loadings  )
plot( dfmbio_ctr_princals$evals , type="h" )
plot( dfmbio_ctr_princals , "screeplot" )
plot( dfmbio_ctr_princals , "biplot"    )
plot( dfmbio_ctr_princals , "loadplot"  )
plot( dfmbio_ctr_princals , "transplot" )
#dev.off()

library(stats)
str(dfmbio_num)
sort( unique( dfmbio_num$ANTIB.PROFI ) )
dfmbio_ctr_nnzv_prcomp <- stats::prcomp( dfmbio_ctr_nnzv )
dfmbio_num_prcomp <- stats::prcomp( dfmbio_num , scale=T )
str(dfmbio_num_prcomp)
head(dfmbio_num_prcomp$x)
plot(dfmbio_num_prcomp$sdev         )
plot( dfmbio_num_prcomp$x[,1] , jitter( dfmbio_num_prcomp$x[,2] ) )
attributes(dfmbio_num_prcomp)
summary(dfmbio_num_prcomp)
attributes(summary(dfmbio_num_prcomp))
dfmbio_num_prcomp$sdev
str(dfmbio_num_prcomp$sdev)
dfmbio_num_prcomp$rotation
dfmbio_num_prcomp$center
dfmbio_num_prcomp$scale
dfmbio_num_prcomp$x
dfmbio_num_prcomp[[5]]
plot(dfmbio_num_prcomp[[5]][,c(1,2)], col=c("red","green"))
plot(dfmbio_num_prcomp                                    )

###
### RFE
### - Recursive Feature Elimination (caret::rfe)
###
?caret::rfe
?caret::rfeControl
?caret::rfFuncs

# ensure results are repeatable
set.seed(7)
# load the library
#library(mlbench)
library(caret)
# load the dataset
#data(PimaIndiansDiabetes)
# prepare training scheme
lvqcontroltmp <- caret::trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
lvqmodeltmp <- caret::train(HOSPITALIZACION~., data=dfmbio_ctr_nnzv , method="lvq", preProcess="scale", trControl=lvqcontroltmp)
# estimate variable importance
lvqimportancetmp <- caret::varImp(lvqmodeltmp, scale=FALSE)
# summarize importance
print(lvqimportancetmp)
# plot importance
plot(lvqimportancetmp)

# ensure the results are repeatable
set.seed(7)
# load the library
#library(mlbench)
library(caret)
# load the data
#data(PimaIndiansDiabetes)
# define the control using a random forest selection function
rfecontroltmp <- caret::rfeControl(functions=caret::rfFuncs, method="repeatedcv", number=20, repeats=50)
# run the RFE algorithm
str( dfmbio_ctr      )
str( dfmbio_ctr_nnzv )
rferesultstmp <- caret::rfe( dfmbio_ctr     [,1:20] ,  dfmbio_ctr     [,21] , sizes=c(3,6,9,12,15,18), rfeControl=rfecontroltmp)
# summarize the results
print(rferesultstmp)
# list the chosen features
predictors(rferesultstmp)
# plot the results
plot(rferesultstmp, type=c("g", "o"))

library(AppliedPredictiveModeling)
AppliedPredictiveModeling::scriptLocation()

library(data.table)

###
### k-means ==> mlpack_kmeans
###
### Semillas k-means estimaciones intervalo
###

### semillas - ejecuta solo una vez - usar archivo creado
### semillas <- data.frame( semillas = round( runif( 50 , min=100000000 , max=999999999 ) , 0 ) )
### str( semillas )
### write.table( semillas , file="../csv/semillas.csv" , col.names=F , row.names=F , quote=F )
semillas <- read.table( file="../csv/semillas.csv" , header=F )
str(semillas)

### cargar clusters mlpack_kmeans y calcular silhouette
dfmbio_num_kmn0001 <- read.table( file="../csv/dfmbio_num_kmn0001.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0002 <- read.table( file="../csv/dfmbio_num_kmn0002.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0003 <- read.table( file="../csv/dfmbio_num_kmn0003.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0004 <- read.table( file="../csv/dfmbio_num_kmn0004.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0005 <- read.table( file="../csv/dfmbio_num_kmn0005.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0006 <- read.table( file="../csv/dfmbio_num_kmn0006.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0007 <- read.table( file="../csv/dfmbio_num_kmn0007.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0008 <- read.table( file="../csv/dfmbio_num_kmn0008.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0009 <- read.table( file="../csv/dfmbio_num_kmn0009.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0010 <- read.table( file="../csv/dfmbio_num_kmn0010.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0011 <- read.table( file="../csv/dfmbio_num_kmn0011.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0012 <- read.table( file="../csv/dfmbio_num_kmn0012.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0013 <- read.table( file="../csv/dfmbio_num_kmn0013.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0014 <- read.table( file="../csv/dfmbio_num_kmn0014.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0015 <- read.table( file="../csv/dfmbio_num_kmn0015.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0016 <- read.table( file="../csv/dfmbio_num_kmn0016.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0017 <- read.table( file="../csv/dfmbio_num_kmn0017.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0018 <- read.table( file="../csv/dfmbio_num_kmn0018.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0019 <- read.table( file="../csv/dfmbio_num_kmn0019.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0020 <- read.table( file="../csv/dfmbio_num_kmn0020.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0021 <- read.table( file="../csv/dfmbio_num_kmn0021.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0022 <- read.table( file="../csv/dfmbio_num_kmn0022.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0023 <- read.table( file="../csv/dfmbio_num_kmn0023.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0024 <- read.table( file="../csv/dfmbio_num_kmn0024.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0025 <- read.table( file="../csv/dfmbio_num_kmn0025.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0026 <- read.table( file="../csv/dfmbio_num_kmn0026.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0027 <- read.table( file="../csv/dfmbio_num_kmn0027.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0028 <- read.table( file="../csv/dfmbio_num_kmn0028.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0029 <- read.table( file="../csv/dfmbio_num_kmn0029.csv" , sep="," , header=F )[,22]
dfmbio_num_kmn0030 <- read.table( file="../csv/dfmbio_num_kmn0030.csv" , sep="," , header=F )[,22]

### extraer silhouette promedio
dfmbio_num_kmn0001_sil <- mean( cluster::silhouette( dfmbio_num_kmn0001 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0002_sil <- mean( cluster::silhouette( dfmbio_num_kmn0002 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0003_sil <- mean( cluster::silhouette( dfmbio_num_kmn0003 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0004_sil <- mean( cluster::silhouette( dfmbio_num_kmn0004 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0005_sil <- mean( cluster::silhouette( dfmbio_num_kmn0005 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0006_sil <- mean( cluster::silhouette( dfmbio_num_kmn0006 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0007_sil <- mean( cluster::silhouette( dfmbio_num_kmn0007 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0008_sil <- mean( cluster::silhouette( dfmbio_num_kmn0008 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0009_sil <- mean( cluster::silhouette( dfmbio_num_kmn0009 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0010_sil <- mean( cluster::silhouette( dfmbio_num_kmn0010 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0011_sil <- mean( cluster::silhouette( dfmbio_num_kmn0011 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0012_sil <- mean( cluster::silhouette( dfmbio_num_kmn0012 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0013_sil <- mean( cluster::silhouette( dfmbio_num_kmn0013 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0014_sil <- mean( cluster::silhouette( dfmbio_num_kmn0014 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0015_sil <- mean( cluster::silhouette( dfmbio_num_kmn0015 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0016_sil <- mean( cluster::silhouette( dfmbio_num_kmn0016 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0017_sil <- mean( cluster::silhouette( dfmbio_num_kmn0017 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0018_sil <- mean( cluster::silhouette( dfmbio_num_kmn0018 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0019_sil <- mean( cluster::silhouette( dfmbio_num_kmn0019 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0020_sil <- mean( cluster::silhouette( dfmbio_num_kmn0020 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0021_sil <- mean( cluster::silhouette( dfmbio_num_kmn0021 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0022_sil <- mean( cluster::silhouette( dfmbio_num_kmn0022 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0023_sil <- mean( cluster::silhouette( dfmbio_num_kmn0023 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0024_sil <- mean( cluster::silhouette( dfmbio_num_kmn0024 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0025_sil <- mean( cluster::silhouette( dfmbio_num_kmn0025 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0026_sil <- mean( cluster::silhouette( dfmbio_num_kmn0026 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0027_sil <- mean( cluster::silhouette( dfmbio_num_kmn0027 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0028_sil <- mean( cluster::silhouette( dfmbio_num_kmn0028 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0029_sil <- mean( cluster::silhouette( dfmbio_num_kmn0029 , dfmbio_num_dist )[,3] )
dfmbio_num_kmn0030_sil <- mean( cluster::silhouette( dfmbio_num_kmn0030 , dfmbio_num_dist )[,3] )

### concatenar silhouette promedio en data.frame
dfmbio_num_sed0001_sil <- data.frame( sil = rbind(
dfmbio_num_kmn0001_sil ,
dfmbio_num_kmn0002_sil ,
dfmbio_num_kmn0003_sil ,
dfmbio_num_kmn0004_sil ,
dfmbio_num_kmn0005_sil ,
dfmbio_num_kmn0006_sil ,
dfmbio_num_kmn0007_sil ,
dfmbio_num_kmn0008_sil ,
dfmbio_num_kmn0009_sil ,
dfmbio_num_kmn0010_sil ,
dfmbio_num_kmn0011_sil ,
dfmbio_num_kmn0012_sil ,
dfmbio_num_kmn0013_sil ,
dfmbio_num_kmn0014_sil ,
dfmbio_num_kmn0015_sil ,
dfmbio_num_kmn0016_sil ,
dfmbio_num_kmn0017_sil ,
dfmbio_num_kmn0018_sil ,
dfmbio_num_kmn0019_sil ,
dfmbio_num_kmn0020_sil ,
dfmbio_num_kmn0021_sil ,
dfmbio_num_kmn0022_sil ,
dfmbio_num_kmn0023_sil ,
dfmbio_num_kmn0024_sil ,
dfmbio_num_kmn0025_sil ,
dfmbio_num_kmn0026_sil ,
dfmbio_num_kmn0027_sil ,
dfmbio_num_kmn0028_sil ,
dfmbio_num_kmn0029_sil ,
dfmbio_num_kmn0030_sil ) )

### graficar silhouette promedio kmeans
plot( dfmbio_num_sed0001_sil$sil )
dfmbio_num_sed0001_sil_ord <- dplyr::arrange( dfmbio_num_sed0001_sil , desc( sil ) )
which( dfmbio_num_sed0001_sil$sil == dfmbio_num_sed0001_sil_ord[30,1] , arr.ind=T )
which( dfmbio_num_sed0001_sil$sil == dfmbio_num_sed0001_sil_ord[29,1] , arr.ind=T )
which( dfmbio_num_sed0001_sil$sil == dfmbio_num_sed0001_sil_ord[28,1] , arr.ind=T )

###
### Modelos
###

###
### Opcion 1
### - train = 2012
### - test  = 2013
###

### particion segun ano
with( dfmbio , table( HOSPITALIZACION , ANO.PROC ) )

# ### particion muestra segun ano - obsoleto
# dfmbio_tr <- dfmbio [ dfmbio$ANO.PROC == 2012 , ]
# dfmbio_ts <- dfmbio [ dfmbio$ANO.PROC == 2013 , ]
# str( dfmbio_tr )
# str( dfmbio_ts )
# dfmbio_tr_fac <- dfmbio_fac [ dfmbio_fac$ANO.PROC == 2012 , ]
# dfmbio_ts_fac <- dfmbio_fac [ dfmbio_fac$ANO.PROC == 2013 , ]
# str( dfmbio_tr_fac )
# str( dfmbio_ts_fac )
# dfmbio_tr_num <- dfmbio_num [ dfmbio_num$ANO.PROC == 2012 , ]
# dfmbio_ts_num <- dfmbio_num [ dfmbio_num$ANO.PROC == 2013 , ]
# str( dfmbio_tr_num )
# str( dfmbio_ts_num )

###
### Opcion 2
### - survival model
### - debieran ser mas observaciones en el tiempo
### - descartado - no aplica para esta muestra
###

###
### Opcion 3
### Modelo logistico penalizado
### - ridge , lasso , elastic net
### - library( glmnet )
###
library(glmnet)
#?stats::model.matrix
#?stats::model.frame
colnames(dfmbio_ctr) <- nombres_abreviados
dfmbio_ctr_x <- stats::model.matrix( HOSPITALIZACION ~ . , data = dfmbio_ctr )
dfmbio_ctr_y <- ifelse( dfmbio_ctr$HOSPITALIZACION == "SI" , 1 , 0 )
head(dfmbio_ctr_x,10)
class(dfmbio_ctr_x)
### creamos version con variables nzv excluidas
dfmbio_ctr_nnzv <- dfmbio_ctr [ , -caret::nearZeroVar( dfmbio_fac ) ]
dfmbio_ctr_nnzv$HOSPITALIZACION <- dfmbio_fac$HOSPITALIZACION
str( dfmbio_ctr_nnzv )
dfmbio_ctr_nnzv_x <- stats::model.matrix( HOSPITALIZACION ~ . , data = dfmbio_ctr_nnzv )
dfmbio_ctr_nnzv_y <- ifelse( dfmbio_ctr_nnzv$HOSPITALIZACION == "SI" , 1 , 0 )
head(dfmbio_ctr_nnzv_x,10)
class(dfmbio_ctr_nnzv_x)
#?MASS::birthwt
### comparar variables excluidas con modelo glm sin variables colineales
### - sigue estando FIEBRE aqui y no debiera por ser colineal con variable dependiente
data.frame(contrasts = names(attr(dfmbio_ctr_x,"contrasts")))
str(dfmbio_ctr_x)
str(dfmbio_ctr_y)
class(dfmbio_ctr_x)
class(dfmbio_ctr_y)
dfmbio_ctr_x[[2]]
head(dfmbio_ctr_x)
head(dfmbio_ctr_y)
dfmbio_ctr.glmnet0001 <- glmnet::glmnet(dfmbio_ctr_x, dfmbio_ctr_y, family = "binomial", alpha = 1, lambda = NULL)
coef(dfmbio_ctr.glmnet0001)
plot(dfmbio_ctr.glmnet0001)
set.seed(semillas[1,1])
dfmbio_ctr.cv.glmnet0001 <- glmnet::cv.glmnet( dfmbio_ctr_x , dfmbio_ctr_y , alpha = 1 , family = "binomial" )
plot(dfmbio_ctr.cv.glmnet0001)
dfmbio_ctr.cv.glmnet0001$lambda.min
dfmbio_ctr.glmnet0001.lambda <- glmnet::glmnet(dfmbio_ctr_x, dfmbio_ctr_y, family = "binomial", alpha = 1, lambda = dfmbio_ctr.cv.glmnet0001$lambda.min)

###
### Correlaciones
### - MASS::lda
###

### caret::nearZeroVar
#?caret::nearZeroVar
dfmbio_fac_nzv <- caret::nearZeroVar( dfmbio_fac , saveMetrics=T )
str(dfmbio_fac_nzv)
### variable con nzv
dfmbio_fac_nzv [ dfmbio_fac_nzv$nzv > 0 , ]
### variable sin nzv
dfmbio_fac_nzv [ dfmbio_fac_nzv$nzv == 0 , ]
### ordenar desc
#dfmbio_fac_nzv <- dplyr::arrange( dfmbio_fac_nzv , desc( percentUnique ) )
dfmbio_fac_nzv
str( dfmbio_fac [ , -caret::nearZeroVar( dfmbio_fac) ] )
dfmbio_fac_nnzv <- dfmbio_fac [ , -caret::nearZeroVar( dfmbio_fac) ]
### volvemos a agregar HOSPITALIZACION
dfmbio_fac_nnzv$HOSPITALIZACION <- dfmbio_fac$HOSPITALIZACION
str( dfmbio_fac_nnzv )

### caret::findLinearCombos
caret::findLinearCombos( dfmbio_num          )
caret::findLinearCombos( dfmbio_num[,-c(20)] )
colnames               ( dfmbio_num          )[20]

### MASS::lda
### - lda si requiere predict para generar clases y vector x (LDA)
library(MASS)
MASS::lm.ridge( HOSPITALIZACION ~ . , data = dfmbio_num )
### lda advierte que hay variables colineales
MASS::lda( HOSPITALIZACION ~ . , data = dfmbio_fac )
### excluir colineales con variable dependiente
### - FIEBRE                  : 14
### - DIAS.HOSP.MQ : 19
### - NUM.DIAS.POST.BIOP   : 13
### excluir colineales entre covariables
### - PATR.RESIST : 18
### excluimos algunas variables que hemos identificado
MASS::lda( HOSPITALIZACION ~ . , data = dfmbio_fac [ , -c(14,19,13,18) ] )
### probamos solamente con variables nnzv OK
### - graficar luego comparar con PCA y K-MEANS
### - ver enlaces
### ==> https://tgmstat.wordpress.com/2014/03/06/near-zero-variance-predictors/
### ==> https://tgmstat.wordpress.com/2014/01/15/computing-and-visualizing-lda-in-r/
#?MASS::lda

### LDA inicial con dataframe sin variables nzv
dfmbio_ctr_nnzv_lda01 <- MASS::lda( HOSPITALIZACION ~ . , data = dfmbio_ctr_nnzv                  )
### LDA tiene 10 slots
str(dfmbio_ctr_nnzv_lda01)
dfmbio_ctr_nnzv_lda01_pred <- predict( dfmbio_ctr_nnzv_lda01 , newdata=dfmbio_ctr_nnzv )
### LDA predict tiene 3 slots
str(dfmbio_ctr_nnzv_lda01_pred)
attributes(dfmbio_ctr_nnzv_lda01_pred)
levels(dfmbio_ctr_nnzv_lda01_pred$class)
### contar valores predichos por LDA
sum(dfmbio_ctr_nnzv_lda01_pred$class=="SI")
### tabular LDA versus observados
table(dfmbio_ctr_nnzv_lda01_pred$class , dfmbio_ctr_nnzv$HOSPITALIZACION, dnn=c("LDA","OBSERVADO") )
### precision LDA
mean(dfmbio_ctr_nnzv_lda01_pred$class == dfmbio_ctr_nnzv$HOSPITALIZACION )
### vector posterior que tiene 2 dimensiones reciprocas , no se puede graficar
dfmbio_ctr_nnzv_lda01_pred$posterior
### graficar scatter LD1 solo una dimension
dfmbio_ctr_nnzv_lda01_pred$x
plot( dfmbio_ctr_nnzv_lda01_pred$x                                            , ylab="LD1" , col=dfmbio_ctr_nnzv_lda01_pred$class )
legend('topright', legend = levels(dfmbio_ctr_nnzv_lda01_pred$class), col = 1:2, cex = 0.8, pch = 1)

### metricas usando caret::confusionMatrix para LDA
dfmbio_ctr_nnzv_lda01_confmat <- caret::confusionMatrix( dfmbio_ctr_nnzv_lda01_pred$class , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )
dfmbio_ctr_nnzv_lda01_confmat

### LDA pendientes
### - Crear varios LDA usando interacciones , sub muestreo
### - rankear esos modelos segun accuracy y listar metricas
### - crear dataframes o formulas o model.matrix
### - los datos numericos deben estar centrados
### - algunas variables factor podrian incluirse (grupo opcional),
###   otras no (grupo excluido), otras si (grupo incluido)

### Grupo incluido variables factor
### - DIABETES
### - BIOP.PREV
### - VOL.PROST
### - ANTIB.PROFI
### - BIOPSIA
### Grupo excluido variables factor
### - EPOC
### - NUM.DIAS.POST.BIOP
### - FIEBRE
### - TIPO.CULTIVO
### - AGENTE.AISLADO
### - PATR.RESIST
### Grupo opcional variables factor
### - HOSP.ULT.MES
### - CUP
### - ITU

### revisar dataframes
ls(                )[sapply(ls(), function(i) class(get(i))[1]) == "data.frame"]
ls(pattern="dfmbio")[sapply(ls(), function(i) class(get(i))[1]) == "data.frame"]
ls(                )[sapply(ls(), function(i) class(get(i))[1]) == "formula"]
ls(                )[sapply(ls(), function(i) class(get(i))[1]) == "glm"    ]
head  (ls(         )[sapply(ls(), function(i) class(get(i))[1]) == "glm"    ])
tail  (ls(         )[sapply(ls(), function(i) class(get(i))[1]) == "glm"    ])

#?stats::formula
frmtestnum <- stats::formula( HOSPITALIZACION ~ 0 + (ANO.PROC + EDAD)^2 )
colnames( model.matrix( frmtestnum , data = dfmbio_fac ) )
frmtestcat <- stats::formula( HOSPITALIZACION ~ 0 + ( DIABETES + BIOP.PREV + ANTIB.PROFI + VOL.PROST + BIOPSIA )^2 )
frmtestcat[[3]][[3]][[2]][[2]]
unlist(length(frmtestcat[[3]][[3]][[2]][[2]]))
lsttestcat <- c( "DIABETES" , "BIOP.PREV" , "ANTIB.PROFI" , "VOL.PROST" , "BIOPSIA" )
length(lsttestcat)
colnames( model.matrix( frmtestcat , data = dfmbio_fac ) )

### imprimir contenido de lista lsttestcat equivalente a nchoosek( 5 , 2) para strings
strfrminc=1
for( strfrmcol in 1:(length(lsttestcat)-1) ){
  for( strfrmrow in (1+strfrmcol):length(lsttestcat) ){
    print( paste0( lsttestcat[strfrmcol] , "*" , lsttestcat[strfrmrow] ) )
  # dfmbio_num_cor[strfrminc,1] <- rownames(lsttestcat)[strfrmrow]
  # dfmbio_num_cor[strfrminc,2] <- colnames(lsttestcat)[strfrmcol]
  # dfmbio_num_cor[strfrminc,3] <-          lsttestcat [strfrmrow,strfrmcol]
  # dfmbio_num_cor[strfrminc,4] <-          dfmbio_num_mat$P [strfrmrow,strfrmcol]
    strfrminc=strfrminc+1
  }
}

### incrementadores para editar bloque de formulas con vim
for(tstnum in 1:10){
  print( paste( (280*tstnum)+1 , (280*(tstnum+1)) ) )
}

### definir objetos formula
### - editar con archivo vim
###   EditarObjetosFormula.vim
### - total 3080 formulas
source( "ObjetosFormula.R" )
strnumfrm <- as.numeric( system( "wc -l < ObjetosFormula.R" , intern = TRUE ) )
class(strnumfrm)
strnumfrm

### model.matrix variable dependiente
mdm___y <- dfmbio_ctr_y

### objetos model.matrix podriamos evaluarlos con loop para evitar grandes listas
for(strmdminc in 1:strnumfrm){
  strfmtinc <- formatC( strmdminc , width=4, format="d" , flag="0" )
 #print( strfmtinc )
  strevlinc <- paste0( "mdm" , strfmtinc , " <- " , "model.matrix( frm" , strfmtinc , " , data = dfmbio_ctr )" )
  eval( parse( text = strevlinc ) )
}

### contabilizar model.matrix
length( ls( pattern="^mdm\\d+$" ) )
head( data.frame( modelos = ls( pattern="^mdm\\d+$" ) ) )
tail( data.frame( modelos = ls( pattern="^mdm\\d+$" ) ) )

### ### model.matrix para cada objeto formula modo lista - obsoleto
### mdm0001 <- model.matrix( frm0001 , data = dfmbio_ctr )
### mdm0002 <- model.matrix( frm0002 , data = dfmbio_ctr )
### mdm0003 <- model.matrix( frm0003 , data = dfmbio_ctr )
### mdm0098 <- model.matrix( frm0098 , data = dfmbio_ctr )
### mdm0099 <- model.matrix( frm0099 , data = dfmbio_ctr )
### mdm0100 <- model.matrix( frm0100 , data = dfmbio_ctr )

class(mdm0001)
class(mdm___y)

### Se observa del accuracy mas abajo que las variables colineales dan mayor precision
### modelos formula 4 , 6 , 7
### 3 mejores modelos: 55 , 57 , 58
### quitar el intercepto no tiene mayor relevancia y se quita porque las variables estan estandarizadas
### no hemos probado con ponderador aun
### ahora construir glmnet para ver si podemos incluir mas variables colineales
### partiendo desde las actuales y ver si podemos aumentar el accuracy un poco mas
### - se aumento la lista de model.matrix a 3080 manteniendo los primeros modelos que ya habian sido seleccionados

### definir objetos model.matrix a partir de objetos formula
### no es necesario al definir objetos formula
#?I

### contruiremos los modelos glm usando loop para los 3080 formulas
for(strglminc in 1:strnumfrm){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmevl <- paste0( "modglmfrm" , strglmfmt , " <- " , "stats::glm( formula = frm" , strglmfmt , " , data = dfmbio_ctr , binomial , maxit=100 )" )
  strglmevw <- paste0( "modglmfrw" , strglmfmt , " <- " , "stats::glm( formula = frm" , strglmfmt , " , data = dfmbio_ctr , binomial , maxit=100 , weights = dfmpnd$ponderador )" )
 #print( strglmevl )
 #print( strglmevw )
  eval( parse( text = strglmevl ) )
  eval( parse( text = strglmevw ) )
}

### contabilizar modelos glm
length( ls( pattern="^modglmfrm\\d+$" ) )
length( ls( pattern="^modglmfrw\\d+$" ) )
#head( data.frame( modelos = ls( pattern="^mdm\\d+$" ) ) )
#tail( data.frame( modelos = ls( pattern="^mdm\\d+$" ) ) )

### contabilizar modelos glm deben ser 3080*2
length(ls(pattern="^modglmfr[mw]\\d+$"))
3080*2
### contabilizar formulas multiplicar por 2
length(ls(pattern="^frm\\d+$"))*2

### probamos a priori cada formula usando glm
### str(modelo) tiene 30 slots
### str(summary(modelo)) tiene 17 slots
### - definiciones por modo lista estan obsoletas
### - conviene paralelizar for loop para modelos glm
### modglmfrm0001 <- stats::glm( formula = frm0001 , data = dfmbio_ctr , binomial , maxit=100 )
### modglmfrm0002 <- stats::glm( formula = frm0002 , data = dfmbio_ctr , binomial , maxit=100 )
### modglmfrm0003 <- stats::glm( formula = frm0003 , data = dfmbio_ctr , binomial , maxit=100 )
### modglmfrm0068 <- stats::glm( formula = frm0068 , data = dfmbio_ctr , binomial , maxit=100 )
### modglmfrm0069 <- stats::glm( formula = frm0069 , data = dfmbio_ctr , binomial , maxit=100 )
### modglmfrm0070 <- stats::glm( formula = frm0070 , data = dfmbio_ctr , binomial , maxit=100 )

### extraer resultados de glm
# str(summary(modglmfrm0001))
# str(        modglmfrm0001)
# modglmfrm0001$contrasts

### extraer deviance
### - solo para imprimir - obsoleto
### summary(modglmfrm0001)$deviance
### summary(modglmfrm0002)$deviance
### summary(modglmfrm0003)$deviance
### summary(modglmfrm0068)$deviance
### summary(modglmfrm0069)$deviance
### summary(modglmfrm0070)$deviance

envsess02 <- new.env()
length(ls(envsess02))

### Grabamos la rutina en archivo aparte
### - GlmRoc.R
### - depende en que environment esten los objetos
source( "GlmRoc.R" )

### Usando proporcion en best.weights tenemos la mejor estimacion
### hasta ahora. Pero necesitamos generalizar esto por medio de
### validacion cruzada , cross validation

#?base::detach
# proporcion
# 1-proporcion
#?caret::prSummary
#?pROC::roc
#?pROC::coords
ls(pattern="^modglmfr[mw]\\d+_pred$")[1]
str(modglmfrw0001_pred)
class(modglmfrw0001_pred)
head(modglmfrw0001_pred,25)
ls(pattern="^modglmfr[mw]\\d+_roc$")[1]
str(modglmfrw0001_roc)
class(modglmfrw0001_roc)
head(modglmfrw0001_roc[,1:5],25)
ls(pattern="^modglmfr[mw]\\d+_coords$")[1]
str(modglmfrw0001_coords)
class(modglmfrw0001_coords)
head(modglmfrw0001_coords[,1:5],25)

### Estos resultados pueden reemplazar las metricas inicialmente
### colectadas para los modelos glm. No incluyen cross validation
###

### Resuelto como grabar objetos desde environment hacia db .rdx/.rdb OK
length(ls(envsess02))/3
head(ls(envsess02))
tail(ls(envsess02))
tools:::makeLazyLoadDB( envsess02 , "envsess02" )
tools:::makeLazyLoadDB( envsess02 , "envsess02_objetos" )
#?base::lazyLoad

### Resuelto como cargar desde db .rdx/.rdb hacia environment OK
envsess02 <- new.env()
base::lazyLoad( "envsess02" , envir = envsess02 )
length(ls(envsess02))/3
### cargar sesion01
envsess01 <- new.env()
base::lazyLoad( "Sesion" , envir = envsess01 )
length(ls(envsess01))

###
### Matriz de confusion modo texto
###
cmat <- matrix( c( 'TP' , 'FP' , 'FN' , 'TN' ) , ncol=2 , nrow=2 , byrow=T )
colnames( cmat ) <- c( 'SI' , 'NO' )
rownames( cmat ) <- c( 'SI' , 'NO' )
cmat
cmat <- as.table(cmat)
names(attributes(cmat)$dimnames) <- c( "Pred" , "Obs" )
cmat
cmat[2:1,2:1]

### grabar en environment auxiliar
env_aux <- new.env()
assign( "cmat" , cmat , envir = env_aux )
tools:::makeLazyLoadDB( env_aux , "rdb/env_aux" )

### cargar en nueva sesion
env_aux <- new.env()
base::lazyLoad( "rdb/env_aux" , envir = env_aux )

### render table con dimnames
### - pander no sirve
#library(pander)
#?pander::pander(ftable())
### - xtable soporta latex
library(xtable)
#xtable::xtable( env_aux$cmat )

assign( "cmat" , env_aux$cmat , envir = .GlobalEnv )

cmat_addtorow <- list()
cmat_addtorow$pos <- list(0, 0)
cmat_addtorow$command <- c("&\\multicolumn{2}{c}{Obs} \\\\\n","Pred& SI & NO\\\\\n")
print( xtable::xtable( cmat ), add.to.row = cmat_addtorow , include.colnames = FALSE )
cmat_addtorow

cmat_invtorow <- list()
cmat_invtorow$pos <- list(0, 0)
cmat_invtorow$command <- c("&\\multicolumn{2}{c}{Obs} \\\\\n","Pred& NO & SI\\\\\n")
print( xtable::xtable( cmat[2:1,2:1] ), add.to.row = cmat_invtorow , include.colnames = FALSE )
cmat_invtorow

ls( envir = env_aux )

assign( "cmat" , cmat , envir = env_aux )
assign( "cmat_addtorow" , cmat_addtorow , envir = env_aux )
assign( "cmat_invtorow" , cmat_invtorow , envir = env_aux )

tools:::makeLazyLoadDB( env_aux , "rdb/env_aux" )

### generar coords glm usando for loop pendiente
### - para usar con punto de corte optimo ==> pROC::coords
for(strglminc in 1:5){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmevl <- paste0( "modglmfrm" , strglmfmt , "_roc <- pROC::roc( modglmfrm" , strglmfmt , "$fitted.values >= .5 , \"SI\" , \"NO\" ) )" )
  strglmevw <- paste0( "modglmfrw" , strglmfmt , "_roc <- pROC::roc( modglmfrw" , strglmfmt , "$fitted.values >= .5 , \"SI\" , \"NO\" ) )" )
  print( strglmevl )
  print( strglmevw )
 #eval( parse( text = strglmevl ) )
 #eval( parse( text = strglmevw ) )
}

### generar clases glm usando for loop
### - punto de corte 0.5 por defecto
### - se agrego estimacion de punto de corte optimo mas arriba
### - faltaria cross validation
for(strglminc in 1:strnumfrm){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmevl <- paste0( "modglmfrm" , strglmfmt , "_class <- " , "factor( ifelse( modglmfrm" , strglmfmt , "$fitted.values >= .5 , \"SI\" , \"NO\" ) )" )
  strglmevw <- paste0( "modglmfrw" , strglmfmt , "_class <- " , "factor( ifelse( modglmfrw" , strglmfmt , "$fitted.values >= .5 , \"SI\" , \"NO\" ) )" )
 #print( strglmevl )
 #print( strglmevw )
  eval( parse( text = strglmevl ) )
  eval( parse( text = strglmevw ) )
}

### contabilizar clases glm
length( ls( pattern="^modglmfrm\\d+_class$" ) )
length( ls( pattern="^modglmfrw\\d+_class$" ) )

### generar clases para crear caret::confusionMatrix
### - obsoleto
### modglmfrm0001_class <- factor( ifelse( modglmfrm0001$fitted.values >= .5 , "SI" , "NO" ) )
### modglmfrm0002_class <- factor( ifelse( modglmfrm0002$fitted.values >= .5 , "SI" , "NO" ) )
### modglmfrm0003_class <- factor( ifelse( modglmfrm0003$fitted.values >= .5 , "SI" , "NO" ) )
### modglmfrm0068_class <- factor( ifelse( modglmfrm0068$fitted.values >= .5 , "SI" , "NO" ) )
### modglmfrm0069_class <- factor( ifelse( modglmfrm0069$fitted.values >= .5 , "SI" , "NO" ) )
### modglmfrm0070_class <- factor( ifelse( modglmfrm0070$fitted.values >= .5 , "SI" , "NO" ) )

### generar confmat glm usando for loop
for(strglminc in 1:strnumfrm){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmevl <- paste0( "modglmfrm" , strglmfmt , "_confmat <- " , "caret::confusionMatrix( modglmfrm" , strglmfmt , "_class , dfmbio_ctr$HOSPITALIZACION , positive = \"SI\" )" )
  strglmevw <- paste0( "modglmfrw" , strglmfmt , "_confmat <- " , "caret::confusionMatrix( modglmfrw" , strglmfmt , "_class , dfmbio_ctr$HOSPITALIZACION , positive = \"SI\" )" )
 #print( strglmevl )
 #print( strglmevw )
  eval( parse( text = strglmevl ) )
  eval( parse( text = strglmevw ) )
}

### contabilizar confmat glm
length( ls( pattern="^modglmfrm\\d+_confmat$" ) )
length( ls( pattern="^modglmfrw\\d+_confmat$" ) )

### caret::confusionMatrix para glm
### - obsoleto
### modglmfrm0001_confmat <- caret::confusionMatrix( modglmfrm0001_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
### modglmfrm0002_confmat <- caret::confusionMatrix( modglmfrm0002_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
### modglmfrm0003_confmat <- caret::confusionMatrix( modglmfrm0003_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
### modglmfrm0068_confmat <- caret::confusionMatrix( modglmfrm0068_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
### modglmfrm0069_confmat <- caret::confusionMatrix( modglmfrm0069_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
### modglmfrm0070_confmat <- caret::confusionMatrix( modglmfrm0070_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )

### metricas glm
### - no usar , solo para imprimir
### modglmfrm0001_confmat$overall[[1]]
### modglmfrm0002_confmat$overall[[1]]
### modglmfrm0003_confmat$overall[[1]]
### modglmfrm0068_confmat$overall[[1]]
### modglmfrm0069_confmat$overall[[1]]
### modglmfrm0070_confmat$overall[[1]]

###
### Metricas para clases imbalanceadas
### - sugieren usar PR-AUC en vez de SP-AUC. Ver fuente:
###   https://dpmartin42.github.io/posts/r/imbalanced-classes-part-2
###
library(pROC)
library(PRROC)
#?pROC::roc
#?pROC::coords

###
### Grabar objetos en bases rdb/rdx
###

###
### Grabar sesiones separadas
### - no se puede insertar objetos en .rdb
### - problema de compilacion R CMD SHLIB
###   undefined symbol : known_to_be_utf8
### - luego convertir a .rdx/.rdb
###

# ### agregar nuevos objetos en .rdx/.rdb
# test01 <- "x"
# save.image("test.RData")
# test = local({load("test.RData"); environment()})
# test = local({ls(); environment()})
# class(test)
# test
# class(test$test01)
# test01
# ?base::local
# ?base::new.env
# ls()
# test02 <- "y"
# tools:::makeLazyLoadDB(test, "test" )
# .Call( "R_lazyLoadDBinsertValue" , test02 , test )
# ?base::lazyLoadDBexec
# ?base::delayedAssign
# base::lazyLoad("test")
# ls()

### Reunir objetos sesion01 y crear nueva sesion02
envsess01 <- new.env()
base::lazyLoad( "Sesion" , envir = envsess01 )
length(ls(envsess01))
pryr::mem_used()
savehistory()
### Evitar grabar todo - muy lento
### save.image("Sesion.RData")
### Habra que guardar objetos uno por uno
### o de a varios siguiendo un patron
load( "Sesion02.RData" )
sesion02 = local({load("Sesion02.RData"); environment()})
tools:::makeLazyLoadDB( sesion02 , "Sesion02" )
savehistory()
### volver a iniciar R
base::lazyLoad( "Sesion"   , envir = envsess01 )
base::lazyLoad( "Sesion02" , envir = envsess02 )
length(ls())
pryr::mem_used()
savehistory()
#ls()
#ls(                )[sapply(ls(), function(i) class(get(i))[1]) == "data.frame"]

###
### glmnet usando caret + glmnet
###

###
### Cost-Sensitive Training
### - Esto difiere del uso de curva PR-AUC,
###   porque aqui no se calculan probabilidades y puede aplicarse con SVM
###   Ver fuente: APM capitulo 16. Remedies for severe class imbalance
###               APM capitulo 16.8. Cost-Sensitive Training
###

### extraccion metricas modelos glm
### - incorporar ultimos pasos en esta rutina
### source( "GlmPrecision.R" )

###
### Cross validation
###
### - vamos a elegir 1 o 2 modelos solamente
### - la particion que usaremos la tomamos del cap 19.2, porque la muestra es de similar tamaño
###

library(caret)
set.seed(999)
split <- caret::createDataPartition( envsess01$dfmbio_ctr$HOSPITALIZACION , p = .8 , list = FALSE )
length(split)
str(split)

### particionar dfmbio_ctr
dfmbio_ctr_tr <- envsess01$dfmbio_ctr   [ split, ]
dfmbio_ctr_te <- envsess01$dfmbio_ctr   [-split, ]
str(dfmbio_ctr_tr)
str(dfmbio_ctr_te)
dim(dfmbio_ctr_tr)
dim(dfmbio_ctr_te)

### separar grupo de predictores
predVars <- names(dfmbio_ctr_tr)[!(names(dfmbio_ctr_tr) %in% c("HOSPITALIZACION"))]
predVars

?caret::trainControl
?caret::train

### - modelo fue nombrado glm pero debemos usar gnt para glmnet
### - cuando use la funcion trainControl no fue necesario especificar la
### particion, al elegir repeatedcv se seleccionan las particiones o folds
### automaticamente

set.seed(123)
modglmcvw2584_seeds <- vector(mode = "list", length = 50)
for(i in 1:51) modglmcvw2584_seeds[[i]] <- sample.int(1000, 7)

modglmcvw2584_ctrl <- caret::trainControl( method = "repeatedcv" ,
                                           repeats = 5 ,
                                           verboseIter = TRUE ,
                                           classProbs = TRUE ,
                                           seeds = modglmcvw2584_seeds )
### que tamaño debe tener el vector seeds?

### seeds debe ser usado con parallel
library(doMC)
registerDoMC(4)

envsess01$frm2584
str( envsess01$dfmbio_ctr )

modglmcvw2584_grid <- expand.grid(alpha = c(0,  .1,  .2, .4, .6, .8, 1),
                                  lambda = seq(.01, .2, length = 40))

set.seed(2121)
modglmcvw2584_train <- caret::train( envsess01$frm2584 , data = envsess01$dfmbio_ctr ,
                                           method = "glmnet" ,
                                           tuneGrid = modglmcvw2584_grid ,
                                           maxit = 1000 ,
                                           weights = envsess01$dfmpnd$ponderador ,
                                           metric = "Accuracy" ,
                                           trControl = modglmcvw2584_ctrl )
### tuneLength : genera 12 valores para alpha y 12 valores para lambda
### - la alternativa es usar tuneGrid para definir las combinaciones que uno desee para los dos parametros
### - si quiero replicar el grafico 12.16 debo usar la misma grilla : tuneLength ==> tuneGrid OK

### inspeccionamos resultado
modglmcvw2584_train
attributes(modglmcvw2584_train)
head(modglmcvw2584_train)

### preparar resultado para grafico heatmap
### - solo lambda se debe redondear porque alpha son muy pocos valores en la grilla como para 3 decimales o mas
### - _object quedara para plot
### - _results quedaria para otro proposito o se eliminara
modglmcvw2584_train_object <- modglmcvw2584_train
modglmcvw2584_train_object$results$lambda <- format(round(modglmcvw2584_train_object$results$lambda, 3))
modglmcvw2584_train_object$results$alpha  <- format(round(modglmcvw2584_train_object$results$alpha , 3))
head(modglmcvw2584_train_object$results)
dim(modglmcvw2584_train_object$results)
length(sort(unique(modglmcvw2584_train$results$alpha )))
length(sort(unique(modglmcvw2584_train$results$lambda)))

assign( "modglmcvw2584_train_object" , env_modglmcvw2584$modglmcvw2584_train_object , envir = .GlobalEnv )
str(modglmcvw2584_train_object$finalModel)
str(modglmcvw2584_train_object$finalModel$beta)
colSums( modglmcvw2584_train_object$finalModel$beta != 0 )
modglmcvw2584_train_object$finalModel$beta[,43]

### revisamos otros colores para el grafico
library(RColorBrewer)
brewer.pal.info
display.brewer.all()
str(brewer.pal.info)
spec <-     colorRampPalette(brewer.pal( 11 , "Spectral" ))(16)
set3 <- rev(colorRampPalette(brewer.pal( 12 , "Set3"     ))(16))
pair <- rev(colorRampPalette(brewer.pal( 12 , "Paired"   ))(16))
colr <-     colorRampPalette(brewer.pal(  9 , "Reds"     ))(16)
colb <-     colorRampPalette(brewer.pal(  9 , "Blues"    ))(16)
colp <-     colorRampPalette(brewer.pal( 11 , "PiYG"     ))(16)
### revisar colores elegidos
plot(1:16,type="h",lwd=30,col=spec)
modglmcvw2584_grid_color <- spec
#?grDevices::colorRampPalette
#?base::rev

### grafico 12.16 panel superior
### - requiere argumento sea el objeto completo train , no solo el dataframe
### - la funcion es caret y usa lattice o ggplot2
### - el argumento que faltaba era: col.regions
env_modglmcvw2584$modglmcvw2584_train_plot <- caret::plot.train(
                 env_modglmcvw2584$modglmcvw2584_train_object ,
                 pch = 21 , bg = "red" ,
                 plotType = "level" ,
                 cuts = 15 ,
                 scales = list(x = list(rot = 90, cex = .65)) ,
                 col.regions = env_modglmcvw2584$modglmcvw2584_grid_color
                 )
env_modglmcvw2584$modglmcvw2584_train_plot <- lattice:::update.trellis(
        env_modglmcvw2584$modglmcvw2584_train_plot ,
        xlab = "Nivel de Regularización lambda" ,
        ylab = "Porcentaje alpha\nRidge <---------> Lasso" ,
        main = "Area Bajo la curva ROC" ,
        sub = "Modelo modglmcvw2584"
        )
env_modglmcvw2584$modglmcvw2584_train_plot

### consultar grilla resultado modelos glmnet
sqldf::sqldf("select *
              from modglmcvw2584_train_object
              group by alpha, lambda
              order by alpha asc
              ")

### grabar objetos y grafico
ls( pattern = "cv" )
env_modglmcvw2584 <- new.env()
assign( "modglmcvw2584_ctrl"         , modglmcvw2584_ctrl         , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_grid"         , modglmcvw2584_grid         , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_grid_color"   , modglmcvw2584_grid_color   , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_seeds"        , modglmcvw2584_seeds        , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_train"        , modglmcvw2584_train        , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_train_object" , modglmcvw2584_train_object , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_train_plot"   , modglmcvw2584_train_plot   , envir = env_modglmcvw2584 )
ls( envir = env_modglmcvw2584 )
tools:::makeLazyLoadDB( env_modglmcvw2584 , "rdb/env_modglmcvw2584" )

### volver a cargar nueva sesion
### - agregado a Environments.R
env_modglmcvw2584 <- new.env()
base::lazyLoad( "rdb/env_modglmcvw2584" , envir = env_modglmcvw2584 )
assign( "modglmcvw2584_ctrl"         , env_modglmcvw2584$modglmcvw2584_ctrl         , envir = .GlobalEnv )
assign( "modglmcvw2584_train"        , env_modglmcvw2584$modglmcvw2584_train        , envir = .GlobalEnv )
assign( "modglmcvw2584_train_object" , env_modglmcvw2584$modglmcvw2584_train_object , envir = .GlobalEnv )
assign( "modglmcvw2584_train_plot"   , env_modglmcvw2584$modglmcvw2584_train_plot   , envir = .GlobalEnv )
assign( "modglmcvw2584_grid"         , env_modglmcvw2584$modglmcvw2584_grid         , envir = .GlobalEnv )


###
### glmnet revision glmnet inicial
###

### objetos glmnet grabados en entorno envsess01
### - primera estimacion solo seleccion de primeras 70 formulas
### - variables no han sido renombradas
### - tengo 3080 formulas, pero necesito ejecutar de otra manera este metodo
### - comparando 2 modelos entre ambos metodos
###   - gnt muestra solamente variables, mientras cvw muestra dummies
###     ==> https://github.com/hong-revo/glmnetUtils
str( modgntfrm0045 )              ### 13 slots
str( modglmcvw2584_train_object ) ### 24 slots
length( ls( pattern = "^modgntfrm\\d+$"            , envir = envsess01 ) ) ### 70 objetos
length( ls( pattern = "^modgntfrm\\d+_pred$"       , envir = envsess01 ) ) ### 70 objetos
length( ls( pattern = "^modgntfrm\\d+_class$"      , envir = envsess01 ) ) ### 70 objetos
length( ls( pattern = "^modgntfrm\\d+_confmat$"    , envir = envsess01 ) ) ### 70 objetos
length( ls( pattern = "^modgntfrm\\d+_lambda_min$" , envir = envsess01 ) ) ### 70 objetos

### revisando uno al azar
### - tenemos una tabla de resultados que no tiene deviance solo con 70 modelos
### - se espera alguna mejora minima en la configuracion de los 6160 modelos
### - se recomienda reescribir para 6160 modelos en archivo aparte ==> glmnetPrecision.R
### - se espera usar grid con 280 valores: 40 lambda x 7 alpha
glmnet::glmnet.control()
glmnet:::deviance.glmnet( envsess01$modgntfrm0045 )
class( envsess01$modgntfrm0045 )
str( envsess01$modgntfrm0045 )
assign( "modgntfrm0045_lambda_min" , envsess01$modgntfrm0045_lambda_min , envir = .GlobalEnv )
assign( "modgntfrm0045"            , envsess01$modgntfrm0045            , envir = .GlobalEnv )
### El valor de s cambia de modo que mas variables se vuelven significativas
str( modgntfrm0045_lambda_min$glmnet.fit$beta )
colSums( modgntfrm0045_lambda_min$glmnet.fit$beta != 0 )
sum( colSums( modgntfrm0045_lambda_min$glmnet.fit$beta != 0 ) )
modgntfrm0045_lambda_min$glmnet.fit$beta@i
modgntfrm0045_lambda_min$glmnet.fit$beta@i[1:10]
max(modgntfrm0045_lambda_min$glmnet.fit$beta@x)
min(modgntfrm0045_lambda_min$glmnet.fit$beta@x)
mean(modgntfrm0045_lambda_min$glmnet.fit$beta@x)
glmnet::coef.glmnet( modgntfrm0045 , s = 0.01                                             )
modgntfrm0045_lambda_min$glmnet.fit$beta[,99:100]

### queremos usar metodo caret train
assign( "modglmfrw2584"              , envsess01        $modglmfrw2584              , envir = .GlobalEnv )
assign( "modglmcvw2584_train_object" , env_modglmcvw2584$modglmcvw2584_train_object , envir = .GlobalEnv )
modglmcvw2584_train_object$bestTune
modglmcvw2584_train_object$pred
str( modglmcvw2584_train_object )
str( modglmcvw2584_train_object$finalModel )
min(modglmcvw2584_train_object$finalModel$lambda) == modglmcvw2584_train_object$finalModel$lambda[44]
glmnet::coef.glmnet( modglmcvw2584_train_object$finalModel , s = 0.004 )
data.frame( coef = modglmfrw2584$coefficients )

###
### glmnet usando glmnet
###

library(doMC)
registerDoMC(4)

### contruiremos los modelos gnt usando loop para los 3080 formulas
for(strgntinc in 1:5        ){
  strgntfmt <- formatC( strgntinc , width=4, format="d" , flag="0" )
  strgntevl <- paste0( "modgntfrm" , strgntfmt , "_cva <- " , "glmnetUtils::cva.glmnet( formula = envsess01$frm" , strgntfmt , " , intercept = FALSE , data = envsess01$dfmbio_ctr , family=\"binomial\" , nfolds=5 , lambda = 10^seq(1, -6, length = 40) , alpha = c(0, .1, .2, .4, .6, .8, 1) , parallel=TRUE )" )
  strgntevw <- paste0( "modgntfrw" , strgntfmt , "_cva <- " , "glmnetUtils::cva.glmnet( formula = envsess01$frm" , strgntfmt , " , intercept = FALSE , data = envsess01$dfmbio_ctr , family=\"binomial\" , nfolds=5 , lambda = 10^seq(1, -6, length = 40) , alpha = c(0, .1, .2, .4, .6, .8, 1) , parallel=TRUE , weights = envsess01$dfmpnd$ponderador )" )
 #print( strgntevl )
 #print( strgntevw )
  eval( parse( text = strgntevl ) )
  eval( parse( text = strgntevw ) )
}

str( modgntfrm0001_cva                          ) ### 9 slots
str( modgntfrm0001_cva$modlist                  ) ### 7 slots o los que se definan = alpha
str( modgntfrm0001_cva$modlist[[ 2]]            )
modgntfrm0001_cva$modlist[[ 2]]$glmnet.fit$lambda
modgntfrm0001_cva$modlist[[ 2]]$glmnet.fit$beta@x
plot( modgntfrm0001_cva $modlist[[ 2]] $cvm )
plot( modgntfrm0001_cva $modlist[[ 2]]      )
plot( modgntfrm0001_cva                     )

glmnet:::coef.glmnet( modgntfrm0001_cva $modlist[[2]]        , s = .000001 )  ### dgCMatrix definitivo
                      modgntfrm0001_cva $modlist[[2]] $glmnet.fit $beta[,40]  ### vector

10^seq(1,-6, length=40)
log(10)
log(.2)
log(.5)
log(.00002)
log(.00001)
exp(-1)

glmnet:::deviance.glmnet( modgntfrm0001_cva$modlist[[ 7]]$glmnet.fit            )

vec.lambda = seq(.00001, .4, length = 40)
vec.lambda
vec.alpha = c(0,  .1,  .2, .4, .6, .8, 1)
vec.alpha

### deviance menor de la serie lambda
### siempre la deviance menor es la ultima puesto que lambda menor es el ultimo
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[1]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[1]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[2]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[2]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[3]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[3]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[4]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[4]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[5]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[5]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[6]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[6]]  $glmnet.fit )[40]
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[7]]  $glmnet.fit ) ) == glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[7]]  $glmnet.fit )[40]

### deviance menor de la serie alpha
which.min(
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[1]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[2]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[3]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[4]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[5]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[6]]  $glmnet.fit ) ) ,
min( glmnet:::deviance.glmnet( modgntfrm0001_cva $modlist[[7]]  $glmnet.fit ) )
)

paste( max( modgntfrm0001_cva$modlist[[1]]  $lambda ) , min( modgntfrm0001_cva$modlist[[1]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[2]]  $lambda ) , min( modgntfrm0001_cva$modlist[[2]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[3]]  $lambda ) , min( modgntfrm0001_cva$modlist[[3]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[4]]  $lambda ) , min( modgntfrm0001_cva$modlist[[4]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[5]]  $lambda ) , min( modgntfrm0001_cva$modlist[[5]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[6]]  $lambda ) , min( modgntfrm0001_cva$modlist[[6]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[7]]  $lambda ) , min( modgntfrm0001_cva$modlist[[7]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[8]]  $lambda ) , min( modgntfrm0001_cva$modlist[[8]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[9]]  $lambda ) , min( modgntfrm0001_cva$modlist[[9]]  $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[10]] $lambda ) , min( modgntfrm0001_cva$modlist[[10]] $lambda ) )
paste( max( modgntfrm0001_cva$modlist[[11]] $lambda ) , min( modgntfrm0001_cva$modlist[[11]] $lambda ) )

### contruiremos los modelos gnt usando loop para los 3080 formulas
for(strgntinc in 1:5        ){
  strgntfmt <- formatC( strgntinc , width=4, format="d" , flag="0" )
  strgntevl <- paste0( "modgntfrm" , strgntfmt , "_cv <- " , "glmnetUtils::cv.glmnet( formula = envsess01$frm" , strgntfmt , " , intercept = FALSE , data = envsess01$dfmbio_ctr , family=\"binomial\" , nfolds=5 , lambda = 10^seq(1, -6, length = 40) , parallel=TRUE )" )
  strgntevw <- paste0( "modgntfrw" , strgntfmt , "_cv <- " , "glmnetUtils::cv.glmnet( formula = envsess01$frm" , strgntfmt , " , intercept = FALSE , data = envsess01$dfmbio_ctr , family=\"binomial\" , nfolds=5 , lambda = 10^seq(1, -6, length = 40) , parallel=TRUE , weights = envsess01$dfmpnd$ponderador )" )
 #print( strgntevl )
 #print( strgntevw )
  eval( parse( text = strgntevl ) )
  eval( parse( text = strgntevw ) )
}

str( modgntfrm0001_cv            )
str( modgntfrm0001_cv$glmnet.fit )
colSums( modgntfrm0001_cv$glmnet.fit$beta != 0 )
glmnet:::deviance.glmnet( modgntfrm0001_cv$glmnet.fit               )
glmnet:::coef.glmnet(     modgntfrm0001_cv$glmnet.fit , s = .000001 )
assign( "modglmfrm0001" , envsess01 $modglmfrm0001 , envir = .GlobalEnv )
data.frame( coef = modglmfrm0001$coefficients )
str( modglmfrm0001 )
str( summary( modglmfrm0001 ) )
modglmfrm0001$contrasts
modglmfrm0001$xlevels
str( envsess01$dfmbio_ctr$DIABETES )
str( envsess01$dfmbio_ctr_nnzv$DIABETES )
options("contrasts")
data.frame( coef = colnames( model.matrix( envsess01$frm0001 , data = envsess01$dfmbio_ctr ) ) )

str( model.matrix( envsess01$frm0001 , data = envsess01$dfmbio_ctr ) )

?formula
?relevel
?contr.treatment

frmtmp <- formula( HOSPITALIZACION ~     ANO.PROC + EDAD + PSA + NUM.MUESTRAS + DIABETES + BIOP.PREV + ANTIB.PROFI + VOL.PROST + BIOPSIA )
str( model.matrix( frmtmp , data = envsess01$dfmbio_ctr ) )

frmint <- formula( HOSPITALIZACION ~     ANO.PROC + EDAD + PSA + NUM.MUESTRAS + DIABETES + BIOP.PREV + ANTIB.PROFI + VOL.PROST + BIOPSIA - 1 )
str( model.matrix( frmint , data = envsess01$dfmbio_ctr ) )

data.frame(
dimnames = attr( model.matrix( frmtmp , data = envsess01$dfmbio_ctr ) , "dimnames" )[[2]] ,
assign   = attr( model.matrix( frmtmp , data = envsess01$dfmbio_ctr ) , "assign" )
)

data.frame(
dimnames = attr( model.matrix( frmint , data = envsess01$dfmbio_ctr ) , "dimnames" )[[2]] ,
assign   = attr( model.matrix( frmint , data = envsess01$dfmbio_ctr ) , "assign" )
)

data.frame(
dimnames = attr( model.matrix( envsess01$frm0001 , data = envsess01$dfmbio_ctr ) , "dimnames" )[[2]] ,
assign = attr( model.matrix( envsess01$frm0001 , data = envsess01$dfmbio_ctr ) , "assign" )
)

debug_contr_error2( frm0001 )

sum( modgntfrm0001_cv $glmnet.fit       $beta@i )
min( modgntfrm0001_cv $glmnet.fit       $lambda )
     modgntfrm0001_cv $glmnet.fit       $beta[,40]
min( modgntfrm0001_cv $glmnet.fit[[4]]  $lambda )
min( modgntfrm0001_cv $glmnet.fit[[5]]  $lambda )
min( modgntfrm0001_cv $glmnet.fit[[6]]  $lambda )
plot( modgntfrm0001_cv                           )

### cv.glmnet lambda min obsoleto
set.seed(semillas[45,1]) ; modgntfrm0001_lambda_min <- glmnet::cv.glmnet( mdm0001 , mdm___y , alpha = 1 , family = "binomial" )
set.seed(semillas[45,1]) ; modgntfrm0002_lambda_min <- glmnet::cv.glmnet( mdm0002 , mdm___y , alpha = 1 , family = "binomial" )
set.seed(semillas[45,1]) ; modgntfrm0003_lambda_min <- glmnet::cv.glmnet( mdm0003 , mdm___y , alpha = 1 , family = "binomial" )
set.seed(semillas[45,1]) ; modgntfrm0068_lambda_min <- glmnet::cv.glmnet( mdm0068 , mdm___y , alpha = 1 , family = "binomial" )
set.seed(semillas[45,1]) ; modgntfrm0069_lambda_min <- glmnet::cv.glmnet( mdm0069 , mdm___y , alpha = 1 , family = "binomial" )
set.seed(semillas[45,1]) ; modgntfrm0070_lambda_min <- glmnet::cv.glmnet( mdm0070 , mdm___y , alpha = 1 , family = "binomial" )

#?glmnet::glmnet
#?glmnet::predict.glmnet
### modelos glmnet usando formulas
### requiere model.matrix a partir de formula sin dataframe
modgntfrm0001 <- glmnet::glmnet( mdm0001 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0001_lambda_min$lambda) )
modgntfrm0002 <- glmnet::glmnet( mdm0002 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0002_lambda_min$lambda) )
modgntfrm0003 <- glmnet::glmnet( mdm0003 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0003_lambda_min$lambda) )
modgntfrm0004 <- glmnet::glmnet( mdm0004 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0004_lambda_min$lambda) )
modgntfrm0005 <- glmnet::glmnet( mdm0005 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0005_lambda_min$lambda) )
modgntfrm0006 <- glmnet::glmnet( mdm0006 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0006_lambda_min$lambda) )
modgntfrm0007 <- glmnet::glmnet( mdm0007 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0007_lambda_min$lambda) )
modgntfrm0008 <- glmnet::glmnet( mdm0008 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0008_lambda_min$lambda) )
modgntfrm0009 <- glmnet::glmnet( mdm0009 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0009_lambda_min$lambda) )
modgntfrm0010 <- glmnet::glmnet( mdm0010 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0010_lambda_min$lambda) )
modgntfrm0011 <- glmnet::glmnet( mdm0011 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0011_lambda_min$lambda) )
modgntfrm0012 <- glmnet::glmnet( mdm0012 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0012_lambda_min$lambda) )
modgntfrm0013 <- glmnet::glmnet( mdm0013 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0013_lambda_min$lambda) )
modgntfrm0014 <- glmnet::glmnet( mdm0014 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0014_lambda_min$lambda) )
modgntfrm0015 <- glmnet::glmnet( mdm0015 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0015_lambda_min$lambda) )
modgntfrm0016 <- glmnet::glmnet( mdm0016 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0016_lambda_min$lambda) )
modgntfrm0017 <- glmnet::glmnet( mdm0017 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0017_lambda_min$lambda) )
modgntfrm0018 <- glmnet::glmnet( mdm0018 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0018_lambda_min$lambda) )
modgntfrm0019 <- glmnet::glmnet( mdm0019 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0019_lambda_min$lambda) )
modgntfrm0020 <- glmnet::glmnet( mdm0020 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0020_lambda_min$lambda) )
modgntfrm0021 <- glmnet::glmnet( mdm0021 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0021_lambda_min$lambda) )
modgntfrm0022 <- glmnet::glmnet( mdm0022 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0022_lambda_min$lambda) )
modgntfrm0023 <- glmnet::glmnet( mdm0023 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0023_lambda_min$lambda) )
modgntfrm0024 <- glmnet::glmnet( mdm0024 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0024_lambda_min$lambda) )
modgntfrm0025 <- glmnet::glmnet( mdm0025 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0025_lambda_min$lambda) )
modgntfrm0026 <- glmnet::glmnet( mdm0026 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0026_lambda_min$lambda) )
modgntfrm0027 <- glmnet::glmnet( mdm0027 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0027_lambda_min$lambda) )
modgntfrm0028 <- glmnet::glmnet( mdm0028 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0028_lambda_min$lambda) )
modgntfrm0029 <- glmnet::glmnet( mdm0029 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0029_lambda_min$lambda) )
modgntfrm0030 <- glmnet::glmnet( mdm0030 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0030_lambda_min$lambda) )
modgntfrm0031 <- glmnet::glmnet( mdm0031 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0031_lambda_min$lambda) )
modgntfrm0032 <- glmnet::glmnet( mdm0032 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0032_lambda_min$lambda) )
modgntfrm0033 <- glmnet::glmnet( mdm0033 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0033_lambda_min$lambda) )
modgntfrm0034 <- glmnet::glmnet( mdm0034 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0034_lambda_min$lambda) )
modgntfrm0035 <- glmnet::glmnet( mdm0035 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0035_lambda_min$lambda) )
modgntfrm0036 <- glmnet::glmnet( mdm0036 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0036_lambda_min$lambda) )
modgntfrm0037 <- glmnet::glmnet( mdm0037 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0037_lambda_min$lambda) )
modgntfrm0038 <- glmnet::glmnet( mdm0038 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0038_lambda_min$lambda) )
modgntfrm0039 <- glmnet::glmnet( mdm0039 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0039_lambda_min$lambda) )
modgntfrm0040 <- glmnet::glmnet( mdm0040 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0040_lambda_min$lambda) )
modgntfrm0041 <- glmnet::glmnet( mdm0041 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0041_lambda_min$lambda) )
modgntfrm0042 <- glmnet::glmnet( mdm0042 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0042_lambda_min$lambda) )
modgntfrm0043 <- glmnet::glmnet( mdm0043 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0043_lambda_min$lambda) )
modgntfrm0044 <- glmnet::glmnet( mdm0044 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0044_lambda_min$lambda) )
modgntfrm0045 <- glmnet::glmnet( mdm0045 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0045_lambda_min$lambda) )
modgntfrm0046 <- glmnet::glmnet( mdm0046 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0046_lambda_min$lambda) )
modgntfrm0047 <- glmnet::glmnet( mdm0047 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0047_lambda_min$lambda) )
modgntfrm0048 <- glmnet::glmnet( mdm0048 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0048_lambda_min$lambda) )
modgntfrm0049 <- glmnet::glmnet( mdm0049 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0049_lambda_min$lambda) )
modgntfrm0050 <- glmnet::glmnet( mdm0050 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0050_lambda_min$lambda) )
modgntfrm0051 <- glmnet::glmnet( mdm0051 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0051_lambda_min$lambda) )
modgntfrm0052 <- glmnet::glmnet( mdm0052 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0052_lambda_min$lambda) )
modgntfrm0053 <- glmnet::glmnet( mdm0053 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0053_lambda_min$lambda) )
modgntfrm0054 <- glmnet::glmnet( mdm0054 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0054_lambda_min$lambda) )
modgntfrm0055 <- glmnet::glmnet( mdm0055 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0055_lambda_min$lambda) )
modgntfrm0056 <- glmnet::glmnet( mdm0056 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0056_lambda_min$lambda) )
modgntfrm0057 <- glmnet::glmnet( mdm0057 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0057_lambda_min$lambda) )
modgntfrm0058 <- glmnet::glmnet( mdm0058 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0058_lambda_min$lambda) )
modgntfrm0059 <- glmnet::glmnet( mdm0059 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0059_lambda_min$lambda) )
modgntfrm0060 <- glmnet::glmnet( mdm0060 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0060_lambda_min$lambda) )
modgntfrm0061 <- glmnet::glmnet( mdm0061 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0061_lambda_min$lambda) )
modgntfrm0062 <- glmnet::glmnet( mdm0062 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0062_lambda_min$lambda) )
modgntfrm0063 <- glmnet::glmnet( mdm0063 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0063_lambda_min$lambda) )
modgntfrm0064 <- glmnet::glmnet( mdm0064 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0064_lambda_min$lambda) )
modgntfrm0065 <- glmnet::glmnet( mdm0065 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0065_lambda_min$lambda) )
modgntfrm0066 <- glmnet::glmnet( mdm0066 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0066_lambda_min$lambda) )
modgntfrm0067 <- glmnet::glmnet( mdm0067 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0067_lambda_min$lambda) )
modgntfrm0068 <- glmnet::glmnet( mdm0068 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0068_lambda_min$lambda) )
modgntfrm0069 <- glmnet::glmnet( mdm0069 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0069_lambda_min$lambda) )
modgntfrm0070 <- glmnet::glmnet( mdm0070 , mdm___y , family = "binomial" , alpha=1 , lambda=min(modgntfrm0070_lambda_min$lambda) )

data.frame( dfmbio_ctr = colnames( mdm0001    ) )

### predict glmnet
modgntfrm0001_pred <- predict( modgntfrm0001 , newx = mdm0001 , s = min(modgntfrm0001_lambda_min$lambda) , type = "response" )
modgntfrm0002_pred <- predict( modgntfrm0002 , newx = mdm0002 , s = min(modgntfrm0002_lambda_min$lambda) , type = "response" )
modgntfrm0003_pred <- predict( modgntfrm0003 , newx = mdm0003 , s = min(modgntfrm0003_lambda_min$lambda) , type = "response" )
modgntfrm0004_pred <- predict( modgntfrm0004 , newx = mdm0004 , s = min(modgntfrm0004_lambda_min$lambda) , type = "response" )
modgntfrm0005_pred <- predict( modgntfrm0005 , newx = mdm0005 , s = min(modgntfrm0005_lambda_min$lambda) , type = "response" )
modgntfrm0006_pred <- predict( modgntfrm0006 , newx = mdm0006 , s = min(modgntfrm0006_lambda_min$lambda) , type = "response" )
modgntfrm0007_pred <- predict( modgntfrm0007 , newx = mdm0007 , s = min(modgntfrm0007_lambda_min$lambda) , type = "response" )
modgntfrm0008_pred <- predict( modgntfrm0008 , newx = mdm0008 , s = min(modgntfrm0008_lambda_min$lambda) , type = "response" )
modgntfrm0009_pred <- predict( modgntfrm0009 , newx = mdm0009 , s = min(modgntfrm0009_lambda_min$lambda) , type = "response" )
modgntfrm0010_pred <- predict( modgntfrm0010 , newx = mdm0010 , s = min(modgntfrm0010_lambda_min$lambda) , type = "response" )
modgntfrm0011_pred <- predict( modgntfrm0011 , newx = mdm0011 , s = min(modgntfrm0011_lambda_min$lambda) , type = "response" )
modgntfrm0012_pred <- predict( modgntfrm0012 , newx = mdm0012 , s = min(modgntfrm0012_lambda_min$lambda) , type = "response" )
modgntfrm0013_pred <- predict( modgntfrm0013 , newx = mdm0013 , s = min(modgntfrm0013_lambda_min$lambda) , type = "response" )
modgntfrm0014_pred <- predict( modgntfrm0014 , newx = mdm0014 , s = min(modgntfrm0014_lambda_min$lambda) , type = "response" )
modgntfrm0015_pred <- predict( modgntfrm0015 , newx = mdm0015 , s = min(modgntfrm0015_lambda_min$lambda) , type = "response" )
modgntfrm0016_pred <- predict( modgntfrm0016 , newx = mdm0016 , s = min(modgntfrm0016_lambda_min$lambda) , type = "response" )
modgntfrm0017_pred <- predict( modgntfrm0017 , newx = mdm0017 , s = min(modgntfrm0017_lambda_min$lambda) , type = "response" )
modgntfrm0018_pred <- predict( modgntfrm0018 , newx = mdm0018 , s = min(modgntfrm0018_lambda_min$lambda) , type = "response" )
modgntfrm0019_pred <- predict( modgntfrm0019 , newx = mdm0019 , s = min(modgntfrm0019_lambda_min$lambda) , type = "response" )
modgntfrm0020_pred <- predict( modgntfrm0020 , newx = mdm0020 , s = min(modgntfrm0020_lambda_min$lambda) , type = "response" )
modgntfrm0021_pred <- predict( modgntfrm0021 , newx = mdm0021 , s = min(modgntfrm0021_lambda_min$lambda) , type = "response" )
modgntfrm0022_pred <- predict( modgntfrm0022 , newx = mdm0022 , s = min(modgntfrm0022_lambda_min$lambda) , type = "response" )
modgntfrm0023_pred <- predict( modgntfrm0023 , newx = mdm0023 , s = min(modgntfrm0023_lambda_min$lambda) , type = "response" )
modgntfrm0024_pred <- predict( modgntfrm0024 , newx = mdm0024 , s = min(modgntfrm0024_lambda_min$lambda) , type = "response" )
modgntfrm0025_pred <- predict( modgntfrm0025 , newx = mdm0025 , s = min(modgntfrm0025_lambda_min$lambda) , type = "response" )
modgntfrm0026_pred <- predict( modgntfrm0026 , newx = mdm0026 , s = min(modgntfrm0026_lambda_min$lambda) , type = "response" )
modgntfrm0027_pred <- predict( modgntfrm0027 , newx = mdm0027 , s = min(modgntfrm0027_lambda_min$lambda) , type = "response" )
modgntfrm0028_pred <- predict( modgntfrm0028 , newx = mdm0028 , s = min(modgntfrm0028_lambda_min$lambda) , type = "response" )
modgntfrm0029_pred <- predict( modgntfrm0029 , newx = mdm0029 , s = min(modgntfrm0029_lambda_min$lambda) , type = "response" )
modgntfrm0030_pred <- predict( modgntfrm0030 , newx = mdm0030 , s = min(modgntfrm0030_lambda_min$lambda) , type = "response" )
modgntfrm0031_pred <- predict( modgntfrm0031 , newx = mdm0031 , s = min(modgntfrm0031_lambda_min$lambda) , type = "response" )
modgntfrm0032_pred <- predict( modgntfrm0032 , newx = mdm0032 , s = min(modgntfrm0032_lambda_min$lambda) , type = "response" )
modgntfrm0033_pred <- predict( modgntfrm0033 , newx = mdm0033 , s = min(modgntfrm0033_lambda_min$lambda) , type = "response" )
modgntfrm0034_pred <- predict( modgntfrm0034 , newx = mdm0034 , s = min(modgntfrm0034_lambda_min$lambda) , type = "response" )
modgntfrm0035_pred <- predict( modgntfrm0035 , newx = mdm0035 , s = min(modgntfrm0035_lambda_min$lambda) , type = "response" )
modgntfrm0036_pred <- predict( modgntfrm0036 , newx = mdm0036 , s = min(modgntfrm0036_lambda_min$lambda) , type = "response" )
modgntfrm0037_pred <- predict( modgntfrm0037 , newx = mdm0037 , s = min(modgntfrm0037_lambda_min$lambda) , type = "response" )
modgntfrm0038_pred <- predict( modgntfrm0038 , newx = mdm0038 , s = min(modgntfrm0038_lambda_min$lambda) , type = "response" )
modgntfrm0039_pred <- predict( modgntfrm0039 , newx = mdm0039 , s = min(modgntfrm0039_lambda_min$lambda) , type = "response" )
modgntfrm0040_pred <- predict( modgntfrm0040 , newx = mdm0040 , s = min(modgntfrm0040_lambda_min$lambda) , type = "response" )
modgntfrm0041_pred <- predict( modgntfrm0041 , newx = mdm0041 , s = min(modgntfrm0041_lambda_min$lambda) , type = "response" )
modgntfrm0042_pred <- predict( modgntfrm0042 , newx = mdm0042 , s = min(modgntfrm0042_lambda_min$lambda) , type = "response" )
modgntfrm0043_pred <- predict( modgntfrm0043 , newx = mdm0043 , s = min(modgntfrm0043_lambda_min$lambda) , type = "response" )
modgntfrm0044_pred <- predict( modgntfrm0044 , newx = mdm0044 , s = min(modgntfrm0044_lambda_min$lambda) , type = "response" )
modgntfrm0045_pred <- predict( modgntfrm0045 , newx = mdm0045 , s = min(modgntfrm0045_lambda_min$lambda) , type = "response" )
modgntfrm0046_pred <- predict( modgntfrm0046 , newx = mdm0046 , s = min(modgntfrm0046_lambda_min$lambda) , type = "response" )
modgntfrm0047_pred <- predict( modgntfrm0047 , newx = mdm0047 , s = min(modgntfrm0047_lambda_min$lambda) , type = "response" )
modgntfrm0048_pred <- predict( modgntfrm0048 , newx = mdm0048 , s = min(modgntfrm0048_lambda_min$lambda) , type = "response" )
modgntfrm0049_pred <- predict( modgntfrm0049 , newx = mdm0049 , s = min(modgntfrm0049_lambda_min$lambda) , type = "response" )
modgntfrm0050_pred <- predict( modgntfrm0050 , newx = mdm0050 , s = min(modgntfrm0050_lambda_min$lambda) , type = "response" )
modgntfrm0051_pred <- predict( modgntfrm0051 , newx = mdm0051 , s = min(modgntfrm0051_lambda_min$lambda) , type = "response" )
modgntfrm0052_pred <- predict( modgntfrm0052 , newx = mdm0052 , s = min(modgntfrm0052_lambda_min$lambda) , type = "response" )
modgntfrm0053_pred <- predict( modgntfrm0053 , newx = mdm0053 , s = min(modgntfrm0053_lambda_min$lambda) , type = "response" )
modgntfrm0054_pred <- predict( modgntfrm0054 , newx = mdm0054 , s = min(modgntfrm0054_lambda_min$lambda) , type = "response" )
modgntfrm0055_pred <- predict( modgntfrm0055 , newx = mdm0055 , s = min(modgntfrm0055_lambda_min$lambda) , type = "response" )
modgntfrm0056_pred <- predict( modgntfrm0056 , newx = mdm0056 , s = min(modgntfrm0056_lambda_min$lambda) , type = "response" )
modgntfrm0057_pred <- predict( modgntfrm0057 , newx = mdm0057 , s = min(modgntfrm0057_lambda_min$lambda) , type = "response" )
modgntfrm0058_pred <- predict( modgntfrm0058 , newx = mdm0058 , s = min(modgntfrm0058_lambda_min$lambda) , type = "response" )
modgntfrm0059_pred <- predict( modgntfrm0059 , newx = mdm0059 , s = min(modgntfrm0059_lambda_min$lambda) , type = "response" )
modgntfrm0060_pred <- predict( modgntfrm0060 , newx = mdm0060 , s = min(modgntfrm0060_lambda_min$lambda) , type = "response" )
modgntfrm0061_pred <- predict( modgntfrm0061 , newx = mdm0061 , s = min(modgntfrm0061_lambda_min$lambda) , type = "response" )
modgntfrm0062_pred <- predict( modgntfrm0062 , newx = mdm0062 , s = min(modgntfrm0062_lambda_min$lambda) , type = "response" )
modgntfrm0063_pred <- predict( modgntfrm0063 , newx = mdm0063 , s = min(modgntfrm0063_lambda_min$lambda) , type = "response" )
modgntfrm0064_pred <- predict( modgntfrm0064 , newx = mdm0064 , s = min(modgntfrm0064_lambda_min$lambda) , type = "response" )
modgntfrm0065_pred <- predict( modgntfrm0065 , newx = mdm0065 , s = min(modgntfrm0065_lambda_min$lambda) , type = "response" )
modgntfrm0066_pred <- predict( modgntfrm0066 , newx = mdm0066 , s = min(modgntfrm0066_lambda_min$lambda) , type = "response" )
modgntfrm0067_pred <- predict( modgntfrm0067 , newx = mdm0067 , s = min(modgntfrm0067_lambda_min$lambda) , type = "response" )
modgntfrm0068_pred <- predict( modgntfrm0068 , newx = mdm0068 , s = min(modgntfrm0068_lambda_min$lambda) , type = "response" )
modgntfrm0069_pred <- predict( modgntfrm0069 , newx = mdm0069 , s = min(modgntfrm0069_lambda_min$lambda) , type = "response" )
modgntfrm0070_pred <- predict( modgntfrm0070 , newx = mdm0070 , s = min(modgntfrm0070_lambda_min$lambda) , type = "response" )

class( modgntfrm0001_pred )
dim( modgntfrm0001_pred )
max( modgntfrm0001_pred )
min( modgntfrm0001_pred )
which.max( modgntfrm0001_pred )
which.min( modgntfrm0001_pred )
plot( modgntfrm0001_pred )
#?caret::thresholder

### pendiente glmnet
### - punto de corte no es 0.5 , se estiman todas como negativas
### - revisar teoria

### class glmnet
modgntfrm0001_class <- factor( ifelse( modgntfrm0001_pred >= .3 , "SI" , "NO" ) )
modgntfrm0002_class <- factor( ifelse( modgntfrm0002_pred >= .3 , "SI" , "NO" ) )
modgntfrm0003_class <- factor( ifelse( modgntfrm0003_pred >= .3 , "SI" , "NO" ) )
modgntfrm0004_class <- factor( ifelse( modgntfrm0004_pred >= .3 , "SI" , "NO" ) )
modgntfrm0005_class <- factor( ifelse( modgntfrm0005_pred >= .3 , "SI" , "NO" ) )
modgntfrm0006_class <- factor( ifelse( modgntfrm0006_pred >= .3 , "SI" , "NO" ) )
modgntfrm0007_class <- factor( ifelse( modgntfrm0007_pred >= .3 , "SI" , "NO" ) )
modgntfrm0008_class <- factor( ifelse( modgntfrm0008_pred >= .3 , "SI" , "NO" ) )
modgntfrm0009_class <- factor( ifelse( modgntfrm0009_pred >= .3 , "SI" , "NO" ) )
modgntfrm0010_class <- factor( ifelse( modgntfrm0010_pred >= .3 , "SI" , "NO" ) )
modgntfrm0011_class <- factor( ifelse( modgntfrm0011_pred >= .3 , "SI" , "NO" ) )
modgntfrm0012_class <- factor( ifelse( modgntfrm0012_pred >= .3 , "SI" , "NO" ) )
modgntfrm0013_class <- factor( ifelse( modgntfrm0013_pred >= .3 , "SI" , "NO" ) )
modgntfrm0014_class <- factor( ifelse( modgntfrm0014_pred >= .3 , "SI" , "NO" ) )
modgntfrm0015_class <- factor( ifelse( modgntfrm0015_pred >= .3 , "SI" , "NO" ) )
modgntfrm0016_class <- factor( ifelse( modgntfrm0016_pred >= .3 , "SI" , "NO" ) )
modgntfrm0017_class <- factor( ifelse( modgntfrm0017_pred >= .3 , "SI" , "NO" ) )
modgntfrm0018_class <- factor( ifelse( modgntfrm0018_pred >= .3 , "SI" , "NO" ) )
modgntfrm0019_class <- factor( ifelse( modgntfrm0019_pred >= .3 , "SI" , "NO" ) )
modgntfrm0020_class <- factor( ifelse( modgntfrm0020_pred >= .3 , "SI" , "NO" ) )
modgntfrm0021_class <- factor( ifelse( modgntfrm0021_pred >= .3 , "SI" , "NO" ) )
modgntfrm0022_class <- factor( ifelse( modgntfrm0022_pred >= .3 , "SI" , "NO" ) )
modgntfrm0023_class <- factor( ifelse( modgntfrm0023_pred >= .3 , "SI" , "NO" ) )
modgntfrm0024_class <- factor( ifelse( modgntfrm0024_pred >= .3 , "SI" , "NO" ) )
modgntfrm0025_class <- factor( ifelse( modgntfrm0025_pred >= .3 , "SI" , "NO" ) )
modgntfrm0026_class <- factor( ifelse( modgntfrm0026_pred >= .3 , "SI" , "NO" ) )
modgntfrm0027_class <- factor( ifelse( modgntfrm0027_pred >= .3 , "SI" , "NO" ) )
modgntfrm0028_class <- factor( ifelse( modgntfrm0028_pred >= .3 , "SI" , "NO" ) )
modgntfrm0029_class <- factor( ifelse( modgntfrm0029_pred >= .3 , "SI" , "NO" ) )
modgntfrm0030_class <- factor( ifelse( modgntfrm0030_pred >= .3 , "SI" , "NO" ) )
modgntfrm0031_class <- factor( ifelse( modgntfrm0031_pred >= .3 , "SI" , "NO" ) )
modgntfrm0032_class <- factor( ifelse( modgntfrm0032_pred >= .3 , "SI" , "NO" ) )
modgntfrm0033_class <- factor( ifelse( modgntfrm0033_pred >= .3 , "SI" , "NO" ) )
modgntfrm0034_class <- factor( ifelse( modgntfrm0034_pred >= .3 , "SI" , "NO" ) )
modgntfrm0035_class <- factor( ifelse( modgntfrm0035_pred >= .3 , "SI" , "NO" ) )
modgntfrm0036_class <- factor( ifelse( modgntfrm0036_pred >= .3 , "SI" , "NO" ) )
modgntfrm0037_class <- factor( ifelse( modgntfrm0037_pred >= .3 , "SI" , "NO" ) )
modgntfrm0038_class <- factor( ifelse( modgntfrm0038_pred >= .3 , "SI" , "NO" ) )
modgntfrm0039_class <- factor( ifelse( modgntfrm0039_pred >= .3 , "SI" , "NO" ) )
modgntfrm0040_class <- factor( ifelse( modgntfrm0040_pred >= .3 , "SI" , "NO" ) )
modgntfrm0041_class <- factor( ifelse( modgntfrm0041_pred >= .3 , "SI" , "NO" ) )
modgntfrm0042_class <- factor( ifelse( modgntfrm0042_pred >= .3 , "SI" , "NO" ) )
modgntfrm0043_class <- factor( ifelse( modgntfrm0043_pred >= .3 , "SI" , "NO" ) )
modgntfrm0044_class <- factor( ifelse( modgntfrm0044_pred >= .3 , "SI" , "NO" ) )
modgntfrm0045_class <- factor( ifelse( modgntfrm0045_pred >= .3 , "SI" , "NO" ) )
modgntfrm0046_class <- factor( ifelse( modgntfrm0046_pred >= .3 , "SI" , "NO" ) )
modgntfrm0047_class <- factor( ifelse( modgntfrm0047_pred >= .3 , "SI" , "NO" ) )
modgntfrm0048_class <- factor( ifelse( modgntfrm0048_pred >= .3 , "SI" , "NO" ) )
modgntfrm0049_class <- factor( ifelse( modgntfrm0049_pred >= .3 , "SI" , "NO" ) )
modgntfrm0050_class <- factor( ifelse( modgntfrm0050_pred >= .3 , "SI" , "NO" ) )
modgntfrm0051_class <- factor( ifelse( modgntfrm0051_pred >= .3 , "SI" , "NO" ) )
modgntfrm0052_class <- factor( ifelse( modgntfrm0052_pred >= .3 , "SI" , "NO" ) )
modgntfrm0053_class <- factor( ifelse( modgntfrm0053_pred >= .3 , "SI" , "NO" ) )
modgntfrm0054_class <- factor( ifelse( modgntfrm0054_pred >= .3 , "SI" , "NO" ) )
modgntfrm0055_class <- factor( ifelse( modgntfrm0055_pred >= .3 , "SI" , "NO" ) )
modgntfrm0056_class <- factor( ifelse( modgntfrm0056_pred >= .3 , "SI" , "NO" ) )
modgntfrm0057_class <- factor( ifelse( modgntfrm0057_pred >= .3 , "SI" , "NO" ) )
modgntfrm0058_class <- factor( ifelse( modgntfrm0058_pred >= .3 , "SI" , "NO" ) )
modgntfrm0059_class <- factor( ifelse( modgntfrm0059_pred >= .3 , "SI" , "NO" ) )
modgntfrm0060_class <- factor( ifelse( modgntfrm0060_pred >= .3 , "SI" , "NO" ) )
modgntfrm0061_class <- factor( ifelse( modgntfrm0061_pred >= .3 , "SI" , "NO" ) )
modgntfrm0062_class <- factor( ifelse( modgntfrm0062_pred >= .3 , "SI" , "NO" ) )
modgntfrm0063_class <- factor( ifelse( modgntfrm0063_pred >= .3 , "SI" , "NO" ) )
modgntfrm0064_class <- factor( ifelse( modgntfrm0064_pred >= .3 , "SI" , "NO" ) )
modgntfrm0065_class <- factor( ifelse( modgntfrm0065_pred >= .3 , "SI" , "NO" ) )
modgntfrm0066_class <- factor( ifelse( modgntfrm0066_pred >= .3 , "SI" , "NO" ) )
modgntfrm0067_class <- factor( ifelse( modgntfrm0067_pred >= .3 , "SI" , "NO" ) )
modgntfrm0068_class <- factor( ifelse( modgntfrm0068_pred >= .3 , "SI" , "NO" ) )
modgntfrm0069_class <- factor( ifelse( modgntfrm0069_pred >= .3 , "SI" , "NO" ) )
modgntfrm0070_class <- factor( ifelse( modgntfrm0070_pred >= .3 , "SI" , "NO" ) )

str( modgntfrm0001_class )
length( modgntfrm0001_class )
table( modgntfrm0001_class , dfmbio_ctr$HOSPITALIZACION )
length( modgntfrm0001_pred )
min(modgntfrm0001_lambda_min$lambda)
modgntfrm0001_lambda_min$lambda.min
attributes(modgntfrm0001)
#?glmnet::predict.glmnet

### caret::confusionMatrix glmnet
modgntfrm0001_confmat <- caret::confusionMatrix( modgntfrm0001_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0002_confmat <- caret::confusionMatrix( modgntfrm0002_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0003_confmat <- caret::confusionMatrix( modgntfrm0003_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0004_confmat <- caret::confusionMatrix( modgntfrm0004_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0005_confmat <- caret::confusionMatrix( modgntfrm0005_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0006_confmat <- caret::confusionMatrix( modgntfrm0006_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0007_confmat <- caret::confusionMatrix( modgntfrm0007_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0008_confmat <- caret::confusionMatrix( modgntfrm0008_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0009_confmat <- caret::confusionMatrix( modgntfrm0009_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0010_confmat <- caret::confusionMatrix( modgntfrm0010_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0011_confmat <- caret::confusionMatrix( modgntfrm0011_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0012_confmat <- caret::confusionMatrix( modgntfrm0012_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0013_confmat <- caret::confusionMatrix( modgntfrm0013_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0014_confmat <- caret::confusionMatrix( modgntfrm0014_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0015_confmat <- caret::confusionMatrix( modgntfrm0015_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0016_confmat <- caret::confusionMatrix( modgntfrm0016_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0017_confmat <- caret::confusionMatrix( modgntfrm0017_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0018_confmat <- caret::confusionMatrix( modgntfrm0018_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0019_confmat <- caret::confusionMatrix( modgntfrm0019_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0020_confmat <- caret::confusionMatrix( modgntfrm0020_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0021_confmat <- caret::confusionMatrix( modgntfrm0021_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0022_confmat <- caret::confusionMatrix( modgntfrm0022_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0023_confmat <- caret::confusionMatrix( modgntfrm0023_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0024_confmat <- caret::confusionMatrix( modgntfrm0024_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0025_confmat <- caret::confusionMatrix( modgntfrm0025_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0026_confmat <- caret::confusionMatrix( modgntfrm0026_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0027_confmat <- caret::confusionMatrix( modgntfrm0027_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0028_confmat <- caret::confusionMatrix( modgntfrm0028_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0029_confmat <- caret::confusionMatrix( modgntfrm0029_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0030_confmat <- caret::confusionMatrix( modgntfrm0030_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0031_confmat <- caret::confusionMatrix( modgntfrm0031_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0032_confmat <- caret::confusionMatrix( modgntfrm0032_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0033_confmat <- caret::confusionMatrix( modgntfrm0033_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0034_confmat <- caret::confusionMatrix( modgntfrm0034_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0035_confmat <- caret::confusionMatrix( modgntfrm0035_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0036_confmat <- caret::confusionMatrix( modgntfrm0036_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0037_confmat <- caret::confusionMatrix( modgntfrm0037_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0038_confmat <- caret::confusionMatrix( modgntfrm0038_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0039_confmat <- caret::confusionMatrix( modgntfrm0039_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0040_confmat <- caret::confusionMatrix( modgntfrm0040_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0041_confmat <- caret::confusionMatrix( modgntfrm0041_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0042_confmat <- caret::confusionMatrix( modgntfrm0042_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0043_confmat <- caret::confusionMatrix( modgntfrm0043_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0044_confmat <- caret::confusionMatrix( modgntfrm0044_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0045_confmat <- caret::confusionMatrix( modgntfrm0045_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0046_confmat <- caret::confusionMatrix( modgntfrm0046_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0047_confmat <- caret::confusionMatrix( modgntfrm0047_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0048_confmat <- caret::confusionMatrix( modgntfrm0048_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0049_confmat <- caret::confusionMatrix( modgntfrm0049_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0050_confmat <- caret::confusionMatrix( modgntfrm0050_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0051_confmat <- caret::confusionMatrix( modgntfrm0051_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0052_confmat <- caret::confusionMatrix( modgntfrm0052_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0053_confmat <- caret::confusionMatrix( modgntfrm0053_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0054_confmat <- caret::confusionMatrix( modgntfrm0054_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0055_confmat <- caret::confusionMatrix( modgntfrm0055_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0056_confmat <- caret::confusionMatrix( modgntfrm0056_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0057_confmat <- caret::confusionMatrix( modgntfrm0057_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0058_confmat <- caret::confusionMatrix( modgntfrm0058_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0059_confmat <- caret::confusionMatrix( modgntfrm0059_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0060_confmat <- caret::confusionMatrix( modgntfrm0060_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0061_confmat <- caret::confusionMatrix( modgntfrm0061_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0062_confmat <- caret::confusionMatrix( modgntfrm0062_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0063_confmat <- caret::confusionMatrix( modgntfrm0063_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0064_confmat <- caret::confusionMatrix( modgntfrm0064_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0065_confmat <- caret::confusionMatrix( modgntfrm0065_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0066_confmat <- caret::confusionMatrix( modgntfrm0066_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0067_confmat <- caret::confusionMatrix( modgntfrm0067_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0068_confmat <- caret::confusionMatrix( modgntfrm0068_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0069_confmat <- caret::confusionMatrix( modgntfrm0069_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )
modgntfrm0070_confmat <- caret::confusionMatrix( modgntfrm0070_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" )

### metricas glmnet
modgntfrm0001_confmat$overall[[1]]
modgntfrm0002_confmat$overall[[1]]
modgntfrm0003_confmat$overall[[1]]
modgntfrm0004_confmat$overall[[1]]
modgntfrm0005_confmat$overall[[1]]
modgntfrm0006_confmat$overall[[1]]
modgntfrm0007_confmat$overall[[1]]
modgntfrm0008_confmat$overall[[1]]
modgntfrm0009_confmat$overall[[1]]
modgntfrm0010_confmat$overall[[1]]
modgntfrm0011_confmat$overall[[1]]
modgntfrm0012_confmat$overall[[1]]
modgntfrm0013_confmat$overall[[1]]
modgntfrm0014_confmat$overall[[1]]
modgntfrm0015_confmat$overall[[1]]
modgntfrm0016_confmat$overall[[1]]
modgntfrm0017_confmat$overall[[1]]
modgntfrm0018_confmat$overall[[1]]
modgntfrm0019_confmat$overall[[1]]
modgntfrm0020_confmat$overall[[1]]
modgntfrm0021_confmat$overall[[1]]
modgntfrm0022_confmat$overall[[1]]
modgntfrm0023_confmat$overall[[1]]
modgntfrm0024_confmat$overall[[1]]
modgntfrm0025_confmat$overall[[1]]
modgntfrm0026_confmat$overall[[1]]
modgntfrm0027_confmat$overall[[1]]
modgntfrm0028_confmat$overall[[1]]
modgntfrm0029_confmat$overall[[1]]
modgntfrm0030_confmat$overall[[1]]
modgntfrm0031_confmat$overall[[1]]
modgntfrm0032_confmat$overall[[1]]
modgntfrm0033_confmat$overall[[1]]
modgntfrm0034_confmat$overall[[1]]
modgntfrm0035_confmat$overall[[1]]
modgntfrm0036_confmat$overall[[1]]
modgntfrm0037_confmat$overall[[1]]
modgntfrm0038_confmat$overall[[1]]
modgntfrm0039_confmat$overall[[1]]
modgntfrm0040_confmat$overall[[1]]
modgntfrm0041_confmat$overall[[1]]
modgntfrm0042_confmat$overall[[1]]
modgntfrm0043_confmat$overall[[1]]
modgntfrm0044_confmat$overall[[1]]
modgntfrm0045_confmat$overall[[1]]
modgntfrm0046_confmat$overall[[1]]
modgntfrm0047_confmat$overall[[1]]
modgntfrm0048_confmat$overall[[1]]
modgntfrm0049_confmat$overall[[1]]
modgntfrm0050_confmat$overall[[1]]
modgntfrm0051_confmat$overall[[1]]
modgntfrm0052_confmat$overall[[1]]
modgntfrm0053_confmat$overall[[1]]
modgntfrm0054_confmat$overall[[1]]
modgntfrm0055_confmat$overall[[1]]
modgntfrm0056_confmat$overall[[1]]
modgntfrm0057_confmat$overall[[1]]
modgntfrm0058_confmat$overall[[1]]
modgntfrm0059_confmat$overall[[1]]
modgntfrm0060_confmat$overall[[1]]
modgntfrm0061_confmat$overall[[1]]
modgntfrm0062_confmat$overall[[1]]
modgntfrm0063_confmat$overall[[1]]
modgntfrm0064_confmat$overall[[1]]
modgntfrm0065_confmat$overall[[1]]
modgntfrm0066_confmat$overall[[1]]
modgntfrm0067_confmat$overall[[1]]
modgntfrm0068_confmat$overall[[1]]
modgntfrm0069_confmat$overall[[1]]
modgntfrm0070_confmat$overall[[1]]

###
### Creacion modelos LDA
### - usar transformaciones
### - usar interacciones
### - comparar con GLM
###

### variables disponibles - centradas y sin nzv - excepto HOSPITALIZACION
utils::str(dfmbio_ctr_nnzv)
data.frame(dfmbio_fac_mod  = base::colnames(dfmbio_fac_mod ))
data.frame(dfmbio_ctr_nnzv = base::colnames(dfmbio_ctr_nnzv))
data.frame(dfmbio_fac_mod  = base::colnames( base::Filter( base::is.numeric   , dfmbio_fac_mod [,-13] ) ))
data.frame(dfmbio_fac_mod  = base::colnames( base::Filter( base::is.factor    , dfmbio_fac_mod [,-13] ) ))
data.frame(dfmbio_ctr_nnzv = base::colnames( base::Filter( base::is.numeric   , dfmbio_ctr_nnzv[,-10] ) ))
data.frame(dfmbio_ctr_nnzv = base::colnames( base::Filter( base::is.factor    , dfmbio_ctr_nnzv[,-10] ) ))
data.frame(dfmbio_fac      = base::colnames( base::Filter( base::is.numeric   , dfmbio_fac     [,-21] ) ))
data.frame(dfmbio_fac      = base::colnames( base::Filter( base::is.factor    , dfmbio_fac     [,-21] ) ))
length(base::colnames( base::Filter( base::is.numeric   , dfmbio_fac_mod [,-13] ) ))
length(base::colnames( base::Filter( base::is.factor    , dfmbio_fac_mod [,-13] ) ))
length(base::colnames( base::Filter( base::is.numeric   , dfmbio_ctr_nnzv[,-10] ) ))
length(base::colnames( base::Filter( base::is.factor    , dfmbio_ctr_nnzv[,-10] ) ))
length(base::colnames( base::Filter( base::is.numeric   , dfmbio_fac     [,-21] ) ))
length(base::colnames( base::Filter( base::is.factor    , dfmbio_fac     [,-21] ) ))


### graficar scatter HOSPITALIZACION original solo una dimension - no se puede tiene que ser vector numerico nube de puntos
#plot( dfmbio_ctr_nnzv$HOSPITALIZACION , ylab="LD1" , col=dfmbio_ctr_nnzv$HOSPITALIZACION )
#legend('topright', legend = levels(dfmbio_ctr_nnzv$HOSPITALIZACION col = 1:2, cex = 0.8, pch = 1)
#text( dfmbio_ctr_nnzv_lda01_pred$class )
dfmbio_ctr_nnzv_lda01$prior
### opcion ggplot
ggplot2::ggplot( dfmbio_ctr_nnzv , aes( x=dfmbio_ctr_nnzv_lda01$LD1 ) ) +
ggplot2::geom_point()
### opcion ggord no funciona con ld1
library(remotes)
#?remotes::download_version
library(ggord)
ggord::ggord( dfmbio_ctr_nnzv_lda01 , dfmbio_ctr_nnzv$HOSPITALIZACION )
### variante qda basta con lda sin variables problematicas
MASS::qda( HOSPITALIZACION ~ . , data = dfmbio_ctr_nnzv )
str(dfmbio_ctr_nnzv)

### visualizar PCA y LDA
### ver enlace
require(MASS)
require(ggplot2)
require(scales)
require(gridExtra)
#?stats::prcomp
dfmbio_ctr_nnzv_pca <- stats::prcomp(dfmbio_ctr_nnzv_x, center = TRUE               )
### pca es solo para datos numericos
dfmbio_ctr_nnzv_pca <- stats::prcomp(dfmbio_ctr_nnzv  , center = TRUE               )

### probar con dfmbio_num
dfmbio_num_ctr     <- data.frame( base::scale( dfmbio_num , scale=TRUE , center=TRUE ) )
dfmbio_num_ctr_pca <- stats::prcomp( dfmbio_num_ctr  , center = FALSE              )
head(as.data.frame(dfmbio_num_ctr_pca$x[,1:5]))
#str(dfmbio_num_ctr)
#str(dfmbio_num_ctr_pca)

### equivalente a eigen(cor(scaled)) ==> definitivo
### - los datos deben estar centrados
### - da lo mismo si es cor o cov
### - combinar esta version con hetcor y graficar PC1 versus PC2
dfmbio_num_ctr_cor   <- stats::cor( dfmbio_num_ctr )
dfmbio_num_ctr_eigen <- base::eigen( dfmbio_num_ctr_cor )
dfmbio_num_ctr_eigen_pca <- t(dfmbio_num_ctr_eigen$vectors) %*% t(dfmbio_num_ctr)
dfmbio_num_ctr_eigen_pca <- as.data.frame(t(dfmbio_num_ctr_eigen_pca))
colnames(dfmbio_num_ctr_eigen_pca) <- c( "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10", "PC11", "PC12", "PC13", "PC14", "PC15", "PC16", "PC17", "PC18", "PC19", "PC20", "PC21" )
head(dfmbio_num_ctr_eigen_pca[,1:5])
#str(dfmbio_num_ctr_eigen)
#str(dfmbio_num_ctr_eigen_pca)
#class(dfmbio_num_ctr_eigen_pca)
#round( dfmbio_num_pca$sdev^2 , 6 ) == round( dfmbio_num_eigen$values , 6 )

### graficar PCA bien calculado
plot( dfmbio_num_ctr_eigen_pca[,1] , dfmbio_num_ctr_eigen_pca[,2] , col=dfmbio_ctr$HOSPITALIZACION )
legend( 'topright' , legend = levels(dfmbio_ctr$HOSPITALIZACION), col = 1:2, cex = 0.8, pch = 1)

### graficar PCA bien calculado combinar con k-means
plot( dfmbio_num_ctr_eigen_pca[,1] , dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
legend('topright', ncol = 3L, title = NULL , legend = c('', 'NO', 'SI', 'NO', table_seed0045_kpt0001_comb[,1], 'SI', table_seed0045_kpt0001_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)), col = 1:4, cex = 0.8, pch = 1)

### calcular polycor::hetcor para dfmbio_num_ctr
dfmbio_num_ctr_hetcor           <- polycor::hetcor( dfmbio_num_ctr )
dfmbio_num_ctr_hetcor_eigen     <- base::eigen( dfmbio_num_ctr_hetcor )
dfmbio_num_ctr_hetcor_eigen_pca <- t(dfmbio_num_ctr_hetcor_eigen$vectors) %*% t(dfmbio_num_ctr)
dfmbio_num_ctr_hetcor_eigen_pca <- as.data.frame(t(dfmbio_num_ctr_hetcor_eigen_pca))
colnames(dfmbio_num_ctr_hetcor_eigen_pca) <- c( "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10", "PC11", "PC12", "PC13", "PC14", "PC15", "PC16", "PC17", "PC18", "PC19", "PC20", "PC21")
head(dfmbio_num_ctr_hetcor_eigen_pca[,1:5])
#str(dfmbio_num_ctr_hetcor_eigen_pca)
#class(dfmbio_num_ctr_hetcor_eigen_pca)

### graficar PCA bien calculado usando hetcor
plot( dfmbio_num_ctr_hetcor_eigen_pca[,1] , dfmbio_num_ctr_hetcor_eigen_pca[,2] , col=dfmbio_ctr$HOSPITALIZACION )
legend( 'topright' , legend = levels(dfmbio_ctr$HOSPITALIZACION), col = 1:2, cex = 0.8, pch = 1)

### usar plot factoextra
library(factoextra)

### graficar con factoextra::fviz_pca_ind
### - podemos usar este grafico porque representa mejor las 2 componentes
factoextra::fviz_pca_ind( dfmbio_num_ctr_pca ,
 geom.ind = "point", pointshape = 21,
 pointsize = 2,
 fill.ind = dfmbio_ctr$HOSPITALIZACION,
 col.ind = "black",
 palette = "jco",
 addEllipses = TRUE,
 label = "var",
 col.var = "black",
 repel = TRUE,
 legend.title = "HOSPITALIZACION") +
 ggtitle("Gráfico PCA 2D") +
 theme(plot.title = element_text(hjust = 0.5))

### pca tiene 5 slots
str(dfmbio_ctr_nnzv_pca)
head(dfmbio_ctr_nnzv_pca$x[,1:2])
dfmbio_ctr_nnzv_pca_prop = dfmbio_ctr_nnzv_pca$sdev^2/sum(dfmbio_ctr_nnzv_pca$sdev^2)
### falta definir prior
dfmbio_ctr_nnzv_lda <- MASS::lda( HOSPITALIZACION ~ . , dfmbio_ctr_nnzv , prior = c(1,1)/2 )
attributes( dfmbio_ctr_nnzv_lda )
attr( dfmbio_ctr_nnzv_lda , "svd" )
dfmbio_ctr_nnzv_lda$svd
### objeto r no encontrado
### pendiente da valor 1 para esta proporcion revisar
dfmbio_ctr_nnzv_lda_prop <- dfmbio_ctr_nnzv_lda$svd^2/sum(dfmbio_ctr_nnzv_lda$svd^2)
dfmbio_ctr_nnzv_lda_pred <- predict( object = dfmbio_ctr_nnzv_lda , newdata = dfmbio_ctr_nnzv )
str(dfmbio_ctr_nnzv_lda_pred$x)
dfmbio_ctr_nnzv_data <- data.frame(
 HOSPITALIZACION = dfmbio_ctr_nnzv[,"HOSPITALIZACION"],
 pca             = dfmbio_ctr_nnzv_pca$x ,
 lda             = dfmbio_ctr_nnzv_lda_pred$x )
str(dfmbio_ctr_nnzv_data)

### grafico plot PCA - no usar , solo para analizar
plot( dfmbio_num_pca$sdev^2 )
plot( dfmbio_num_pca$x[,1]      , dfmbio_num_pca$x[,2]      , col=1:2 )
plot( dfmbio_ctr_nnzv_pca$x[,1] , dfmbio_ctr_nnzv_pca$x[,2] , col=1:2 )

### grafico ggplot PCA
### graficar - falta LD2
dfmbio_ctr_nnzv_lda_prop[1]
dfmbio_ctr_nnzv_lda_prop[2]
dfmbio_ctr_nnzv_pca_prop[1]
dfmbio_ctr_nnzv_pca_prop[2]
p1 <- ggplot( dfmbio_ctr_nnzv_data )
    + geom_point(
      aes( lda.LD1           , colour = HOSPITALIZACION , shape = HOSPITALIZACION )
    , size = 2.5 )
    + labs( x = paste("LD1 (", percent(dfmbio_ctr_nnzv_lda_prop[1]), ")", sep=""),
            y = paste("LD2 (", percent(dfmbio_ctr_nnzv_lda_prop[2]), ")", sep=""))
p2 <- ggplot( dfmbio_ctr_nnzv_data )
    + geom_point(
      aes( pca.PC1           , colour = HOSPITALIZACION , shape = HOSPITALIZACION )
    , size = 2.5 )
    + labs( x = paste("PC1 (", percent(dfmbio_ctr_nnzv_pca_prop[1]), ")", sep=""),
            y = paste("PC2 (", percent(dfmbio_ctr_nnzv_pca_prop[2]), ")", sep=""))
grid.arrange(p1, p2)

###
### Centrar variables numericas
###
### - para evitar multicolinealidad se ve mas abajo
###   muchas variables excluidas; stderr del intercepto
###   muy elevado
###

### crear copia dataframe variables numericas centradas
dfmbio_ctr <- dfmbio_fac
#?scale

### centrar variables numericas
  dfmbio_ctr$ANO.PROC                   <- scale( dfmbio_ctr$ANO.PROC                   , center = T )  ### integer  ### 01
  dfmbio_ctr$EDAD                                    <- scale( dfmbio_ctr$EDAD                                    , center = T )  ### integer  ### 02
 #dfmbio_ctr$DIABETES                                <- scale( dfmbio_ctr$DIABETES                                , center = T )  ### factor   ### 03
 #dfmbio_ctr$HOSP.ULT.MES              <- scale( dfmbio_ctr$HOSP.ULT.MES              , center = T )  ### factor   ### 04
  dfmbio_ctr$PSA                                     <- scale( dfmbio_ctr$PSA                                     , center = T )  ### numeric  ### 05
 #dfmbio_ctr$BIOP.PREV                        <- scale( dfmbio_ctr$BIOP.PREV                        , center = T )  ### factor   ### 06
 #dfmbio_ctr$VOL.PROST                      <- scale( dfmbio_ctr$VOL.PROST                      , center = T )  ### factor   ### 07
 #dfmbio_ctr$ANTIB.PROFI <- scale( dfmbio_ctr$ANTIB.PROFI , center = T )  ### factor   ### 08
  dfmbio_ctr$NUM.MUESTRAS              <- scale( dfmbio_ctr$NUM.MUESTRAS              , center = T )  ### integer  ### 09
 #dfmbio_ctr$CUP                                     <- scale( dfmbio_ctr$CUP                                     , center = T )  ### factor   ### 10
 #dfmbio_ctr$EPOC       <- scale( dfmbio_ctr$EPOC       , center = T )  ### factor   ### 11
 #dfmbio_ctr$BIOPSIA                                 <- scale( dfmbio_ctr$BIOPSIA                                 , center = T )  ### factor   ### 12
 #dfmbio_ctr$NUM.DIAS.POST.BIOP             <- scale( dfmbio_ctr$NUM.DIAS.POST.BIOP             , center = T )  ### factor   ### 13
 #dfmbio_ctr$FIEBRE                                  <- scale( dfmbio_ctr$FIEBRE                                  , center = T )  ### factor   ### 14
 #dfmbio_ctr$ITU                                     <- scale( dfmbio_ctr$ITU                                     , center = T )  ### factor   ### 15
 #dfmbio_ctr$TIPO.CULTIVO                         <- scale( dfmbio_ctr$TIPO.CULTIVO                         , center = T )  ### factor   ### 16
 #dfmbio_ctr$AGENTE.AISLADO                          <- scale( dfmbio_ctr$AGENTE.AISLADO                          , center = T )  ### factor   ### 17
 #dfmbio_ctr$PATR.RESIST                   <- scale( dfmbio_ctr$PATR.RESIST                   , center = T )  ### factor   ### 18
  dfmbio_ctr$DIAS.HOSP.MQ                 <- scale( dfmbio_ctr$DIAS.HOSP.MQ                 , center = T )  ### integer  ### 19
  dfmbio_ctr$DIAS.HOSP.UPC                <- scale( dfmbio_ctr$DIAS.HOSP.UPC                , center = T )  ### integer  ### 20
 #dfmbio_ctr$HOSPITALIZACION                         <- scale( dfmbio_ctr$HOSPITALIZACION                         , center = T )  ### factor   ### 21

  ### media y sd dfmbio_ctr variables numericas
  apply( dfmbio_ctr [ , c(1,2,5,9,19,20) ] , 2 , mean )
  apply( dfmbio_ctr [ , c(1,2,5,9,19,20) ] , 2 , sd   )

  ### observamos colnames
  data.frame( dfmbio_ctr = base::colnames( dfmbio_ctr ) )

###
### Cross validation
### - Repeated k fold cross validation
###

### randomForest
library(randomForest)
#?randomForest::randomForest
randomForest::randomForest( HOSPITALIZACION ~ . , data = dfmbio_fac_mod , importance = T , proximity = T )
dfmbio_tr_rf <- randomForest::randomForest( HOSPITALIZACION ~ . , data = dfmbio_tr_fac[-1] , importance = T , proximity = T )
dfmbio_tr_rf_pr <- predict( dfmbio_tr_rf , data = dfmbio_ts_fac[-1] )
table( dfmbio_tr_fac$HOSPITALIZACION , dfmbio_tr_rf_pr )
str(dfmbio_tr_fac)

### caret
library(caret)
#?caret::trainControl
#?caret::train

### posibles modelos que usa caret
names(caret::getModelInfo())
### Que modelos son logisticos segun caret
for (nmod in grep( "log" ,  names(caret::getModelInfo()) )){
  print( names(caret::getModelInfo())[nmod] )
}
for (nmod in grep( "glm" ,  names(caret::getModelInfo()) )){
  print( names(caret::getModelInfo())[nmod] )
}
for (nmod in grep( "rf" ,  names(caret::getModelInfo()) )){
  print( names(caret::getModelInfo())[nmod] )
}

###
### glm usando caret
###
### - es mas detallado el mensaje de error que entrega
###   lo que permite identificar mejor variables colineales
### - usar el glm inicial tambien para inspeccionar las variables
###   colineales y excluirlas antes de estimar de nuevo usando caret
###

ctrl001 <- caret::trainControl( method = "repeatedcv" , number = 10 , repeats = 10 )
modn001 <- caret::train( HOSPITALIZACION ~ . , data = dfmbio_fac_mod , method = "glm" , trControl = ctrl001 , maxit = 100 )
warnings()
summary(modn001)

###
### randomForest usando caret
###

ctrl002 <- caret::trainControl( method = "repeatedcv" , number = 10 , repeats = 10 )
modn002 <- caret::train( HOSPITALIZACION ~ . , data = dfmbio_fac_mod , method = "rf" , trControl = ctrl002 )
summary(modn002)

library(RcppMLPACK)
#?RcppMLPACK::RcppMLPACK.package.skeleton

savehistory()
save.image()

### proporcion
( proporcion <- length( dfmbio$HOSPITALIZACION [ dfmbio$HOSPITALIZACION == "SI" ] ) / nrow( dfmbio ) )
                length( dfmbio$HOSPITALIZACION [ dfmbio$HOSPITALIZACION == "NO" ] ) / nrow( dfmbio )

### multiplicar por 50%
nrow( dfmpnd )
( 1 - proporcion )
(     proporcion )
length( dfmpnd$ponderador [ dfmbio$HOSPITALIZACION == "SI" ] ) * ( 1 - proporcion )
length( dfmpnd$ponderador [ dfmbio$HOSPITALIZACION == "NO" ] ) * (     proporcion )

### variable ponderador dataframe aparte
dfmpnd <- data.frame( ponderador = matrix( nrow=nrow(dfmbio) , ncol=1 ) )
dfmpnd$ponderador <- ( dfmbio_num$HOSPITALIZACION )
dfmpnd$ponderador [ dfmbio$HOSPITALIZACION == "SI" ] <- ( 1 - proporcion )
dfmpnd$ponderador [ dfmbio$HOSPITALIZACION == "NO" ] <- (     proporcion )
head( dfmpnd )
tail( dfmpnd )
table( dfmpnd$ponderador )
str( dfmpnd )
#dfmpnd

### previo a modelo logit
head( cbind( fitted( modlogb001 ) , modlogb001$y , prdlogb001 ) )
tail( cbind( fitted( modlogb001 ) , modlogb001$y , prdlogb001 ) )
sort( unique( fitted( modlogb001 ) ) )
sort( unique(         modlogb001$y ) )
sort( unique(         prdlogb001   ) )
sort( unique( as.factor( fitted( modlogb001 ) ) ) )
sort( unique( as.factor(         modlogb001$y ) ) )
sort( unique( as.factor(         prdlogb001   ) ) )
fitted( modlogb001 ) == prdlogb001
head(prdlogb001)
tail(prdlogb001)
str(prdlogb001)

class( prdlogb001 )
is.vector( prdlogb001 )
class( fitted( modlogb001 ) )
class(         modlogb001$y )

###
### modelo logistico simple
### - usar para excluir variables colineales y luego usar k fold con caret
###

### excluir variables colineales del dataframe
################# dfmbio_fac [ , -c(14,15   ,20) ]
################# dfmbio_fac [ , -c(11,13,14,16,17,18,19,20) ]
### variables finalmente excluidas
### variables 11,12,17,19 se agregan por car::vif
### siguen habiendo varianzas infladas y no significativas
### variables 04,08,10,15 se excluyen por summary
### exclusion provisoria para analisis de colinealidad
dfmbio_ctr_mod <- dfmbio_ctr [ , -c(13,14,16,18,19,20) ]
### seleccion exclusion total
dfmbio_ctr_mod <- dfmbio_ctr [ , -c(04,08,10,11,12,13,14,15,16,17,18,19,20) ]
str(dfmbio_ctr_mod)
#?glm
#?predict

### transformar variables numericas
dfmbio_ctr_mod$EDAD.SQ             <- dfmbio_ctr_mod$EDAD^2
dfmbio_ctr_mod$PSA.SQ              <- dfmbio_ctr_mod$PSA^2
dfmbio_ctr_mod$NUMERO.MUESTRAS.SQ  <- dfmbio_ctr_mod$NUM.MUESTRAS^2
dfmbio_ctr_mod$EDAD.CU             <- dfmbio_ctr_mod$EDAD^3
dfmbio_ctr_mod$PSA.CU              <- dfmbio_ctr_mod$PSA^3
dfmbio_ctr_mod$NUMERO.MUESTRAS.CU  <- dfmbio_ctr_mod$NUM.MUESTRAS^3
dfmbio_ctr_mod$NUMERO.MUESTRAS.SQ  <- NULL
dfmbio_ctr_mod$NUMERO.MUESTRAS.CU  <- NULL
dfmbio_ctr_mod$NUMERO.MUESTRAS.LOG <- log(     dfmbio_ctr_mod$NUM.MUESTRAS )

### interacciones dobles entre variables numericas c(1,2,5,9) ==> c(1,2,4,7)
dfmbio_ctr_mod$ANO.EDAD             <- dfmbio_ctr_mod$ANO.PROC * dfmbio_ctr_mod$EDAD
dfmbio_ctr_mod$ANO.PSA              <- dfmbio_ctr_mod$ANO.PROC * dfmbio_ctr_mod$PSA
dfmbio_ctr_mod$ANO.NUMERO.MUESTRAS  <- dfmbio_ctr_mod$ANO.PROC * dfmbio_ctr_mod$NUM.MUESTRAS
dfmbio_ctr_mod$EDAD.PSA             <- dfmbio_ctr_mod$EDAD     * dfmbio_ctr_mod$PSA
dfmbio_ctr_mod$EDAD.NUMERO.MUESTRAS <- dfmbio_ctr_mod$EDAD     * dfmbio_ctr_mod$NUM.MUESTRAS
dfmbio_ctr_mod$PSA.NUMERO.MUESTRAS  <- dfmbio_ctr_mod$PSA      * dfmbio_ctr_mod$NUM.MUESTRAS
dfmbio_ctr_mod$ANO.EDAD             <- NULL
dfmbio_ctr_mod$ANO.PSA              <- NULL
dfmbio_ctr_mod$ANO.NUMERO.MUESTRAS  <- NULL
dfmbio_ctr_mod$EDAD.NUMERO.MUESTRAS <- NULL

### interacciones triples entre variables numericas
dfmbio_ctr_mod$EDAD.PSA.NUMERO.MUESTRAS <- dfmbio_ctr_mod$EDAD * dfmbio_ctr_mod$PSA * dfmbio_ctr_mod$NUM.MUESTRAS
dfmbio_ctr_mod$EDAD.PSA.NUMERO.MUESTRAS <- NULL

### modelo glm
modlogb001 <- glm( HOSPITALIZACION ~ . , data = dfmbio_ctr_mod , family=binomial("logit") , maxit=100 )
summary( modlogb001 )
library(car)
car::vif(modlogb001)

#?alias
library(stats)
#?is.null
#?nrow
base::is.null(stats::alias(modlogb001)$Complete)
stats::alias( modlogb001 )
str(stats::alias( modlogb001 ))
attributes(stats::alias(modlogb001))
stats::alias( modlogb001 )$Model
str(stats::alias( modlogb001 )$Complete)
colnames(stats::alias( modlogb001 )$Complete)
rownames(stats::alias( modlogb001 )$Complete)

modlogb001.alias <- stats::alias( modlogb001 )$Complete
rownames(modlogb001.alias)[8]
colnames(modlogb001.alias)[32]
nrow(modlogb001.alias)
ncol(modlogb001.alias)
modlogb001.alias[8,32]
#?try

### imprimir niveles que son colinales entre si
### esto no resuelve del todo la inlacion de varianza
try(
for( strrow in 1:nrow(modlogb001.alias)){
  for( strcol in 1:ncol(modlogb001.alias)){
    if( modlogb001.alias[strrow,strcol]!=0 ){
      print( paste( rownames(modlogb001.alias)[strrow] , "x" , colnames(modlogb001.alias)[strcol] , "=" , modlogb001.alias[strrow,strcol] ) )
    }
  }
}
, silent=T)

library(car)
car::vif(modlogb001)

### modelo glm tiene 30 slots
attributes( modlogb001 )
str( modlogb001 )
class(modlogb001$fitted.values)
class(modlogb001$y)
max(modlogb001$fitted.values)
min(modlogb001$fitted.values)
modlogb001$fitted.values>=.5
modlogb001_class <- factor(ifelse(modlogb001$fitted.values >= .5, "SI", "NO"))
modlogb001_class
### glm hasta ahora tiene la mayor precision versus LDA y Kmeans
caret::confusionMatrix( modlogb001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )

dfmbio_ctr_nnzv_glm0001 <- glm( HOSPITALIZACION ~ . , data = dfmbio_ctr_nnzv , binomial , maxit=100 , weights=dfmpnd$ponderador )
dfmbio_ctr_nnzv_glm0001_class <- factor(ifelse(dfmbio_ctr_nnzv_glm0001$fitted.values >= .5 , "SI" , "NO" ))
caret::confusionMatrix( dfmbio_ctr_nnzv_glm0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )
### mayor valor fitted.values no supera .5 , usar youden ?
### - buscar youden en laboratorios anteriores
### - ver: /home/matbox/PUCV/est717datamining/tarea02/tarea02.R
dfmbio_ctr_nnzv_glm0001$fitted.values >= .5
max(dfmbio_ctr_nnzv_glm0001$fitted.values)
min(dfmbio_ctr_nnzv_glm0001$fitted.values)

### comparamos dataframes usados en estimaciones
data.frame( dfmbio_fac_mod  = names( dfmbio_fac_mod  ) ) ### 13 variables
data.frame( dfmbio_ctr_nnzv = names( dfmbio_ctr_nnzv ) ) ### 10 variables

### posible seleccion de variables o niveles
library(pracma)
pracma::nchoosek(20,19)
pracma::nchoosek(20,18)
pracma::nchoosek(20,17)
pracma::nchoosek(20,16)
pracma::nchoosek(20,15)
pracma::nchoosek( 5, 2)

prdlogb001 <- predict( modlogb001      , data = dfmbio_fac_mod[-21] , type = "response" )

###
### - tenemos que los p-values son no significativos y los errores estandar son elevados
### - usar VIF para excluir mas variables
###

library(car)
#?car::vif
car::vif( modlogb001 )

###
### revisar modelo para excluir variables colineales
### - mensaje
###   Coefficients: (11 not defined because of singularities)
### - usar rlevels para cambiar nivel de referencia
###   o excluir variables colineales
###

attributes(prdlogb001)
attributes(modlogb001)
summary( modlogb001 )
AIC( modlogb001 )
deviance( modlogb001 )
offset( modlogb001 )
modlogb001$coefficients
str(modlogb001$coefficients)
str(as.data.frame(modlogb001$coefficients))
as.data.frame(modlogb001$coefficients [ is.na(as.data.frame(modlogb001$coefficients)) ] )
niv001.nisig <- rownames(as.data.frame(modlogb001$coefficients [ is.na(as.data.frame(modlogb001$coefficients)) ] ))
length(niv001.nisig)
write(niv001.nisig, stdout())
sprintf("%s",niv001.nisig)

library(ROCR)
ROCR::performance( ROCR::prediction(         prdlogb001   , modlogb001$y ) , "auc" )@y.values[[1]]
ROCR::performance( ROCR::prediction( fitted( modlogb001 ) , modlogb001$y ) , "auc" )@y.values[[1]]
attributes( modlogb001 )
modlogb001$fitted.values
modlogb001$y
prediction( modlogb001$fitted.values , modlogb001$y )
performance( prediction( modlogb001$fitted.values , modlogb001$y ) , "auc" )

modlogn001 <- glm( HOSPITALIZACION ~ . , data = dfmbio_fac_mod , family=binomial("logit") , maxit=100 , weights = dfmpnd$ponderador )
prdlogn001 <- predict( modlogn001 , data = dfmbio_fac_mod[-21] , type = "response" )
summary( modlogn001 )
AIC( modlogn001 )

###
### Citaciones Bibtex Referencias
### - Ejecutar filtro
###   grep -i --color 'library' src/sesion_caso02.R src/.Rhistory
### - ya está automatizado en GenerarCitacionesPackages.sh
#?utils::citation
#?utils::toBibtex
utils::toBibtex( utils::citation( package = "glmnet" ) )
utils::toBibtex( utils::citation( package = "caret" ) )
