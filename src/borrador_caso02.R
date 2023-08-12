#' ---
#' title:  |
#'         | Pontificia Universidad Católica de Valparaíso
#'         | Instituto de Estadística - Magíster en Estadística
#'         | EST741 - Taller de consultoría - Ciclo 02 2019
#'         | Caso de aplicación 2.
#'         | Identificación de factores de riesgo en
#'         | pacientes de diabetes post pabellón.
#' author: |
#'         | Matías F. Rebolledo G.
#' date: Martes,  8 de Octubre de 2019
#' output:
#'   pdf_document:
#'     highlight: tango
#'     number_sections: true
#'     includes:
#'       in_header: tex/header.tex
#'       before_body: tex/before_body.tex
#' bibliography: citaciones_caso02.bib
#' link-citations: yes
#' geometry: margin=.75in
#' ---

#'

#' \clearpage


#'


#'# Definición del caso.

#'

#' El presente informe busca indentificar los factores de riesgo asociados a
#' pacientes diagnosticados de diabetes en un centro médico determinado.  Se ha
#' definido como \textbf{caso} a aquel paciente que después de 30 días de
#' realizarle una biopsia ha presentado algún tipo de síntoma que haya
#' requerido hospitalización. Mientras que se definió como \textbf{control}
#' a aquel paciente que no presentó ninguna de complicación en un periodo
#' posterior a 30 días que haya requerido hospitalización.

#'

#' La metodología consiste en identificar los factores de riesgo por medio de
#' la construcción de un modelo de clasificación. Gracias a este modelo
#' podremos someter un paciente ficticio con características predefinidas y
#' poder medir cuales son los factores de riesgo asociados al vector de
#' características de ese paciente o de un conjunto de prueba que desee
#' incorporarse en cuestión.

#'

#' La muestra ha sido obtenida mediante la creación de un cuestionario que fue
#' respondido por cada paciente y cuyas preguntas están asociadas a procedimientos que
#' fueron aplicados según la sintomatología de cada paciente.  El tamaño
#' de la muestra es de `r I(dim(dfmbio)[1])` observaciones y un número de
#' `r I(dim(dfmbio)[2])` variables.  El número de pacientes que corresponden a
#' casos es de `r I(dim(dfmbio [ dfmbio$HOSPITALIZACION == "SI" , ])[1])`,
#' mientras que el que corresponde a control es de `r I(dim(dfmbio [
#' dfmbio$HOSPITALIZACION == "NO" , ])[1])`.

#'

#' Años del estudio (toma de observaciones)
#' - 2012, 2013

#'

#' \clearpage

#'

#'# Análisis y propuesta de solución.

#'

#' En esta sección plantearemos posible soluciones en virtud del análisis que
#' realizaremos abordando tanto principios estadísticos como aprovechando la
#' misma estructura de la muestra del estudio. Por un lado, realizaremos todo
#' análisis posible en temas descriptivos y por otro, evaluaremos varias
#' opciones para construir modelos y las formas de abordar la validez de los
#' mismos.

#'

#' Una de las características está dado por el pequeño tamaño muestral. A eso
#' se suma que la categoría de interés que corresponde a un paciente tipo caso,
#' equivale a solamente un `r I(round(12/284*100,2))`%, mientras que aquellos
#' que son control corresponden a un `r I(round((284-12)/284*100,2))`%.

#'

#'## Análisis exploratorio.

#'

#'### Combinaciones lineales con la variable dependiente.

#'

#' Como paso inicial a nuestro análisis descriptivo evidenciamos que existen
#' variables que son combinación lineal casi perfecta con la variable de
#' respuesta del estudio. Inicialmente esto está planteado en el mismo
#' enunciado, al definir como \textbf{caso} a aquellos pacientes que sufrieron
#' fiebre e infección urinaria en los primeros 30 días después del
#' procedimiento de la biopsia. Este es el primer indicio lo que vamos a
#' sustentar realizando algunas tabulaciones y visualizaciones para tener una
#' evidencia más sólida.

#'

