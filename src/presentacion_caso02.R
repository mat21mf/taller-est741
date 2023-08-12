#' ---
#' title:  |
#'         | Identificación de factores de riesgo en
#'         | pacientes de diabetes post pabellón.
#' author: |
#'         | Matías F. Rebolledo G.
#' date: Martes,  8 de Octubre de 2019
#' output:
#'   beamer_presentation:
#'     theme: Marburg
#'     colortheme: orchid
#'     includes:
#'       in_header: tex/beamer_header.tex
#' classoption: "aspectratio=169"
#' ---

#'

#' ***

#'

#' Objetivos:  
#' \vspace{.75mm}
#' \(\bullet\) Identificar factores de riesgo asociados a la reincidencia de pacientes
#'   en un periodo de 30 posterior a intervención en pabellón.

#'

#' \vskip .5cm

#'

#' Estrategias:  
#' \vspace{.75mm}
#' \(\bullet\) Muestra hecha a partir de un cuestionario que contiene variables altamente
#' colineales  
#'   \hspace{.5cm} \(\Longrightarrow\) Modelo de regularización en la función de verosimilitud  
#' \(\bullet\) Muestra imbalanceada con una proporción de casos de un
#' `r I(round( nrow( envsess01$dfmbio [ envsess01$dfmbio$HOSPITALIZACION == "SI" , ]) / nrow( envsess01$dfmbio ),2))`%
#' versus de controles de
#' `r I(round( nrow( envsess01$dfmbio [ envsess01$dfmbio$HOSPITALIZACION == "NO" , ]) / nrow( envsess01$dfmbio ),2))`%  
#'   \hspace{.5cm} \(\Longrightarrow\) Optimización de costo de sensitividad usando ponderación  
#'   \hspace{.5cm} \(\Longrightarrow\) Modelo con remuestreo para muestra imbalanceada  
#' \(\bullet\) Número total de pacientes de `r I(nrow(envsess01$dfmbio))`.  
#'   \hspace{.5cm} \(\Longrightarrow\) Modelo con validación cruzada  

#'

#' ***

#'

#' \fontsize{12}{7.8}\selectfont
#' Etapas:  
#' \vspace{.75mm}
#' \(\bullet\) Etapa análisis descriptivo  
#'   \hspace{.5cm} \(\circ\) Grupo incluido variables factor  
#' \begin{columns}
#' \begin{column}{.05\textwidth}
#' \end{column}
#' \begin{column}{.50\textwidth}
#'                 DIABETES,
#'                 BIOP.PREV,
#'                 VOL.PROST,\\
#'                 ANTIB.PROFI,
#'                 BIOPSIA\\
#' \end{column}
#' \begin{column}{.45\textwidth}
#' \end{column}
#' \end{columns}
#'   \hspace{.5cm} \(\circ\) Grupo excluido variables factor  
#' \begin{columns}
#' \begin{column}{.05\textwidth}
#' \end{column}
#' \begin{column}{.50\textwidth}
#'                 EPOC,
#'                 NUM.DIAS.POST.BIOP,\\
#'                 FIEBRE,
#'                 TIPO.CULTIVO,\\
#'                 AGENTE.AISLADO,
#'                 PATR.RESIST\\
#' \end{column}
#' \begin{column}{.45\textwidth}
#' \(\Longrightarrow\) Combinación de fórmulas\\
#' \hspace{ .7cm} desde 1 ... 3080\\
#' \end{column}
#' \end{columns}
#'   \hspace{.5cm} \(\circ\) Grupo opcional variables factor  
#' \begin{columns}
#' \begin{column}{.05\textwidth}
#' \end{column}
#' \begin{column}{.50\textwidth}
#'                 HOSP.ULT.MES,
#'                 CUP,
#'                 ITU\\
#' \end{column}
#' \begin{column}{.45\textwidth}
#' \end{column}
#' \end{columns}
#' \(\bullet\) Etapa de tipificación de usando k-means  
#' \(\bullet\) Etapa modelación para identificar variables significativas  
#'   \hspace{.5cm} \(\circ\) Identificar modelos con métricas más elevadas  
#'   \hspace{.5cm} \(\circ\) Usar otras métricas que representen mejor
#' el imbalance, tales como,  
#'   \hspace{ 1cm} Precision, Recall, F1 y Precision-Recall-AUC o punto de corte
#' óptimo  
#' \(\bullet\) Etapa de configuración de modelos para controlar parámetros específicos  
#'   \hspace{.5cm} \(\circ\) Estimación de parámetros usando grillas  
#'   \hspace{.5cm} \(\circ\) Cost-Sensitive Training  

