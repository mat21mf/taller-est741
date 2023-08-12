
### generar predict glm para punto de corte optimo
### - solo para muestra train
### - para muestra prueba usaremos cross validation pendiente
### - seran grabados en nuevo environment
### - detach no funciona infelizmente
### - objetos no pudieron grabarse , solo el resultado final

?pROC::coords

#for(strglminc in 1:5){
if( length(ls(envsess02))/3 == 6160 ){
for(strglminc in 1:envsess01$strnumfrm){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmprd <- paste0( "envsess02$modglmfrm" , strglmfmt , "_pred   <- predict( envsess01$modglmfrm" , strglmfmt , " , data = envsess01$dfmbio_ctr )" )
  strglmprw <- paste0( "envsess02$modglmfrw" , strglmfmt , "_pred   <- predict( envsess01$modglmfrw" , strglmfmt , " , data = envsess01$dfmbio_ctr )" )
  strglmroc <- paste0( "envsess02$modglmfrm" , strglmfmt , "_roc    <- pROC::roc( envsess01$dfmbio_ctr$HOSPITALIZACION , envsess02$modglmfrm" , strglmfmt , "_pred , direction = \"<\" , levels = c( \"NO\" , \"SI\" ) )" )
  strglmrow <- paste0( "envsess02$modglmfrw" , strglmfmt , "_roc    <- pROC::roc( envsess01$dfmbio_ctr$HOSPITALIZACION , envsess02$modglmfrw" , strglmfmt , "_pred , direction = \"<\" , levels = c( \"NO\" , \"SI\" ) )" )
  strglmcor <- paste0( "envsess02$modglmfrm" , strglmfmt , "_coords <- pROC::coords( envsess02$modglmfrm" , strglmfmt , "_roc , input = \"threshold\", x = \"best\" , ret = \"all\" , method = \"youden\" , transpose = FALSE , best.weights = c(envsess01$proporcion,1-envsess01$proporcion) )" )
  strglmcow <- paste0( "envsess02$modglmfrw" , strglmfmt , "_coords <- pROC::coords( envsess02$modglmfrw" , strglmfmt , "_roc , input = \"threshold\", x = \"best\" , ret = \"all\" , method = \"youden\" , transpose = FALSE , best.weights = c(envsess01$proporcion,1-envsess01$proporcion) )" )
  strenvprd <- paste0( "assign( \"modglmfrm" , strglmfmt , "_pred\"   , envsess02$modglmfrm" , strglmfmt , "_pred   , envir = envsess02 )" )
  strenvprw <- paste0( "assign( \"modglmfrw" , strglmfmt , "_pred\"   , envsess02$modglmfrw" , strglmfmt , "_pred   , envir = envsess02 )" )
  strenvroc <- paste0( "assign( \"modglmfrm" , strglmfmt , "_roc\"    , envsess02$modglmfrm" , strglmfmt , "_roc    , envir = envsess02 )" )
  strenvrow <- paste0( "assign( \"modglmfrw" , strglmfmt , "_roc\"    , envsess02$modglmfrw" , strglmfmt , "_roc    , envir = envsess02 )" )
  strenvcor <- paste0( "assign( \"modglmfrm" , strglmfmt , "_coords\" , envsess02$modglmfrm" , strglmfmt , "_coords , envir = envsess02 )" )
  strenvcow <- paste0( "assign( \"modglmfrw" , strglmfmt , "_coords\" , envsess02$modglmfrw" , strglmfmt , "_coords , envir = envsess02 )" )
 #print( strglmprd )
 #print( strglmprw )
 #print( strglmroc )
 #print( strglmrow )
 #print( strglmcor )
 #print( strglmcow )
 #print( strenvprd )
 #print( strenvprw )
 #print( strenvroc )
 #print( strenvrow )
 #print( strenvcor )
 #print( strenvcow )
 #print( strdetprd )
 #print( strdetprw )
 #print( strdetroc )
 #print( strdetrow )
 #print( strdetcor )
 #print( strdetcow )
  eval( parse( text = strglmprd ) )
  eval( parse( text = strglmprw ) )
  eval( parse( text = strglmroc ) )
  eval( parse( text = strglmrow ) )
  eval( parse( text = strglmcor ) )
  eval( parse( text = strglmcow ) )
  eval( parse( text = strenvprd ) )
  eval( parse( text = strenvprw ) )
  eval( parse( text = strenvroc ) )
  eval( parse( text = strenvrow ) )
  eval( parse( text = strenvcor ) )
  eval( parse( text = strenvcow ) )
}
}