#' ```{r chunk0001 , echo = F }
#' knitr::kable( head( dfmbio_num_cor                              , 20 ) ,
#' format.args = list( decimal.mark = ',' , big.mark = '.' ) , digits = 4 ,
#' caption = "\\label{tab:tab001}Matriz de correlaciones aplanada y ordenada decreciente" )
#' ```

#'

#' El cuadro \ref{tab:tab001} muestra las primeras 20 correlaciones
#' correspondientes a la matriz de correlacion en formato aplanado y ordenadas
#' en forma decreciente por el coeficiente de correlación de Pearson. Los
#' valores de probabilidad para el coeficiente de Pearson resultaron ser
#' demasiado pequeños y muy significativos, por lo que resultaron ser cero. El
#' tamaño de la matriz de correlaciones es de $P(P-1)/2$ y equivale a
#' `r I(dim(dfmbio)[2]*(dim(dfmbio)[2]-1)/2)`. Las restantes 190 filas poseen un
#' coeficiente de Pearson inferior a $0.5$ y el coeficiente más negativo es de
#' `r I(round(tail(dfmbio_num_cor,1)[1,3],2))`, lo que no indica una fuerte
#' correlación negativa en la muestra. Por su parte, la correlación positiva
#' más elevada es de `r I(round(head(dfmbio_num_cor,1)[1,3],2))` y corresponde
#' a que la variable FIEBRE está es casi una combinación lineal de la variable
#' dependiente HOSPITALIZACION. Veremos la frecuencia conjunta en la siguiente
#' tabulación cruzada.

#'

#' ```{r chunk0002 , echo = T }
#' with( dfmbio , table( HOSPITALIZACION , FIEBRE ) )
#' ```

#'

#' Lo representado en la tabulación anterior implica que hubo solo un paciente
#' que sí tuvo fiebre pero no fue identificado como caso. A pesar de esto,
#' esta variable tiene una implicancia negativa en la construcción de un modelo
#' por lo que optaremos por excluirla de nuestro análisis. Volveremos a inspeccionar
#' la matriz aplanada de correlaciones para observar otras variables que estén
#' correlacionadas con la variable HOSPITALIZACION y evaluar su pertinencia.

#'

#' ```{r chunk0003 , echo = T }
#' head( dfmbio_num_cor [ dfmbio_num_cor$cor_x == "HOSPITALIZACION" , ] ,  6 )
#' ```

#'

#' Se observa que la segunda variable con la mayor correlación positiva es
#' DIAS.HOSP.MQ.  Observaremos la tabulación cruzada de frecuencia
#' con la variable dependiente.

#'

#' ```{r chunk0004 , echo = T }
#' with( dfmbio , table( HOSPITALIZACION , DIAS.HOSP.MQ ) )
#' ```

#'

#' Esta tabulación tiene dos problema visibles. Por un lado, la variable
#' DIAS.HOSP.MQ tiene alta correlación con HOSPITALIZACION, mientras
#' que por otro, si se categoriza esta variable para todos número de días mayor
#' que cero y se vuelve a hacer esta tabla de contingencia tendríamos
#' colinealidad perfecta con la variable dependiente. Por lo tanto, esta
#' variable tampoco muestra utilidad y optamos por excluirla de nuestros
#' análisis. Para ejemplificar lo antes señalado volvemos a mostrar la
#' tabulación cruzada esta vez con una variable recodificada nueva
#' DIAS.HOSP.MQ.DUM versus HOSPITALIZACION.

#'

#' ```{r chunk0005 , echo = T }
#' dfmbio_num_dum <- dfmbio_num [ , c(21,19,13) ]
#' #str(dfmbio_num_dum)
#' dfmbio_num_dum$DIAS.HOSP.MQ.DUM <- 0
#' dfmbio_num_dum$DIAS.HOSP.MQ.DUM [ dfmbio_num_dum$DIAS.HOSP.MQ > 0 ] <- 1
#' with( dfmbio_num_dum , table( HOSPITALIZACION , DIAS.HOSP.MQ.DUM ) )
#' ```

#'

#' De donde observamos una colinealidad perfecta entre ambas variables. Repetiremos
#' la misma inspección con la variable NUM.DIAS.POST.BIOP para evaluar
#' si a priori sería conveniente continuar con esta variable dentro de nuestra
#' base de datos.