#'

#' ***

#'

#' ```{r chunk0001 , echo = F }
#' source( "Environments.R" )
#' ```

#'

#' ```{r chunk0002 , echo = F }
#' knitr::kable( head( envsess01$dfmbio_num_cor [ envsess01$dfmbio_num_cor$cor_x == "HOSPITALIZACION" , ] ,  6 ) ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,4,4,4,0,0) )
#' ```

#'

#' ***

#'

#' ```{r chunk0003 , echo = F }
#' knitr::kable( head( envsess01$dfmbio_num_cor [ envsess01$dfmbio_num_cor$cor_x != "HOSPITALIZACION" , ] , 14 ) ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,4,4,4,0,0) )
#' ```

#'

#' ***

#'

#' ```{r chunk0004 , echo = F }
#' plot(    density( envsess01$dfmbio$EDAD [ envsess01$dfmbio$HOSPITALIZACION == "NO" ] ) , col=envsess01$col01 , xlim=c(35,85) , main="" )
#' polygon( density( envsess01$dfmbio$EDAD [ envsess01$dfmbio$HOSPITALIZACION == "NO" ] ) , col=envsess01$col01 , xlim=c(35,85) )
#' polygon( density( envsess01$dfmbio$EDAD [ envsess01$dfmbio$HOSPITALIZACION == "SI" ] ) , col=envsess01$col02 , xlim=c(35,85) )
#' legend('topleft', legend = levels( as.factor( envsess01$dfmbio$HOSPITALIZACION ) ) , col=c(envsess01$col01,envsess01$col02) , cex=.8 , pch=1 )
#' title( main = "Densidad de Edad entre casos versus controles" )
#' ```

#'

#' ***

#'

#' PCA:  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Propósitos:  
#'     \hspace{1cm} \(\circ\) Graficar PCA para visualizar separación de la variable de respuesta  
#'     \hspace{1cm} \(\circ\) Para visualizar separación de otros modelos de clasificación  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Mejoras:  
#'     \hspace{1cm} \(\circ\) Se usaron 2 versiones de matriz de correlaciones: para datos continuos
#' (stats::cor) y para datos mixtos (polycor::hetcor) obteniendo las mismas PCA siempre usando
#' datos centrados  
#'     \hspace{1cm} \(\circ\) Se usó la siguiente fórmula  
#' \vspace{-.8cm}
#' \begin{align*}
#' \text{COMP}_{PCA} &= \left[\text{EIG(COV)}^T * \text{DATOS}^T\right]^T\\
#' (n \times p)      &= \left[(p \times p)^T    * (p \times n) \right]^T  = (n \times p)\\
#' \end{align*}
#' \vspace{-1.8cm}
#'     \hspace{1cm} \(\circ\) Se usó una librería especializada para graficar las PCA, pero no soporta
#' data.frame ni matrix, solo objetos prcomp. La reemplazamos por la función base.  
#'     \hspace{1cm} \(\circ\) Usamos la nube base PCA (PC1 versus PC2) para visualizar la clasificación
#' de otros modelos  

#'

#' ***

#'

