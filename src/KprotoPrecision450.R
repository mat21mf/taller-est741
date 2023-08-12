  ### crear objetos matrix (vectores apilados) , list , dataframe (dfm) y poblar dfm
  dfmbio_ctr_nnzv_kpt_precision_450_matrix     <- `row.names<-`(do.call(rbind,mget( ls(pattern="seed\\d+_kpt\\d+_class"))), NULL)
  dfmbio_ctr_nnzv_kpt_precision_450_matrix_kpt <- `row.names<-`(do.call(rbind,mget( ls(pattern="seed\\d+_kpt\\d+$"     ))), NULL)
  dfmbio_ctr_nnzv_kpt_precision_450_list       <- ls(pattern="seed\\d+_kpt\\d+_class")
  dfmbio_ctr_nnzv_kpt_precision_450_dfm        <- data.frame( matrix( ncol=5 , nrow=450 ) )
  colnames(dfmbio_ctr_nnzv_kpt_precision_450_dfm) <- c( "Semilla" , "k" , "Acc" , "Sens" , "Spec" )
  for (strpre in 1:length(dfmbio_ctr_nnzv_kpt_precision_450_list)){
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,1] <-                                dfmbio_ctr_nnzv_kpt_precision_450_list[strpre]
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,1] <- sub( "dfmbio_ctr_nnzv_" , "" , dfmbio_ctr_nnzv_kpt_precision_450_dfm [strpre,1] )
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,1] <- sub( "_kpt\\d+_class"   , "" , dfmbio_ctr_nnzv_kpt_precision_450_dfm [strpre,1] )
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,2] <- nrow(dfmbio_ctr_nnzv_kpt_precision_450_matrix_kpt[strpre,]$centers)
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,3] <- caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_kpt_precision_450_matrix[strpre,]) ,
                                                                               dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )$overall[[1]]
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,4] <- caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_kpt_precision_450_matrix[strpre,]) ,
                                                                               dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )$byClass[[1]]
    dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,5] <- caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_kpt_precision_450_matrix[strpre,]) ,
                                                                               dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )$byClass[[2]]
  }

  ### dfmbio_ctr_nnzv_kpt_precision_450_dfm[strpre,2] <- mean( dfmbio_ctr_nnzv_kpt_precision_450_matrix[strpre,] == dfmbio_ctr_nnzv$HOSPITALIZACION )

  ### para kmeans solamente tenemos clases predichas por kmeans no podemos
  ### calcular metricas usando un vector de probabilidades porque no tenemos en
  ### este caso pero podemos calcular matriz de confusion y derivar metricas
  ### desde alli por lo tanto, no usamos ROCR , sino que usamos
  ### caret::confusionMatrix

# ?ROCR::performance
# ?ROCR::performance-class
# ?ROCR::prediction

  #?caret::confusionMatrix

# length(ls(pattern="seed\\d+_kpt\\d+$"))
# nrow(dfmbio_ctr_nnzv_kpt_precision_450_matrix_kpt[1,]$centers)
# nrow(dfmbio_ctr_nnzv_seed0001_kpt0001$centers)
# nrow(dfmbio_ctr_nnzv_seed0001_kpt0002$centers)

# dfmbio_ctr_nnzv_kpt_precision_450_matrix[1,]
# str(dfmbio_ctr_nnzv_kpt_precision_450_matrix)
# class(dfmbio_ctr_nnzv_kpt_precision_450_matrix)
# head(dfmbio_ctr_nnzv_kpt_precision_450_matrix)
# class(as.factor(dfmbio_ctr_nnzv_kpt_precision_450_matrix[1,]))

