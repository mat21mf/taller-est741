  ###
  ### Crear metricas glmnet
  ###
  ### Pendientes:
  ###
  ### - volver a estimar con variables renombradas
  ### - para recrear modelos sin validacion cruzada
  ### - extendider la lista de modelos desde 70 hasta 6160
  ### - hemos definido grid para alpha y lamba con 280 valores total
  ### - podemos sacar la deviance para un objeto glmnet.train, para un
  ### objeto caret.train se puede reproducir manualmente
  ### - tenemos que extraer coef() para saber cuales son significativos
  ### - tenemos que generar predict para puntos de corte optimo, la idea
  ### es hacer lo mas comparable este resultado con el de glm
  ###

  ### crear metricas usando SS-AUC con punto de corte por defecto ==> 0.5
  dfmacc_gnt_modelos_list             <- ls(pattern="^modgntfrm\\d+$")
  dfmacc_gnt_modelos_confmat_list     <- ls(pattern="^modgntfrm\\d+_confmat$")
  dfmacc_gnt_metricas_dfm             <- data.frame( matrix( ncol=5 , nrow=length( dfmacc_gnt_formulas_list ) ) )
  colnames( dfmacc_gnt_metricas_dfm ) <- c( "Formula" , "Dev" , "Acc" , "Sens" , "Spec" )
  for( strgntnum in 1:length( dfmacc_gnt_formulas_list )){
    dfmacc_gnt_metricas_dfm[strgntnum,1] <- dfmacc_gnt_formulas_list[strgntnum]
    dfmacc_gnt_metricas_dfm[strgntnum,2] <- glmnet::deviance.glmnet(eval(parse(text=dfmacc_gnt_modelos_list[strgntnum])))
    dfmacc_gnt_metricas_dfm[strgntnum,3] <- eval(parse(text=dfmacc_gnt_modelos_confmat_list[strgntnum]))$overall[[1]]
    dfmacc_gnt_metricas_dfm[strgntnum,4] <- eval(parse(text=dfmacc_gnt_modelos_confmat_list[strgntnum]))$byClass[[1]]
    dfmacc_gnt_metricas_dfm[strgntnum,5] <- eval(parse(text=dfmacc_gnt_modelos_confmat_list[strgntnum]))$byClass[[2]]
  }

  ### primera tabla de 70 modelos
  ### - Sens son muy bajos
  dfmacc_gnt_metricas_dfm <- dplyr::arrange( dfmacc_gnt_metricas_dfm , desc( Acc ) )
  head( dfmacc_gnt_metricas_dfm , 25 )

  ### se grabo dfmacc_gnt_metricas_dfm en envsess01
  sqldf::sqldf("select *
                from dfmacc_gnt_metricas_dfm
                group by Acc,Sens,Spec
                order by Acc desc, Sens desc
                limit 10
                ", envir = envsess01 )

  sqldf::sqldf("select *
                from dfmacc_gnt_metricas_dfm
                group by Acc,Sens,Spec
                order by Sens desc, Acc desc
                limit 10
                ", envir = envsess01 )