#' ```{r chunk0005 , echo = F }
#' require(ggplot2)
#' factoextra::fviz_pca_ind( envsess01$dfmbio_num_ctr_pca ,
#'  geom.ind = "point", pointshape = 21,
#'  pointsize = 2,
#'  fill.ind = envsess01$dfmbio_ctr$HOSPITALIZACION,
#'  col.ind = "black",
#'  palette = "jco",
#'  addEllipses = TRUE,
#'  label = "var",
#'  col.var = "black",
#'  repel = TRUE,
#'  legend.title = "HOSPITALIZACION") +
#'  ggplot2::ggtitle("Gráfico PCA 2D") +
#'  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
#' ```

#'

#' ***

#'

#' Modelo k-means:  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Mejoras:  
#'     \hspace{1cm} \(\circ\) distancia euclideana \(\Longrightarrow\) distancia gower  
#'     \hspace{1cm} \(\circ\) K-means \(\Longrightarrow\) K-prototypes  
#'     \hspace{1cm} \(\circ\) Se ejecutaron 450 corridas usando 50 semillas diferentes  
#' generadas con distribución uniforme y para valores de k = {2,...,10}  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Coeficiente silhouette se mantuvo  
#'   \hspace{.5cm} \(\bullet\) Se ejecutarán 50 corridas adicionales en cuanto a variables
#' significativas  
#'   \hspace{.5cm} \(\bullet\) Todas las variables numéricas están centradas  
#'   \hspace{.5cm} \(\bullet\) Usaremos matriz de confusión y algunas métricas en todos los modelos  

#'

#' \begin{columns}
#' \begin{column}{.25\textwidth}
#' `r I(print( xtable::xtable( env_aux$cmat ), add.to.row = env_aux$cmat_addtorow , include.colnames = FALSE ))`
#' \end{column}
#' \begin{column}{.25\textwidth}
#' `r I(print( xtable::xtable( env_aux$cmat[2:1,2:1] ), add.to.row = env_aux$cmat_invtorow , include.colnames = FALSE ))`
#' \end{column}
#' \begin{column}{.50\textwidth}
#' \begin{align*}
#' Acc  &= \frac{( TP + TN )}{( TP + FN + FP + TN )}\\
#' Sens &= ( TP      ) / ( TP + FN           )\\
#' Spec &= ( TN      ) / ( TN + FP           )\\
#' \end{align*}
#' \end{column}
#' \end{columns}

#'

#' ***

#'

#' \begin{columns}
#' \begin{column}{.45\textwidth}
#' \(\bullet\) Se exhibe un patrón donde Sens es bajo mientras que el de Spec y Acc son altos\\
#' \vspace{.2cm}
#' \(\bullet\) Se exhibe un patrón donde Sens es mediano mientras que el de Spec y Acc son también
#' medianos\\
#' \vspace{.2cm}
#' \(\bullet\) Se exhibe un patrón donde Sens es alto mientras que el de Spec y Acc son bajos\\
#' \end{column}
#' \begin{column}{.55\textwidth}
#' ```{r chunk0006 , echo = F }
#' knitr::kable(
#' sqldf::sqldf( "select *
#'                from dfmbio_ctr_nnzv_kpt_precision_450_dfm
#'                group by Acc,Sens,Spec
#'                order by k asc, Acc desc, Sens desc
#'                limit 9
#'                " , envir = envsess01 ) ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,0,4,4,4) , format = "latex" , booktabs = FALSE )
#' ```
#' \vspace{.3cm}
#' ```{r chunk0007 , echo = F }
#' knitr::kable(
#' sqldf::sqldf( "select *
#'                from dfmbio_ctr_nnzv_kpt_precision_450_dfm
#'                group by Acc,Sens,Spec
#'                order by k asc, Sens desc, Acc desc
#'                limit 6
#'                " , envir = envsess01 ) ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,0,4,4,4) , format = "latex" , booktabs = FALSE )
#' ```
#' \end{column}
#' \end{columns}

#'

#' ***

#'