#'

#' ```{r chunk0006 , echo = T }
#' with( dfmbio_num , table( HOSPITALIZACION , NUM.DIAS.POST.BIOP ) )
#' ```

#'

#' Observamos un problema similar al de las últimas dos variables analizadas.
#' En primera instancia ambas muestran una correlación de Pearson de
#' `r I(round(dfmbio_num_cor [ dfmbio_num_cor$cor_x == "HOSPITALIZACION" , 3 ][3],2))`
#' y en caso de recodificar esta variable obtendría colinealidad casi perfecta
#' como veremos a continuación.

#'

#' ```{r chunk0007 , echo = T }
#' dfmbio_num_dum$NUM.DIAS.POST.BIOP.DUM <- 0
#' dfmbio_num_dum$NUM.DIAS.POST.BIOP.DUM [ dfmbio_num_dum$NUM.DIAS.POST.BIOP > 0 ] <- 1
#' with( dfmbio_num_dum , table( HOSPITALIZACION , NUM.DIAS.POST.BIOP.DUM ) )
#' ```

#'

#' En síntesis, optaremos por dejar fuera de análisis a las últimas tres variables
#' FIEBRE, DIAS.HOSP.MQ y NUM.DIAS.POST.BIOP por tener una colinealidad
#' muy elevada con la variable dependiente lo que empobrece los principios del modelo
#' que se quiere construir.

#'

#'### Combinaciones lineales entre variables independientes.

#'

#' De forma similar nos compete realizar la misma verificación esta vez
#' entre variables independientes de la muestra con la finalidad de
#' identificar posibles combinaciones lineales entre ellas. A continuación
#' mostramos la tabulación cruzada para las variables con correlación de
#' Pearson positiva más elevada de la matriz de correlación que fue
#' previamente aplanada.

#'

#' ```{r chunk0008 , echo = T }
#' head( dfmbio_num_cor [ dfmbio_num_cor$cor_x != "HOSPITALIZACION" , ] , 14 )
#' ```

#'

#' Se trata de un fragmento del cuadro \ref{tab:tab001} que presenta los
#' pares de variables con la correlación de Pearson más elevada. En este
#' caso corresponde a las primeras 16 combinaciones de variables que
#' no incluyen a la variable dependiente para analizar la colinealidad
#' solamente entre covariables. La correlación positiva más alta
#' es entre PATR.RESIST y TIPO.CULTIVO que es de
#' `r I(round(dfmbio_num_cor [ dfmbio_num_cor != "HOSPITALIZACION" , 3 ][1],2))`.
#' Veremos a continuación una tabla de contigencia de la frecuencia entre ambas variables.

#'

#' ```{r chunk0009 , echo = T }
#' with( dfmbio , table( abbreviate(PATR.RESIST) ,
#' abbreviate(TIPO.CULTIVO) )[c(3,1,4,5,2),c(3,1,4,2)] )
#' ```

#'

#' Se puede observar que la distribución conjunta es muy similar a aquellas en que
#' hubo colinealidad con la variable dependiente.
#' La mayor parde de las observaciones
#' se concentran en aquellas que no presentan patrón de resistencia, puesto que la
#' mayoría de pacientes no presentó a su vez infecciones urinarias, ni fiebre, o bien,
#' tuvieron resultado negativo en la biopsia, por lo que no se puede medir en ellos
#' si después de aplicar un tratamiento con antibióticos, se puede decir que haya
#' habido una resistencia de parte de los parásitos al tratamiento prescrito según
#' la profilaxis de cada paciente.
#' A continuación analizaremos la frecuencia conjunta entre las covariables
#' PATR.RESIST y AGENTE.AISLADO, cuyo coeficiente de correlación de
#' Pearson es de
#' `r I(round(dfmbio_num_cor [ dfmbio_num_cor != "HOSPITALIZACION" , 3 ][3],2))`.

#'

#' ```{r chunk0010 , echo = T }
#' with( dfmbio , table( abbreviate(PATR.RESIST) ,
#' abbreviate(AGENTE.AISLADO) )[c(3,1,4,5,2),c(2,1,3)] )
#' ```