# attach( dfmbio_ctr_nnzv_kpt_precision_450_dfm                 )
# rm    ( dfmbio_ctr_nnzv_kpt_precision_450_dfm                 )
# detach( dfmbio_ctr_nnzv_kpt_precision_450_dfm , unload = TRUE )

  head( dplyr::arrange( dfmbio_ctr_nnzv_kpt_precision_450_dfm , desc( Acc ) ) , 25 )
  tail( dplyr::arrange( dfmbio_ctr_nnzv_kpt_precision_450_dfm , desc( Acc ) ) , 25 )

  ### seleccionamos estos 3 resultados segun precision kproto para graficar
  table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0033_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0020_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )

  ### seleccionamos estos 3 resultados segun precision kproto para graficar
  caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class) , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )
  caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_seed0033_kpt0001_class) , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )
  caret::confusionMatrix( as.factor(dfmbio_ctr_nnzv_seed0020_kpt0001_class) , dfmbio_ctr_nnzv$HOSPITALIZACION , positive = "SI" )

  ###
  ### otras funciones graficas no usar
  ###

  #?cluster::clusplot
  #library(fpc)
  #utils::help( package = "fpc" )
  #?fpc::plotcluster
  #cluster::clusplot( pam( dfmbio_ctr_nnzv[,-10] , 2 ) )
  #fpc::plotcluster( dfmbio_ctr_nnzv[,-10] , as.numeric(dfmbio_ctr_nnzv_seed0045_kpt0001$cluster)                                   )

  ### analizar objetos a graficar
  colnames( base::Filter( is.numeric , dfmbio_ctr_nnzv ) )
  str(dfmbio_ctr_nnzv_seed0045_kpt0001$cluster)
  class(as.numeric(dfmbio_ctr_nnzv_seed0045_kpt0001$cluster))
  class(dfmbio_ctr_nnzv_seed0033_kpt0001_class  )
  class(dfmbio_fac$HOSPITALIZACION)
  plot( dfmbio_ctr_nnzv[,-10] , col=dfmbio_ctr_nnzv_seed0020_kpt0001$cluster )
  points( dfmbio_ctr_nnzv_seed0045_kpt0001$center , col=1:2 )

  ###
  ### graficar para comparar cluster kproto o class kproto versus distancias kproto
  ### - incluso se podria comparar distancias versus HOSPITALIZACION
  ###

  ### graficar 3 kproto seleccionados
  ### - usar 2 vectores de distancias que tiene cada objeto kproto
  plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=dfmbio_ctr_nnzv_seed0045_kpt0001$cluster )
  legend('topright', legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class)  ), col = 1:2, cex = 0.8, pch = 1)

  ### graficar 3 kproto seleccionados
  ### - comparar con variable de respuesta
  plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(dfmbio_ctr$HOSPITALIZACION) )
  legend('topright', legend = levels(as.factor(dfmbio_ctr$HOSPITALIZACION) ), col = 1:2, cex = 0.8, pch = 1)

  ### integrar falsos positivos en el grafico en objeto comb
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb <- data.frame( clase_est = dfmbio_ctr_nnzv_seed0045_kpt0001_class , clase_obs = dfmbio_ctr$HOSPITALIZACION )
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb <- "NADA"
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb [  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_est == "SI" & dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_obs == "SI"             ] <- "VP"
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb [  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_est == "NO" & dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_obs == "NO"             ] <- "VN"
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb [  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_est == "SI" & dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_obs == "NO"             ] <- "FP"
  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb [  dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_est == "NO" & dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$clase_obs == "SI"             ] <- "FN"

  ### verificar nuevo vector
  table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr$HOSPITALIZACION , dnn = c( "kpt" , "obs" ) )
  str(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb)
  head(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb,15)
  table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )
  class(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)
  class(dfmbio_ctr_nnzv_seed0045_kpt0001$cluster)

  ### definir table
  table_seed0045_kpt0001_comb <- table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr$HOSPITALIZACION , dnn=c("kpt","Obs") )
  envsess01$table_seed0045_kpt0001_comb
  table_seed0045_kpt0001_comb[,1]
  table_seed0045_kpt0001_comb[,2]