#' ```{r chunk0008 , echo = F }
#' ### graficar 3 kproto seleccionados
#' ### - comparar con variable de respuesta
#' plot( envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(envsess01$dfmbio_ctr$HOSPITALIZACION) )
#' legend('topright', legend = levels(as.factor(envsess01$dfmbio_ctr$HOSPITALIZACION) ), col = 1:2, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' ```{r chunk0009 , echo = F }
#' plot( envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
#' legend('topright', ncol = 3L, title = NULL , legend = c('', 'NO', 'SI', 'NO', envsess01$table_seed0045_kpt0001_comb[,1], 'SI', envsess01$table_seed0045_kpt0001_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
#' legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' ```{r chunk0010 , echo = F }
#' ### graficar PCA bien calculado combinar con k-means
#' ### - comparar con variable respuesta
#' plot( envsess01$dfmbio_num_ctr_eigen_pca[,1] , envsess01$dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(envsess01$dfmbio_ctr$HOSPITALIZACION) )
#' legend( 'topright' , legend = levels(as.factor(envsess01$dfmbio_ctr$HOSPITALIZACION)), col = 1:2, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' ```{r chunk0011 , echo = F }
#' plot( envsess01$dfmbio_num_ctr_eigen_pca[,1] , envsess01$dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb) )
#' legend('topright', ncol = 3L, title = NULL , legend = c('', 'NO', 'SI', 'NO', envsess01$table_seed0045_kpt0001_comb[,1], 'SI', envsess01$table_seed0045_kpt0001_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
#' legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001_class_comb$comb)), col = 1:4, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' Modelo glm:  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Mejoras:  
#'     \hspace{1cm} \(\circ\) Se separaron las variables en tres grupos en términos de modelamiento  
#'     \hspace{1cm} \(\circ\) Se definieron hasta ahora
#' `r I(envsess01$strnumfrm)`
#' fórmulas (objetos) diferentes incluyendo interacciones de tipo numéricas y factor  
#'     \hspace{1cm} \(\circ\) Se eliminó el intercepto en todas las fórmulas debido a que las variables numéricas
#' están centradas  
#'     \hspace{1cm} \(\circ\) Creamos una variable auxiliar llamada ponderador que nos permite
#' plantear un modelo ponderado para cada fórmula (total
#' `r I(envsess01$strnumfrm*2)` modelos)  
#' \vspace{.75mm}
#' \hspace{.5cm} \texttt{dfmpnd\$ponderador [ dfmbio\$HOSPITALIZACION == "SI" ] <- }  
#' \hspace{.5cm} \texttt{( 1 - proporcion ) =} `r I(round(1 - envsess01$proporcion,4))`  
#' \hspace{.5cm} \texttt{dfmpnd\$ponderador [ dfmbio\$HOSPITALIZACION == "NO" ] <- }  
#' \hspace{.5cm} \texttt{(     proporcion ) =} `r I(round(    envsess01$proporcion,4))`  
#' \vspace{.75mm}
#'     \hspace{1cm} \(\circ\) Hay otras opciones que deben ser mejoradas configurando los modelos, relacionado
#' con, punto de corte, parámetros de ajuste, remuestreo (sub y sobre) y validación cruzada.  

#'

#' ***

#'

#' ```{r chunk0012 , echo = F }
#' knitr::kable(
#' sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
#'                from dfmacc_glm_merge_dfm
#'                where NCof-NSig = 0
#'                and Sens   <  1
#'                group by Acc,Sens,Spec
#'                order by Sens desc, Acc desc
#'                limit 5
#'                " , envir = env_dfmacc_glm_optimo_dfm )
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,2,2,2,2,2,2,0,0) )
#' ```

#'

#' ```{r chunk0013 , echo = F }
#' knitr::kable(
#'  sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
#'                 from dfmacc_glm_merge_dfm
#'                 where NCof-NSig > 0
#'                 and Sens   <  1
#'                 group by Acc,Sens,Spec
#'                 order by Sens desc, Acc desc
#'                 limit 5
#'                 " , envir = env_dfmacc_glm_optimo_dfm )
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,2,2,2,2,2,2,0,0) )
#' ```

#'

#' ***

#'