#for(strglminc in 1:5){
if( length(ls(envsess02))/3 == 0 ){
for(strglminc in 1:envsess01$strnumfrm){
  strglmfmt <- formatC( strglminc , width=4, format="d" , flag="0" )
  strglmprd <- paste0( "modglmfrm" , strglmfmt , "_pred   <- predict( envsess01$modglmfrm" , strglmfmt , " , data = envsess01$dfmbio_ctr )" )
  strglmprw <- paste0( "modglmfrw" , strglmfmt , "_pred   <- predict( envsess01$modglmfrw" , strglmfmt , " , data = envsess01$dfmbio_ctr )" )
  strglmroc <- paste0( "modglmfrm" , strglmfmt , "_roc    <- pROC::roc( envsess01$dfmbio_ctr$HOSPITALIZACION , modglmfrm" , strglmfmt , "_pred , direction = \"<\" , levels = c( \"NO\" , \"SI\" ) )" )
  strglmrow <- paste0( "modglmfrw" , strglmfmt , "_roc    <- pROC::roc( envsess01$dfmbio_ctr$HOSPITALIZACION , modglmfrw" , strglmfmt , "_pred , direction = \"<\" , levels = c( \"NO\" , \"SI\" ) )" )
  strglmcor <- paste0( "modglmfrm" , strglmfmt , "_coords <- pROC::coords( modglmfrm" , strglmfmt , "_roc , ret = \"all\" , x = \"best\" , method = \"youden\" , transpose = FALSE , best.weights = c(envsess01$proporcion,1-envsess01$proporcion) )" )
  strglmcow <- paste0( "modglmfrw" , strglmfmt , "_coords <- pROC::coords( modglmfrw" , strglmfmt , "_roc , ret = \"all\" , x = \"best\" , method = \"youden\" , transpose = FALSE , best.weights = c(envsess01$proporcion,1-envsess01$proporcion) )" )
  strenvprd <- paste0( "assign( \"modglmfrm" , strglmfmt , "_pred\"   , modglmfrm" , strglmfmt , "_pred   , envir = envsess02 )" )
  strenvprw <- paste0( "assign( \"modglmfrw" , strglmfmt , "_pred\"   , modglmfrw" , strglmfmt , "_pred   , envir = envsess02 )" )
  strenvroc <- paste0( "assign( \"modglmfrm" , strglmfmt , "_roc\"    , modglmfrm" , strglmfmt , "_roc    , envir = envsess02 )" )
  strenvrow <- paste0( "assign( \"modglmfrw" , strglmfmt , "_roc\"    , modglmfrw" , strglmfmt , "_roc    , envir = envsess02 )" )
  strenvcor <- paste0( "assign( \"modglmfrm" , strglmfmt , "_coords\" , modglmfrm" , strglmfmt , "_coords , envir = envsess02 )" )
  strenvcow <- paste0( "assign( \"modglmfrw" , strglmfmt , "_coords\" , modglmfrw" , strglmfmt , "_coords , envir = envsess02 )" )
 #print( strglmprd )
 #print( strglmprw )
 #print( strglmroc )
 #print( strglmrow )
 #print( strglmcor )
 #print( strglmcow )
 #print( strenvprd )
 #print( strenvprw )
 #print( strenvroc )
 #print( strenvrow )
 #print( strenvcor )
 #print( strenvcow )
 #print( strdetprd )
 #print( strdetprw )
 #print( strdetroc )
 #print( strdetrow )
 #print( strdetcor )
 #print( strdetcow )
  eval( parse( text = strglmprd ) )
  eval( parse( text = strglmprw ) )
  eval( parse( text = strglmroc ) )
  eval( parse( text = strglmrow ) )
  eval( parse( text = strglmcor ) )
  eval( parse( text = strglmcow ) )
  eval( parse( text = strenvprd ) )
  eval( parse( text = strenvprw ) )
  eval( parse( text = strenvroc ) )
  eval( parse( text = strenvrow ) )
  eval( parse( text = strenvcor ) )
  eval( parse( text = strenvcow ) )
}
}