# ### Por error los objetos confmat para kpt no fueron creados ==> No,
# ### era error en la formula de Spec. Esta todo bien. OK
# ### - dfmbio_ctr_nnzv_seed0045_kpt0001_confmat no existe, hay que
# ### crearlo
# ### - las formulas de caret::confusionMatrix no coinciden con lo que
# ### aparece en la internet
# ### - dfmbio_ctr_nnzv_kpt0001_confmat es solo un objeto de muestra, no
# ### tiene nada que ver con los resultados
# get( "dfmbio_ctr_nnzv_kpt0001_confmat" , envir = envsess01 )
# assign( "dfmbio_ctr_nnzv_kpt0001_confmat" , envsess01$dfmbio_ctr_nnzv_kpt0001_confmat , envir = .GlobalEnv )
# ls(envir = .GlobalEnv)
# rm( dfmbio_ctr_nnzv_kpt0001_confmat )
# dfmbio_ctr_nnzv_kpt0001_confmat
# dfmbio_ctr_nnzv_kpt0001_confmat$byClass['Sensitivity']
# dfmbio_ctr_nnzv_kpt0001_confmat$byClass['Specificity']
# ### Inspeccionar objetos de interes en envir especifico
# ### - solo fueron creados objetos _class, faltan objetos _confmat
# length( ls( pattern = "^dfmbio_ctr_nnzv_seed\\d+_kpt\\d+$" , envir = envsess01 ) )
# length( ls( pattern = "^dfmbio_ctr_nnzv_seed\\d+_kpt\\d+_class$" , envir = envsess01 ) )
# ### carguemos objeto _class de interes
# assign( "dfmbio_ctr_nnzv_seed0045_kpt0001"       , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001       , envir = .GlobalEnv )
# assign( "dfmbio_ctr_nnzv_seed0045_kpt0001_class" , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001_class , envir = .GlobalEnv )
# assign( "dfmbio_ctr"                             , envsess01$dfmbio_ctr                             , envir = .GlobalEnv )
# head( cbind( dfmbio_ctr$HOSPITALIZACION , dfmbio_ctr_nnzv_seed0045_kpt0001_class ) , 20 )
# table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr$HOSPITALIZACION , dnn=c( "Pred" , "Obs" ) )
# caret::confusionMatrix( as.factor( dfmbio_ctr_nnzv_seed0045_kpt0001_class ) , dfmbio_ctr$HOSPITALIZACION , positive = "SI"         )
# str(dfmbio_ctr_nnzv_seed0045_kpt0001)
# dfmbio_ctr_nnzv_seed0045_kpt0001_pred <- predict( as.factor( dfmbio_ctr_nnzv_seed0045_kpt0001$cluster ) , data = dfmbio_ctr[,-21] )
# ls()
# ls( envir = env_modglmfrw2584_comb )
# rm( dfmbio_ctr )
# rm( dfmbio_ctr_nnzv_kpt0001_confmat )
# rm( dfmbio_ctr_nnzv_seed0045_kpt0001 )
# rm( dfmbio_ctr_nnzv_seed0045_kpt0001_class )

  ### inspeccionar por ultima vez resultado kpt
  assign( "dfmbio_ctr_nnzv_kpt_precision_450_dfm" , envsess01$dfmbio_ctr_nnzv_kpt_precision_450_dfm , envir = .GlobalEnv )
  head( dfmbio_ctr_nnzv_kpt_precision_450_dfm )
  head( dplyr::arrange( dfmbio_ctr_nnzv_kpt_precision_450_dfm , desc( Sens ) ) )
  rm( dfmbio_ctr_nnzv_kpt_precision_450_dfm )
  ls()

  ### definitiva a presentacion
  sqldf::sqldf( "select *
                 from dfmbio_ctr_nnzv_kpt_precision_450_dfm
                 group by Acc,Sens,Spec
                 order by k asc, Acc desc, Sens desc
                 limit 5
                 " , envir = envsess01 )

  ### definitiva a presentacion
  sqldf::sqldf( "select *
                 from dfmbio_ctr_nnzv_kpt_precision_450_dfm
                 group by Acc,Sens,Spec
                 order by k asc, Sens desc, Acc desc
                 limit 5
                 " , envir = envsess01 )

  sqldf::sqldf( "select count(*)
                 from ( select *
                 from dfmbio_ctr_nnzv_kpt_precision_450_dfm
                 group by Acc,Sens,Spec
                 )
                 " , envir = envsess01 )


  ### sqldf usa environment tambien, asi que corregir otras consultas, OK
  ls( envir = env_dfmacc_glm_metricas_dfm_sort )

  ### opcion 01b con table en legend ==> definitivo
  ### - solamente si se definen cada elemento en forma individual
  plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
  legend('topright', ncol = 3L, title = NULL , legend = c('', 'NO', 'SI', 'NO', table_seed0045_kpt0001_comb[,1], 'SI', table_seed0045_kpt0001_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
  legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1)
  ### grafico sugiere que se pueden ejecutar mas corridas para mejorar la clasificacion
  ### k-means se ejecuto con la muestra completa

  ### combinar PCA con k-means

  ### matrix confusion table entre PCA (PC1 y PC2) y k-means

  ### graficar PCA bien calculado combinar con k-means
  plot( dfmbio_num_ctr_eigen_pca[,1] , dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
  legend('topright', ncol = 3L, title = NULL , legend = c('', 'NO', 'SI', 'NO', table_seed0045_kpt0001_comb[,1], 'SI', table_seed0045_kpt0001_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
  legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)), col = 1:4, cex = 0.8, pch = 1)

  ### graficar PCA bien calculado combinar con k-means
  ### - comparar con variable respuesta
  plot( dfmbio_num_ctr_eigen_pca[,1] , dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(dfmbio_ctr$HOSPITALIZACION) )
  legend( 'topright' , legend = levels(as.factor(dfmbio_ctr$HOSPITALIZACION)), col = 1:2, cex = 0.8, pch = 1)

  ### graficar 3 kproto seleccionados
  ### - usar 2 vectores de distancias que tiene cada objeto kproto
  plot( dfmbio_ctr_nnzv_seed0033_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0033_kpt0001$dists[,2] , col=dfmbio_ctr_nnzv_seed0033_kpt0001$cluster )
  legend('topright', legend = levels(as.factor(dfmbio_ctr_nnzv_seed0033_kpt0001_class)  ), col = 1:2, cex = 0.8, pch = 1)

  ### comparar estas distancias con HOSPITALIZACION
  ### - no se pueden comparar porque las distancias son inherentes del algoritmo
  plot( dfmbio_ctr_nnzv_seed0033_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0033_kpt0001$dists[,2] , col=dfmbio_ctr_nnzv$HOSPITALIZACION          )
  legend('topright', legend = levels(          dfmbio_ctr_nnzv$HOSPITALIZACION          ), col = 1:2, cex = 0.8, pch = 1)

  ###
  ### comparar HOSPITALIZACION versus otra variable no hace mucho sentido
  ### - todos los graficos usados en internet requieren 2 componentes que resuman toda
  ###   la informacion
  ### - habria que graficar una variable en contra de todas las demas , no he visto que se haga
  ###

  ### comparar con PSA
  plot( dfmbio_fac$PSA                        , col=dfmbio_fac$HOSPITALIZACION )
  legend('topright', legend = levels(dfmbio_fac$HOSPITALIZACION ), col = 1:2, cex = 0.8, pch = 1)

  ### comparar con EDAD
  plot( dfmbio_fac$EDAD                       , col=dfmbio_fac$HOSPITALIZACION )
  legend('topright', legend = levels(dfmbio_fac$HOSPITALIZACION ), col = 1:2, cex = 0.8, pch = 1)

  ### silhouette tuvo baja precision
  table( dfmbio_ctr_nnzv_seed0016_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0030_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0042_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0047_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0048_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )
  table( dfmbio_ctr_nnzv_seed0050_kpt0001_class , dfmbio_ctr_nnzv$HOSPITALIZACION , dnn=c( "Kproto" , "Observado" ) )

# sub( "dfmbio_ctr_nnzv_" , "" , dfmbio_ctr_nnzv_kpt_precision_450_list[1] )
# #?sub

# ### descartados

# ### opcion 01a con table en text
# ### - no asigna posicion correcta a cada elemento de la tabla
# plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
# text( 40,48.5, table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr$HOSPITALIZACION ) )

# ### opcion 01c sin table
# ### - cuesta ajustar text con legend
# plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
# legend( 33 , 50              , legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1)
# text( 40,48.5, table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb , dnn=c("FN") )[1] , col = 1 )
# text( 40,46.8, table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb , dnn=c("FP") )[2] , col = 2 )
# text( 40,45.1, table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb , dnn=c("VN") )[3] , col = 3 )

# ### no usar
# library(plotrix)
# ?plotrix::addtable2plot

# ### opcion 02 con table
# plot( dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
# plotrix::addtable2plot( 38,44, table( dfmbio_ctr_nnzv_seed0045_kpt0001_class , dfmbio_ctr$HOSPITALIZACION ) )


# legend('topright', legend = levels(as.factor(dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1 , c( table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )[1] ) )
# apply( 2 , dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb , length )
# aggregate( comb ~ . , dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb , length )[,3]
# table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )
# table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )[1]
# table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )[2]
# table( dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb )[3]