#'

#'### Identificación de variables con varianza cero o casi cero.

#'

#' Esta sección nos ayudará a sintetizar las últimos dos análisis, puesto que
#' podemos clasificar todas las variables independientes según si su varianza
#' es casi cero o no. Esto ha sido señalado en la siguiente fuente ^[[Near-zero
#' variance predictors. Should we remove
#' them?](https://tgmstat.wordpress.com/2014/03/06/near-zero-variance-predictors/)]
#' y por los autores [@wing_caret:_2019] y [@zorn_solution_2005], quienes
#' señalan que, por un lado, se puede optar por excluir toda variable que
#' estropee las propiedades del modelo o bien que al ser colineales impidan
#' ejecutar la inversión de la matriz de información, pero por otro, tomando en
#' cuenta que a veces hay variables que por razones de ámbito deben permanecer
#' en el modelo aunque no tengan las mejores propiedades o no aporten mucha
#' información, vale la pena abordar en forma definitiva este último enfoque
#' para poder concluir con decisiones sobre las variables que resultan ser
#' combinaciones lineales entre ellas o con la variable objetivo del estudio.
#' Con estas últimas tres secciones y con apoyo un modelo logístico inicial
#' aplicaremos unas pruebas de significancia parcial entre posibles variables
#' a excluir y mediremos las desvianzas de cada modelo posible para ver cual
#' es mejor al momento de incluir o no una variable con poca capacidad explicativa.

#'

#' En el siguiente código observamos las variables que presentan una varianza
#' casi cero, lo que está propuesto mediante la función \texttt{caret::nearZeroVar}
#' del autor [@wing_caret:_2019].

#'

#' ```{r chunk0011 , echo = T }
#' dfmbio_fac_nzv <- caret::nearZeroVar( dfmbio_fac , saveMetrics=T )
#' dfmbio_fac_nzv [ dfmbio_fac_nzv$nzv > 0 , ]
#' ```

#' Se puede observar en este listado las variables que contienen varianza
#' casi cero, lo que se corresponde con varias de las tabulaciones que se
#' ha revisado hasta ahora, tales como, FIEBRE, DIAS.HOSP.MQ,
#' NUM.DIAS.POST.BIOP, que son combinación lineal casi perfecta con la
#' variable dependiente y otras que tienen la misma propiedad entre
#' variables independientes.

#'

#' En la etapa de modelación realizaremos un tanteo incluyendo y
#' excluyendo alguna de las variables que tienen varianza casi cero
#' para decidir finalmente si tienen, por un lado, un efecto negativo,
#' o bien, son útiles en la identificación de los factores de riesgo.

#'

#'## Métodos de clasificación pertinentes.

#'

#' Dentro de la gran variedad de métodos que existen queremos abordar
#' los problemas relevantes para nuestra muestra de datos. Hemos visto
#' necesitaremos abordar el fenómeno de la inflación de varianza para
#' evitar que la estimación de errores estándar de los estimadores sea
#' elevada y por ende le quite estabilidad a los estimadores. Además
#' queremos abordar una estrategia para el efecto que conlleva el
#' falta de balanceo entre las categorías de pacientes. Por último,
#' dedicaremos una sección para abordar una solución para validar
#' cada uno de los modelos que estimemos considerando que tenemos
#' una muestra pequeña y no tenemos una muestra de prueba. En este
#' sentido usaremos alguna estrategia adicional en la que podamos
#' prescindir de una muestra de prueba, tal como, validación cruzada.
#' Veremos como hacer sinergia entre el uso de validación cruzada,
#' sub muestreo y sobre muestreo para lo que usaremos en toda la
#' construcción de modelos el paquete \textbf{caret}.

#'

#'### Modelo logístico.

#'

#' En esta sección analizaremos un modelo de clasficación logística inicial en
#' el que visualizaremos, por un lado, el efecto de las combinaciones lineales
#' previamente identificadas y, por otro, el efecto dado por el desbalance
#' entre los casos y los controles en la muestra de pacientes.
#' En este caso observaremos los factores de inflación de varianza, las
#' desvianzas y usaremos los paquetes \textbf{caret} y \textbf{glm}.
#' Probaremos con una variante inicial en la que construiremos un ponderador
#' que represente las proporciones desbalanceadas entre casos y controles
#' e incorporaremos esta ponderación en alguno de los modelos logísticos
#' para comparar sus desvianzas con los que no consideren este ponderador.