#' ```{r chunk0014 , echo = F }
#' knitr::kable(
#' sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
#'                from dfmacc_glm_merge_dfm
#'                where NCof-NSig = 0
#'                and Sens   <  1
#'                group by Acc,Sens,Spec
#'                order by Acc desc, Sens desc
#'                limit 5
#'                " , envir = env_dfmacc_glm_optimo_dfm )
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,2,2,2,2,2,2,0,0) )
#' ```

#'

#' ```{r chunk0015 , echo = F }
#' knitr::kable(
#' sqldf::sqldf( "select Modelo, Dev, Acc, Sens, Spec, acc_y as ac_y, sens_y as se_y, spec_y as sp_y, NCof as NC, NSig as NS
#'                from dfmacc_glm_merge_dfm
#'                where NCof-NSig > 0
#'                and Sens   <  1
#'                group by Acc,Sens,Spec
#'                order by Acc desc, Sens desc
#'                limit 5
#'                " , envir = env_dfmacc_glm_optimo_dfm )
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,2,2,2,2,2,2,2,0,0) )
#' ```

#'

#' ***

#'

#' ```{r chunk0016 , echo = F }
#' knitr::kable(
#' env_tabagg_glm_metricas$tabagg_glm_metricas_accu
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,4,4,4,4) )
#' ```

#'

#' ```{r chunk0017 , echo = F }
#' knitr::kable(
#' env_tabagg_glm_metricas$tabagg_glm_metricas_sens
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,4,4,4,4) )
#' ```

#'

#' ```{r chunk0018 , echo = F }
#' knitr::kable(
#' env_tabagg_glm_metricas$tabagg_glm_metricas_spec
#' ,
#' format.args = list(decimal.mark = ',', big.mark = ".") ,
#' digits = c(0,4,4,4,4) )
#' ```

#'

#' ***

#'

#' ```{r chunk0019 , echo = F }
#' ### grafico triple
#' par(mfrow=c(3,1))
#'
#' ### modelo con ponderacion estima con mayor exactitud la Acc
#' plot(    density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Acc [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) , main="" )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Acc [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Acc [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=envsess01$col02 , xlim=c(0,1) )
#' legend('topleft', legend = levels( as.factor( substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(envsess01$col02,envsess01$col01) , cex=.8 , pch=1 )
#' title( main = "Acc" )
#'
#' ### modelo con ponderacion estima con mayor exactitud la Sens
#' plot(    density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Sens [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) , main="" )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Sens [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Sens [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=envsess01$col02 , xlim=c(0,1) )
#' legend('topleft', legend = levels( as.factor( substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(envsess01$col02,envsess01$col01) , cex=.8 , pch=1 )
#' title( main = "Sens" )
#'
#' ### modelo sin ponderacion tiende a sobre estimar la Spec
#' plot(    density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Spec [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) , main="" )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Spec [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "w" ] ) , col=envsess01$col01 , xlim=c(0,1) )
#' polygon( density( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Spec [ substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) == "m" ] ) , col=envsess01$col02 , xlim=c(0,1) )
#' legend('topleft', legend = levels( as.factor( substr( env_dfmacc_glm_metricas_dfm_sort$dfmacc_glm_metricas_dfm_sort$Modelo , 9 , 9 ) ) ) , col=c(envsess01$col02,envsess01$col01) , cex=.8 , pch=1 )
#' title( main = "Spec" )
#'
#' ```

#'

#' ***

#'

#' ```{r chunk0020 , echo = F }
#' ### comparar glm predict versus confmat comb usando K-means
#' plot( envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,1] , envsess01$dfmbio_ctr_nnzv_seed0045_kpt0001$dists[,2] , col=as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb) )
#' legend( 'topright' , ncol = 3L , title = NULL , legend = c('', 'NO', 'SI', 'NO', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,1], 'SI', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
#' legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb)  ), col = 1:4, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' ```{r chunk0021 , echo = F }
#' ### comparar glm predict versus confmat comb usando PCA
#' plot( envsess01$dfmbio_num_ctr_eigen_pca[,1] , envsess01$dfmbio_num_ctr_eigen_pca[,2] , col=as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb) )
#' legend( 'topright' , ncol = 3L , title = NULL , legend = c('', 'NO', 'SI', 'NO', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,1], 'SI', env_modglmfrw2584_comb$table_modglmfrw2584_comb[,2]) , text.col=c(rep(1,4),3,2,1,1,4) )
#' legend( 'topright' , inset=c(0,.155) , legend = levels(as.factor(env_modglmfrw2584_comb$modglmfrw2584_comb$comb)), col = 1:4, cex = 0.8, pch = 1)
#' ```

