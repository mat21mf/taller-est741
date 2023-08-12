  ###
  ### Crear metricas glm
  ###

  ### crear metricas usando SS-AUC con punto de corte por defecto ==> 0.5
  dfmacc_glm_modelos_list             <- ls(pattern="^modglmfr[mw]\\d+$")
  dfmacc_glm_modelos_confmat_list     <- ls(pattern="^modglmfr[mw]\\d+_confmat$")
  dfmacc_glm_metricas_dfm             <- data.frame( matrix( ncol=7 , nrow=length( dfmacc_glm_modelos_list ) ) )
  colnames( dfmacc_glm_metricas_dfm ) <- c( "Modelo" , "Dev" , "Acc" , "Sens" , "Spec" , "NCof" , "NSig" )
  for( strglmnum in 1:length( dfmacc_glm_modelos_list )){
    dfmacc_glm_metricas_dfm[strglmnum,1] <- dfmacc_glm_modelos_list[strglmnum]
    dfmacc_glm_metricas_dfm[strglmnum,2] <- summary(eval(parse(text=dfmacc_glm_modelos_list[strglmnum])))$deviance
    dfmacc_glm_metricas_dfm[strglmnum,3] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[strglmnum]))$overall[[1]]
    dfmacc_glm_metricas_dfm[strglmnum,4] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[strglmnum]))$byClass[[1]]
    dfmacc_glm_metricas_dfm[strglmnum,5] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[strglmnum]))$byClass[[2]]
    dfmacc_glm_coeff_dfm                 <- data.frame(summary(eval(parse(text=dfmacc_glm_modelos_list[strglmnum])))$coefficients)
    dfmacc_glm_metricas_dfm[strglmnum,6] <- nrow(dfmacc_glm_coeff_dfm)
    dfmacc_glm_metricas_dfm[strglmnum,7] <- nrow(dfmacc_glm_coeff_dfm [ dfmacc_glm_coeff_dfm$Pr...z.. < .1 , ] )
  }

  ###
  ### Inspeccionar metricas
  ###

  ### inspeccionar despues de ordenar y retirar algunas filas que no sirven mucho
  dfmacc_glm_metricas_dfm_sort <- dplyr::arrange( dfmacc_glm_metricas_dfm , desc( Acc ) )
  head( dfmacc_glm_metricas_dfm_sort , 50 )

  ### Grabar dfmacc_glm_metricas_dfm_sort en db .rdx/.rdb
  env_dfmacc_glm_metricas_dfm_sort <- new.env()
  assign( "dfmacc_glm_metricas_dfm_sort" , envsess01$dfmacc_glm_metricas_dfm_sort , envir = env_dfmacc_glm_metricas_dfm_sort )
  tools:::makeLazyLoadDB( env_dfmacc_glm_metricas_dfm_sort , "rdb/env_dfmacc_glm_metricas_dfm_sort" )

  ### solucion sqldf
  library(sqldf)

  ### inspeccionar con sqldf ==> definitivo
  nrow(
  tabacc_glm_metricas_dfm_sort <-
  sqldf::sqldf( "select Modelo , min(Dev) as mnDev , Acc , Sens , Spec , NCof as mxNC , max(NSig) as mxNS
                 from dfmacc_glm_metricas_dfm_sort
                 group by Acc , Sens , Spec
                 order by Acc desc
                 ")
  )

  ### tabla de 6160 metricas
  nrow( dfmacc_glm_metricas_dfm_sort )

  ### agrupar por Acc Sens Spec NCof y NSig
  ### - tenemos 690 modelos distintos
  ### - tenemos 3693 modelos distintos si agregamos Dev
  ### - tenemos 222 modelos distintos si quitamos NCof y NSig
  nrow(
  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 group by Acc, Sens, Spec, NCof, NSig
                 order by NSig desc
                 ")
  )

  ### modelos con pocas variables significativas
  ### - Sens es radicalmente mas baja
  ### - Dev tambien es menor bueno
  nrow(
  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 where NSig > 0
                 and   NCof-NSig > 0
                 order by NSig desc
                 ")
  )

  ### modelos con pocas variables significativas
  ### - Sens no son tan bajos , algunos casos son altas
  ### - Dev son mayores no tan bueno
  ### - Son modelos con ponderador mayormente
  ### - 4 consultas definitivas

  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 where NCof-NSig = 0
                 and   Sens < 1
                 group by Acc,Sens,Spec
                 order by Acc desc, Sens desc
                 limit 40
                 ")

  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 where NCof-NSig > 0
                 and   Sens < 1
                 group by Acc,Sens,Spec
                 order by Acc desc, Sens desc
                 limit 40
                 ")

  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 where NCof-NSig = 0
                 and   Sens < 1
                 group by Acc,Sens,Spec
                 order by Sens desc, Acc desc
                 limit 40
                 ")

  sqldf::sqldf( "select *
                 from dfmacc_glm_metricas_dfm_sort
                 where NCof-NSig > 0
                 and   Sens < 1
                 group by Acc,Sens,Spec
                 order by Sens desc, Acc desc
                 limit 40
                 ")

  ###
  ### Grafico dispersion glm
  ###

# ### preparar grafico que separe modelos ponderados versus no ponderados
# plot( dfmacc_glm_metricas_dfm_sort$Sens , dfmacc_glm_metricas_dfm_sort$Spec )
# substr( dfmacc_glm_metricas_dfm_sort$Modelo[1] , 9 , 9 )
# nrow( dfmacc_glm_metricas_dfm_sort [ substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) == "w" , ] )
# as.factor( levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) )

# plot( dfmacc_glm_metricas_dfm_sort$Sens , dfmacc_glm_metricas_dfm_sort$Spec , col=as.factor(levels(as.factor(substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) ))) )
# legend('topright', legend = levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=as.factor(levels(as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) ))) , cex=.8 , pch=1 )

# plot( dfmacc_glm_metricas_dfm_sort$Sens , dfmacc_glm_metricas_dfm_sort$Acc  , col=as.factor(levels(as.factor(substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) ))) )
# legend('topright', legend = levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=as.factor(levels(as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) ))) , cex=.8 , pch=1 )

# boxplot( dfmacc_glm_metricas_dfm_sort$Sens , as.factor(substr(dfmacc_glm_metricas_dfm_sort$Modelo,9,9)) )

# table( substr( dfmacc_glm_metricas_dfm_sort$Modelo,9,9 ) )
# setNames( aggregate( Sens ~ as.factor(substr(  dfmacc_glm_metricas_dfm_sort$Modelo,9,9 )) , dfmacc_glm_metricas_dfm_sort , c(mean,median,sd,length) ) , c( "Ponderacion" , "Sens" ) )
# setNames( aggregate( Sens ~ as.factor(substr(  dfmacc_glm_metricas_dfm_sort$Modelo,9,9 )) , dfmacc_glm_metricas_dfm_sort , sd   ) , c( "Ponderacion" , "Sens" ) )
# setNames( aggregate( Sens ~ as.factor(substr(  dfmacc_glm_metricas_dfm_sort$Modelo,9,9 )) , dfmacc_glm_metricas_dfm_sort , median ) , c( "Ponderacion" , "Sens" ) )
# setNames( aggregate( Sens ~ as.factor(substr(  dfmacc_glm_metricas_dfm_sort$Modelo,9,9 )) , dfmacc_glm_metricas_dfm_sort , length ) , c( "Ponderacion" , "Sens" ) )

  ### tablas definitivas separadas
  ### -
  tabagg_glm_metricas_accu <- do.call( data.frame , setNames( aggregate( Acc ~ as.factor(substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo,9,9)), data = env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort , FUN = function(x) c(xbar = mean(x), med = median(x), sd = sd(x), n = length(x) ) ) , c("Pond","Acc") ) )
  tabagg_glm_metricas_sens <- do.call( data.frame , setNames( aggregate( Sens ~ as.factor(substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo,9,9)), data = env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort , FUN = function(x) c(xbar = mean(x), med = median(x), sd = sd(x), n = length(x) ) ) , c("Pond","Sens") ) )
  tabagg_glm_metricas_spec <- do.call( data.frame , setNames( aggregate( Spec ~ as.factor(substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo,9,9)), data = env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort , FUN = function(x) c(xbar = mean(x), med = median(x), sd = sd(x), n = length(x) ) ) , c("Pond","Spec") ) )

  ### agregar nombres latex a cada tabla para informe usando xtable
  tabagg_glm_metricas_accu
 #tabagg_glm_metricas_accu_addtorow <- list()
 #tabagg_glm_metricas_accu_addtorow$pos <- list(0)
 #tabagg_glm_metricas_accu_addtorow$command <- c("Pond & Ac_{\\bar{x}} & Ac_{med} & Ac_{sd} & Ac_{n}\\\\\n")
 #print( xtable::xtable( tabagg_glm_metricas_accu ), add.to.row = tabagg_glm_metricas_accu_addtorow , include.colnames = FALSE )

  tabagg_glm_metricas_sens
 #tabagg_glm_metricas_sens_addtorow <- list()
 #tabagg_glm_metricas_sens_addtorow$pos <- list(0)
 #tabagg_glm_metricas_sens_addtorow$command <- c("Pond & Se_{\\bar{Se}} & Se_{med} & Se_{sd} & Se_{n}\\\\\n")
 #print( xtable::xtable( tabagg_glm_metricas_sens ), add.to.row = tabagg_glm_metricas_sens_addtorow , include.colnames = FALSE )

  tabagg_glm_metricas_spec
 #tabagg_glm_metricas_spec_addtorow <- list()
 #tabagg_glm_metricas_spec_addtorow$pos <- list(0)
 #tabagg_glm_metricas_spec_addtorow$command <- c("Pond & Sp_{\\bar{Se}} & Sp_{med} & Sp_{sd} & Sp_{n}\\\\\n")
 #print( xtable::xtable( tabagg_glm_metricas_spec ), add.to.row = tabagg_glm_metricas_spec_addtorow , include.colnames = FALSE )

  ### grabar estas metricas en su entorno
  env_tabagg_glm_metricas <- new.env()
  assign( "tabagg_glm_metricas_accu" , tabagg_glm_metricas_accu , envir = env_tabagg_glm_metricas )
  assign( "tabagg_glm_metricas_sens" , tabagg_glm_metricas_sens , envir = env_tabagg_glm_metricas )
  assign( "tabagg_glm_metricas_spec" , tabagg_glm_metricas_spec , envir = env_tabagg_glm_metricas )
  tools:::makeLazyLoadDB( env_tabagg_glm_metricas , "rdb/env_tabagg_glm_metricas" )

  ls( envir = env_tabagg_glm_metricas )

  ###
  ### Grafico que muestra diferencias entre modelos sin ponderar y ponderados definitivo
  ###

  ### grafico triple
  par(mfrow=c(3,1))

  ### modelo con ponderacion estima con mayor exactitud la Acc
  plot(    density( dfmacc_glm_metricas_dfm_sort$Acc [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) , main="" )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Acc [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Acc [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=col02 , xlim=c(0,1) )
  legend('topleft', legend = levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(col02,col01) , cex=.8 , pch=1 )
  title( main = "Acc" )

  ### modelo con ponderacion estima con mayor exactitud la Sens
  plot(    density( dfmacc_glm_metricas_dfm_sort$Sens [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) , main="" )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Sens [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Sens [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=col02 , xlim=c(0,1) )
  legend('topleft', legend = levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(col02,col01) , cex=.8 , pch=1 )
  title( main = "Sens" )

  ### modelo sin ponderacion tiende a sobre estimar la Spec
  plot(    density( dfmacc_glm_metricas_dfm_sort$Spec [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) , main="" )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Spec [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=col01 , xlim=c(0,1) )
  polygon( density( dfmacc_glm_metricas_dfm_sort$Spec [ substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=col02 , xlim=c(0,1) )
  legend('topleft', legend = levels( as.factor( substr( dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(col02,col01) , cex=.8 , pch=1 )
  title( main = "Spec" )

  ### analisis
  ### - con devianzas mayores a 100 todas las variables son significativas
  ###   mientras que con valores menores a 100 casi no hay variables significativas

  ### comentarios
  ### - con 3080 modelos tenemos que hay muchos modelos con metricas repetidas
  ### - necesitamos otras metricas o informacion de los modelos para analizar
  ###   como, numero de variables totales y numero de variables significativas,
  ###   curva ROC, pero tambien punto de corte optimo

  ###
  ### Grafico PCA que muestre la dispersion de las predicciones de mejor modelo glm
  ###

  ### crear objeto glm class comb para integrar FN , FP , TN , FP
  ### - crear objetos comb a partir de objetos class
  ### - usar mejor modelo glm ==> modglmfrw2584
  ### str(modglmfrw2584_class)
  ### - grabar en nuevo environment
  modglmfrw2584_comb <- data.frame( clase_est = envsess01$modglmfrw2584_class , clase_obs = envsess01$dfmbio_ctr$HOSPITALIZACION )
  modglmfrw2584_comb$comb <- "NADA"
  modglmfrw2584_comb$comb [  modglmfrw2584_comb$clase_est == "SI" & modglmfrw2584_comb$clase_obs == "SI"             ] <- "VP"
  modglmfrw2584_comb$comb [  modglmfrw2584_comb$clase_est == "NO" & modglmfrw2584_comb$clase_obs == "NO"             ] <- "VN"
  modglmfrw2584_comb$comb [  modglmfrw2584_comb$clase_est == "SI" & modglmfrw2584_comb$clase_obs == "NO"             ] <- "FP"
  modglmfrw2584_comb$comb [  modglmfrw2584_comb$clase_est == "NO" & modglmfrw2584_comb$clase_obs == "SI"             ] <- "FN"

  modglmfrw2584_comb

  ### crear objeto table glm class comb
  table_modglmfrw2584_comb <- table( envsess01$modglmfrw2584_class , envsess01$dfmbio_ctr$HOSPITALIZACION , dnn=c("glm","Obs") )

  table_modglmfrw2584_comb

  ### grabar en nuevo environment
  env_modglmfrw2584_comb <- new.env()
  assign( "modglmfrw2584_comb" , modglmfrw2584_comb , envir = env_modglmfrw2584_comb )
  assign( "table_modglmfrw2584_comb" , table_modglmfrw2584_comb , envir = env_modglmfrw2584_comb )
  tools:::makeLazyLoadDB( env_modglmfrw2584_comb , "rdb/env_modglmfrw2584_comb" )

  ### cargar para tener disponible en sesion nueva
  env_modglmfrw2584_comb <- new.env()
  base::lazyLoad( "rdb/env_modglmfrw2584_comb" )

  ### comparar glm predict versus confmat comb usando K-means
  plot( envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb) )
  legend( 'topright' , ncol = 3L , title = NULL , legend = c('', 'NO', 'SI', 'NO', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,1], 'SI', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
  legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1)

  ### comparar glm predict versus confmat comb usando PCA
  plot( envsess01$dfmbio_num_ctr_eigen_pca[,1] , envsess01$dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb) )
  legend( 'topright' , ncol = 3L , title = NULL , legend = c('', 'NO', 'SI', 'NO', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,1], 'SI', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
  legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb)), col = 1:4, cex = 0.8, pch = 1)

  ###
  ### Cambiar el analisis usando PR-AUC en vez de SS-AUC pendiente
  ###

  ### para muestra imbalanceada se recomienda usar mode = "prec_recall"
  ### - la informacion es la misma
  ### - mejor opcion es cambiar el punto de corte
  caret::confusionMatrix( modglmfrw2584_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI"                        )
  caret::confusionMatrix( modglmfrw2584_class , dfmbio_ctr$HOSPITALIZACION , positive = "SI" , mode = "prec_recall" )

  ### En cambio de usar prec_recall , estimamos punto de corte optimo
  ### logrando mejor accuracy. Reemplazaremos estos resultados por los
  ### generados en el dfmacc_glm_metricas_dfm_sort , porque tenemos mas
  ### metricas y las anteriores estaban solamente en el punto de corte
  ### de 0.5 por defecto. Los objetos seran:
  ### - dfmacc_glm_optimo_dfm
  ### - dfmacc_glm_optimo_dfm_sort
  ### Los objetos de insumo estan en el environment envsess02
  ### Crear metricas usando SS-AUC con punto de corte optimo
  dfmacc_glm_optimo_list             <- ls( pattern="^modglmfr[mw]\\d+_coords$" , envir = envsess02 )
  dfmacc_glm_optimo_dfm              <- data.frame( matrix( ncol=25 , nrow=length( dfmacc_glm_optimo_list ) ) )
  colnames( dfmacc_glm_optimo_dfm )  <- c( "Modelo", "thr", "spec", "sens", "acc", "tn", "tp", "fn", "fp", "npv", "ppv", "fdr", "fpr", "tpr", "tnr", "fnr", "1-spec", "1-sens", "1-acc", "1-npv", "1-ppv", "prec", "rec", "youd", "ctlf" )
 #for( strglmnum in 1:5                               ){
  for( strglmnum in 1:length( dfmacc_glm_optimo_list )){
   #print( paste0( "envsess02$" , dfmacc_glm_optimo_list[strglmnum] ) )
   #print( eval(parse(text=paste0( "envsess02$" , dfmacc_glm_optimo_list[strglmnum] ))) )
    dfmacc_glm_optimo_dfm[strglmnum,1] <- substr( paste0( "envsess02$" , dfmacc_glm_optimo_list[strglmnum] ) , 11 , 23 )
    dfmacc_glm_optimo_dfm[strglmnum,2:25] <- eval(parse(text=paste0( "envsess02$" , dfmacc_glm_optimo_list[strglmnum] )))
  }

# head( dfmacc_glm_optimo_dfm )
# tail( dfmacc_glm_optimo_dfm )

  ### grabar en environment propio
  env_dfmacc_glm_optimo_dfm <- new.env()
  assign( "dfmacc_glm_optimo_dfm" , dfmacc_glm_optimo_dfm , envir = env_dfmacc_glm_optimo_dfm )
  length(ls(env_dfmacc_glm_optimo_dfm))
  tools:::makeLazyLoadDB( env_dfmacc_glm_optimo_dfm , "rdb/env_dfmacc_glm_optimo_dfm" )

  ### cargar desde .rdx/.rdb a una sesion nueva
  env_dfmacc_glm_optimo_dfm <- new.env()
  base::lazyLoad( "rdb/env_dfmacc_glm_optimo_dfm" , envir = env_dfmacc_glm_optimo_dfm )
  ls(env_dfmacc_glm_optimo_dfm)
 #attach( env_dfmacc_glm_optimo_dfm )
  ls()
  class(env_dfmacc_glm_optimo_dfm)
  #?base::attach

  ### combinar 2 dfm y grabar en ultimo environment
  ### - dfmacc_glm_metricas_dfm_sort
  ### - dfmacc_glm_optimo_dfm
  ?base::merge
  colnames( env_dfmacc_glm_optimo_dfm$dfmacc_glm_optimo_dfm )  <- c( "Modelo", "thr_y", "spec_y", "sens_y", "acc_y", "tn_y", "tp_y", "fn_y", "fp_y", "npv_y", "ppv_y", "fdr_y", "fpr_y", "tpr_y", "tnr_y", "fnr_y", "1-spec_y", "1-sens_y", "1-acc_y", "1-npv_y", "1-ppv_y", "prec_y", "rec_y", "youd_y", "ctlf_y" )
  env_dfmacc_glm_optimo_dfm$dfmacc_glm_merge_dfm <- merge( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort , env_dfmacc_glm_optimo_dfm$dfmacc_glm_optimo_dfm , by="Modelo" )
  str(env_dfmacc_glm_optimo_dfm$dfmacc_glm_merge_dfm)
  names(env_dfmacc_glm_optimo_dfm)
  length(ls(env_dfmacc_glm_optimo_dfm))
  ls( envir = env_dfmacc_glm_optimo_dfm )
  tools:::makeLazyLoadDB( env_dfmacc_glm_optimo_dfm , "rdb/env_dfmacc_glm_optimo_dfm" )
  attach(env_dfmacc_glm_optimo_dfm)

  ### ordenar resultado y grabar
  sqldf::sqldf( "select *
                 from dfmacc_glm_optimo_dfm
                 where sens_y < 1
                 group by acc_y,sens_y,spec_y
                 order by acc_y desc, sens_y desc
                 limit 10
                 " , envir = env_dfmacc_glm_optimo_dfm )

  ?aggregate

  ### siguientes 4 consultas son equivalentes a las 4 anteriores pero con
  ### punto de corte optimo. La idea es elegir columnas nuevas para
  ### compararlas con las anteriores.  Hemos reemplazado estas consultas por
  ### las anteriores agregando mas columnas para comparar los dos puntos de
  ### corte.
  sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
                 from dfmacc_glm_merge_dfm
                 where NCof-NSig = 0
                 and Sens   <  1
                 group by Acc,Sens,Spec
                 order by Sens desc, Acc desc
                 limit 10
                 " , envir = env_dfmacc_glm_optimo_dfm )

  sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
                 from dfmacc_glm_merge_dfm
                 where NCof-NSig > 0
                 and Sens   <  1
                 group by Acc,Sens,Spec
                 order by Sens desc, Acc desc
                 limit 10
                 " , envir = env_dfmacc_glm_optimo_dfm )

  sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
                 from dfmacc_glm_merge_dfm
                 where NCof-NSig = 0
                 and Sens   <  1
                 group by Acc,Sens,Spec
                 order by Acc desc, Sens desc
                 limit 10
                 " , envir = env_dfmacc_glm_optimo_dfm )

  sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
                 from dfmacc_glm_merge_dfm
                 where NCof-NSig > 0
                 and Sens   <  1
                 group by Acc,Sens,Spec
                 order by Acc desc, Sens desc
                 limit 10
                 " , envir = env_dfmacc_glm_optimo_dfm )

  ### Posiblemente haya que generar de nuevo el objeto
  ### - env_dfmacc_glm_optimo_dfm
  ### ?pROC::coords

# ?caret::twoClassSummary
# ?caret::prSummary
# library(MLmetrics)
# ?caret::trainControl
# ?base::expand.grid

  ### se ve 3 mejores modelos: 55 , 57 y 58

#   str(dfmacc_glm_modelos_list)
#   class( dfmacc_glm_modelos_list )
#   dim( dfmacc_glm_modelos_list )[1]
#   ls( pattern="^modglmfrm\\d+$" )
#   length( dfmacc_glm_modelos_list )
#   rm( modglmfrm001 )
#   summary( eval(parse(text=dfmacc_glm_modelos_list[1])) )$deviance

#   dfmacc_glm_metricas_dfm[1,1] <- dfmacc_glm_modelos_list[1]
#   dfmacc_glm_metricas_dfm[1,2] <- summary(eval(parse(text=dfmacc_glm_modelos_list[1])))$deviance
#   dfmacc_glm_metricas_dfm[1,3] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[1]))$overall[[1]]
#   dfmacc_glm_metricas_dfm[1,4] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[1]))$byClass[[1]]
#   dfmacc_glm_metricas_dfm[1,5] <- eval(parse(text=dfmacc_glm_modelos_confmat_list[1]))$byClass[[2]]

# ### exportar para inspeccionar con bash
# ### - obsoleto
# write.table( dfmacc_glm_metricas_dfm_sort , file=file.path( srcdir , "csv/dfmacc_glm_metricas_dfm_sort.csv" ) , col.names=T , row.names=F , sep="," , quote=F )

# ### queremos inspeccionar modelos
# ### - obsoleto
# ?base::unique
# ?dplyr::distinct
# head( dfmacc_glm_metricas_dfm_sort [,c(2:5)] , 50 )
# head( dfmacc_glm_metricas_dfm_sort [ !duplicated( dfmacc_glm_metricas_dfm_sort [ , c(2:5) ] ) ] , 50 )
# library(magrittr)
# dfmacc_glm_metricas_dfm_sort %>% dplyr::distinct( Dev , Acc , Sens , Spec , keep.all=TRUE ) %>% head(50)
# #?magrittr::`%>%`

