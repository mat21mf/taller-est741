  ### Revision formulas porque no tienen intercepto, pero R deja DIABETES como intercepto
  ### https://stats.stackexchange.com/questions/213710/level-of-factor-taken-as-intercept

  envsess01 <- new.env()
  base::lazyLoad(     "Sesion"                 , envir = envsess01 )

  frmconint <- formula( HOSPITALIZACION ~    DIABETES )
  frmsinint <- formula( HOSPITALIZACION ~ -1+DIABETES )

  str( model.matrix( frmconint , data = envsess01$dfmbio_ctr ) )
  str( model.matrix( frmsinint , data = envsess01$dfmbio_ctr ) )

  table( envsess01$dfmbio_ctr$DIABETES )