#'

#' ***

#'

#' Modelo logístico penalizado:  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Mejoras:  
#'     \hspace{1cm} \(\circ\) Se obtuvieron predicciones y métricas para 70 modelos  
#'     \hspace{1cm} \(\circ\) El modelo puede ser ridge (\(\alpha\) = 0), lasso (\(\alpha\) = 1) o  
#' elasticnet (0 <= \(\alpha\) <= 1)  
#'     \hspace{1cm} \(\circ\) Se usó el valor \(\lambda\) mínimo para generar el vector  
#'                    de predicciones y controlar el grado de penalización  
#' \vspace{.75mm}
#'   \hspace{.5cm} \(\bullet\) Por hacer:  
#'     \hspace{1cm} \(\circ\) Configurar valores de corte óptimo de probabilidad donde
#' se maximice la sensitividad y la especificidad en conjunto, así como valores de
#' \(\alpha\) y \(\lambda\)  

#'

#' ***

#'

#' ```{r chunk0022 , echo = F }
#' knitr::kable( head( envsess01$dfmacc_gnt_metricas_dfm , 15 ) )
#' ```

#'

#' ***

#'

#' ```{r chunk0023 , echo = F }
#' env_modglmcvw2584$modglmcvw2584_train_plot
#' ```

#'

#'# {.fragile}

#'

#' \fontsize{10}{7.2}\selectfont
#' Algunas sugerencias para mantener bajo el nivel de RAM:  
#' \vspace{.25mm}
#'   \hspace{.5cm} \(\bullet\) Grabar [parte de] la sesión como bases rdb/rdx indexadas  
#'   \begin{verbatim}
#'      entorno_01 <- new.env()  
#'      assign( "modelo_01" , modelo_01 , envir = entorno_01 )  
#'      assign( "formula_01" , formula_01 , envir = entorno_01 )  
#'      assign( "objeto_01" , objeto_01 , envir = entorno_01 )  
#'      tools:::makeLazyLoadDB( entorno_01 , "rdb/entorno_01" )  
#'   \end{verbatim}
#' \vspace{-.50cm}
#' \vspace{.25mm}
#'   \hspace{.5cm} \(\bullet\) Se pueden cargar a su propio entorno  
#'   \begin{verbatim}
#'      entorno_01 <- new.env()  
#'      base::lazyLoad( "rdb/entorno_01" , envir = entorno_01 )  
#'      assign( "modelo_01" , entorno_01$modelo_01 , envir = .GlobalEnv )  
#'   \end{verbatim}
#' \vspace{-.50cm}
#' \vspace{.25mm}
#'   \hspace{.5cm} \(\bullet\) Se pueden cargar al entorno global  
#'   \begin{verbatim}
#'      entorno_01 <- new.env()  
#'      base::lazyLoad( "rdb/entorno_01" , envir = .GlobalEnv )  
#'   \end{verbatim}
#' \vspace{-.50cm}
#' \vspace{.25mm}
#'   \hspace{.5cm} \(\bullet\) Existe la función externa R_lazyLoadDBinsertValue  
#'   \begin{verbatim}
#'      R CMD SHLIB serialize.c  
#'      dyn.load( "serialize.so" )  
#'      .Call( "R_lazyLoadDBinsertValue" , "rdb/entorno_01" , objeto_02 )  
#'   \end{verbatim}

#'

#'# {.fragile}

#'

#' \begin{verbatim}
#' Nuevo codigo
#' \end{verbatim}

#'

#'