#'

#' En relación con la inflación de varianza tenemos que en las primeras
#' estimaciones que realizamos, R nos alerta del siguiente mensaje:
#' \texttt{Warning message:
#' glm.fit: fitted probabilities numerically 0 or 1 occurred}. Esto
#' quiere decir que a pesar de que el modelo logístico puede invertir
#' la matriz de diseño, todavía existen regresores que separan perfectamente
#' la variable dependiente y que los estimadores de los parámetros siguen
#' inflados. Según la opinión de analistas
#' ^[[How to deal with perfect separation in logistic regression?](
#' https://stats.stackexchange.com/questions/11109/how-to-deal-with-perfect-separation-in-logistic-regression/68917)],
#' una de las opciones más recomendadas es, por un lado, un modelo logístico
#' penalizado y, por el otro, un modelo logístico bayesiano. Los autores
#' son [@zorn_solution_2005] y [@gelman_weakly_2008] para cada modelo propuesto, respectivamente.

#'

#'### Clasificación binaria penalizada.

#'

#' En esta sección buscamos incorporar el efecto de la inflación de varianza
#' dada por las variables que poseen varianza cercana a cero, puesto que hemos
#' optado por decidir sobre la inclusión final de las que presenten menos
#' deterioro, lo que haremos usando una clasificación binaria penalizada usando
#' los paquetes \textbf{caret} y \textbf{glmnet}. Este último paquete también
#' es sensible a la inversión de la matriz de confusión por lo que toda
#' exclusión previamente hecha cuenta para esta sección de manera de evaluar un
#' último conjunto de variable que puedan prestar alguna capacidad de
#' indentificación de los factores de riesgo más importantes para el estudio.

#'

#'### Bosque aleatorio.

#'

#' Según el autor [@wing_caret:_2019] el problema de covariables con varianza
#' cero o casi cero, puede bloquear la ejecución de varios modelos o que sus
#' estimadores sean inestables, excepto aquellos basados en árboles de
#' clasificación.

#'

#'## Métodos para validar el modelo de clasificación.

#'

#'### Usando muestra de entrenamiento y de prueba.

#'

#'### Usando validación cruzada.

#'

#'### Usando técnicas para muestras no balanceadas.

#'

#' Según el autor [@wing_caret:_2019] y también señalado en esta
#' ^[[Illustrative Example 5: Optimizing probability thresholds for class
#' imbalances](
#' https://topepo.github.io/caret/using-your-own-model-in-train.html)] fuente,
#' un modelo con muestra imbalanceada tenderá siempre a predecir con mayor sesgo
#' la clase más frecuente y, por lo tanto, tenderá a estimar un alto valor para
#' la sensitividad y uno muy bajo para la especificidad.

#'

#' \clearpage

#'

#'# Experimentación.

#'

#' \clearpage

#'

#'# Conclusiones.

#'

#' \clearpage

#'

#'# Glosario. {-}

#'

#' - PSA: Antígeno prostático específico.
#' - PROFILAXIS: Es el tratamiento preventivo de la enfermedad.
#' - ITU: Infección en el tracto urinario o sepsis.
#' - NEG: Negativo (BIOPSIA, resultado negativo).
#' - PROSTATITIS: Inflamación de la próstata.
#' - ASMA: Enfermedad respiratoria que ocurre como respuesta
#'         del sistema inmune a una reacción anómala.
#' - EPOC: Enfermedad respiratoria obstructiva crónica
#'         causada por agentes tóxicos o irritantes
#'         como el tabaco.
#' - CUP: Cateter urinario por paciente, implemento
#'        requerido como vía de evauación de orina
#'        en forma externa para pacientes con dificultad
#'        en orinar.

#'

#' \clearpage

#'

#'# Anexos. {-}

#'

#' \clearpage

#'

#'# Referencias. {-}
