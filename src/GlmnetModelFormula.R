
###
### Crear model.formula tanto para glm como para glmnet y grabar en
### entorno especifico
### - no reemplaza model.matrix, sino que reemplaza el objeto glmnet
### entero ==> redefine la funcion completa
### - debiera sobre escribir los 70 modelos existentes
###

### glmnetUtils
library(glmnetUtils)
#?glmnetUtils::glmnet
?glmnetUtils::cv.glmnet
?glmnetUtils::cva.glmnet
?glmnet::cv.glmnet
?glmnet::deviance.glmnet
?glmnet::coef.glmnet

### definicion de ejemplo
mgm0001 <- glmnetUtils::glmnet( frm0001 , intercept = FALSE , data = dfmbio_ctr , family="binomial" , alpha = c(0, .1, .2, .4, .6, .8, 1) , parallel = TRUE )
