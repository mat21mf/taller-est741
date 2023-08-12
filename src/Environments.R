###
### Objetivo:
###
### - Cargar archivos rdb/rdx en entornos especificos con objetos como promises
### - No puede asignar objetos a diferentes entornos, eso hacerlo en otro script
###


### ### crear environments en nueva sesion
### new.env()

### assign( "cmat" , cmat , envir = env_aux )
### assign( "cmat_addtorow" , cmat_addtorow , envir = env_aux )
### assign( "cmat_invtorow" , cmat_invtorow , envir = env_aux )

### cargar lazyload db en entornos en forma automatica

env_aux <- new.env()
base::lazyLoad( "rdb/env_aux"                , envir = env_aux )

envsess01 <- new.env()
base::lazyLoad(     "Sesion"                 , envir = envsess01 )

env_dfmacc_glm_optimo_dfm <- new.env()
base::lazyLoad( "rdb/env_dfmacc_glm_optimo_dfm" , envir = env_dfmacc_glm_optimo_dfm )

env_dfmacc_glm_metricas_dfm_sort <- new.env()
base::lazyLoad( "rdb/env_dfmacc_glm_metricas_dfm_sort" , envir = env_dfmacc_glm_metricas_dfm_sort )

env_tabagg_glm_metricas <- new.env()
base::lazyLoad( "rdb/env_tabagg_glm_metricas" , envir = env_tabagg_glm_metricas )

env_modglmfrw2584_comb <- new.env()
base::lazyLoad( "rdb/env_modglmfrw2584_comb" , envir = env_modglmfrw2584_comb )

env_tabagg_glm_metricas <- new.env()
base::lazyLoad( "rdb/env_tabagg_glm_metricas" , envir = env_tabagg_glm_metricas )

env_modglmcvw2584 <- new.env()
base::lazyLoad( "rdb/env_modglmcvw2584" , envir = env_modglmcvw2584 )

env_frm <- new.env()
base::lazyLoad( "rdb/env_frm"                , envir = env_frm )
