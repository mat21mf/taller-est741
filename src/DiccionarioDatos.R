### quitar non unicode de nombres de variables no soporta autocompletado
nombres_sin_acento     <- c(
"ANO.DEL.PROCEDIMIENTO",
"EDAD",
"DIABETES",
"HOSPITALIZACION.ULTIMO.MES",
"PSA",
"BIOPSIAS.PREVIAS",
"VOLUMEN.PROSTATICO",
"ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS",
"NUMERO.DE.MUESTRAS.TOMADAS",
"CUP",
"ENF..CRONICA.PULMONAR.OBSTRUCTIVA",
"BIOPSIA",
"NUMERO.DE.DIAS.POST.BIOPSIA.EN.QUE.SE.PRESENTA.LA.COMPLICACION.INFECCIOSA",
"FIEBRE",
"ITU",
"TIPO.DE.CULTIVO",
"AGENTE.AISLADO",
"PATRON.DE.RESISTENCIA",
"DIAS.HOSPITALIZACION.MQ",
"DIAS.HOSPITALIZACION.UPC",
"HOSPITALIZACION"
)

### quitar non unicode de nombres de variables no soporta autocompletado
nombres_sin_acento_corto <- c(
"ANO.DEL.PROCEDIMIENTO",
"EDAD",
"DIABETES",
"HOSPITALIZACION.ULTIMO.MES",
"PSA",
"BIOPSIAS.PREVIAS",
"VOLUMEN.PROSTATICO",
"ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS",
"NUMERO.DE.MUESTRAS.TOMADAS",
"CUP",
"ENF..CRONICA.PULMONAR.OBSTRUCTIVA",
"BIOPSIA",
"NUMERO.DE.DIAS.POST.BIOPSIA",
"FIEBRE",
"ITU",
"TIPO.DE.CULTIVO",
"AGENTE.AISLADO",
"PATRON.DE.RESISTENCIA",
"DIAS.HOSPITALIZACION.MQ",
"DIAS.HOSPITALIZACION.UPC",
"HOSPITALIZACION"
)

### quitar non unicode de nombres de variables no soporta autocompletado
nombres_abreviados <- c(
"ANO.PROC",
"EDAD",
"DIABETES",
"HOSP.ULT.MES",
"PSA",
"BIOP.PREV",
"VOL.PROST",
"ANTIB.PROFI",
"NUM.MUESTRAS",
"CUP",
"EPOC",
"BIOPSIA",
"NUM.DIAS.POST.BIOP",
"FIEBRE",
"ITU",
"TIPO.CULTIVO",
"AGENTE.AISLADO",
"PATR.RESIST",
"DIAS.HOSP.MQ",
"DIAS.HOSP.UPC",
"HOSPITALIZACION"
)

### diccionarios factor levels y labels
 #DiccFactor01.lev <- c(0,1) ; #DiccFactor01.lab <- c(0,1) ### ANO.DEL.PROCEDIMIENTO                                                     ### integer
 #DiccFactor02.lev <- c(0,1) ; #DiccFactor02.lab <- c(0,1) ### EDAD                                                                      ### integer
  DiccFactor03.lev <- c(0,1) ;  DiccFactor03.lab <- c("NO","SI") ### DIABETES                                                            ### factor
  DiccFactor04.lev <- c(0,1) ;  DiccFactor04.lab <- c("NO","SI") ### HOSPITALIZACION.ULTIMO.MES                                          ### factor
 #DiccFactor05.lev <- c(0,1) ; #DiccFactor05.lab <- c(0,1) ### PSA                                                                       ### numeric
  DiccFactor06.lev <- c(0,1) ;  DiccFactor06.lab <- c("NO","SI") ### BIOPSIAS.PREVIAS                                                    ### factor
  DiccFactor07.lev <- c(0,1) ;  DiccFactor07.lab <- c("NO","SI") ### VOLUMEN.PROSTATICO                                                  ### factor
  DiccFactor08.lev <- c(0:3) ;  DiccFactor08.lab <- c("FLUOROQUINOLONA + AMINOGLICOSIDO",
                                                      "CEFALOSPORINA + AMINOGLUCOCIDO",
                                                      "FLUOROQUINOLONAS",
                                                      "OTROS" )   ### ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS        ### factor
 #DiccFactor09.lev <- c(0,1) ; #DiccFactor09.lab <- c(0,1) ### NUMERO.DE.MUESTRAS.TOMADAS                                                ### integer
  DiccFactor10.lev <- c(0,1) ;  DiccFactor10.lab <- c("NO","SI") ### CUP                                                                 ### factor
  DiccFactor11.lev <- c(0:3) ;  DiccFactor11.lab <- c("NO", "SI", "SI; ASMA", "SI; EPOC" )  ### ENF..CRONICA.PULMONAR.OBSTRUCTIVA        ### factor
  DiccFactor12.lev <- c(0:8) ;  DiccFactor12.lab <- c("NEG",
                                                      "PROSTATITIS",
                                                      "HIPERPLASIA PROSTATICA",
                                                      "CARCINOMA INDIFERENCIADO DE CELULAS CLARAS",
                                                      "ADENOCARCINOMA GLEASON 6",
                                                      "ADENOCARCINOMA GLEASON 7",
                                                      "ADENOCARCINOMA GLEASON 8",
                                                      "ADENOCARCINOMA GLEASON 9",
                                                      "ADENOCARCINOMA GLEASON 10"   )   ### BIOPSIA                                                                   ### factor
  DiccFactor13.lev <- c(0:5) ;  DiccFactor13.lab <- c("NO", "1", "2", "3", "5", "9" )   ### NUMERO.DE.DIAS.POST.BIOPSIA.EN.QUE.SE.PRESENTA.LA.COMPLICACION.INFECCIOSA ### factor
  DiccFactor14.lev <- c(0,1) ;  DiccFactor14.lab <- c("NO","SI") ### FIEBRE                                                                    ### factor
  DiccFactor15.lev <- c(0,1) ;  DiccFactor15.lab <- c("NO","SI") ### ITU                                                                       ### factor
  DiccFactor16.lev <- c(0:3) ;  DiccFactor16.lab <- c("NO", "UROCULTIVO", "HEMOCULTIVO", "HEMOCULTIVO Y UROCULTIVO" )   ### TIPO.DE.CULTIVO    ### factor
  DiccFactor17.lev <- c(0:2) ;  DiccFactor17.lab <- c("NO", "E.COLI", "PSEUDOMONAS AERUGINOSA")  ### AGENTE.AISLADO                            ### factor
  DiccFactor18.lev <- c(0:4) ;  DiccFactor18.lab <- c("NO",
                                                      "RESISTENTE A AMPI; CIPRO Y GENTA",
                                                      "AMPI R; CIPRO R; GENTA R; SULFA M R",
                                                      "MULTI SENSIBLE",
                                                      "RESISTENTE A AMPI; SULFA; CEFADROXILO; CEFUROXIMO; CIPRO Y CEFEPIME; CEFOTAXIMA") ### PATRON.DE.RESISTENCIA    ### factor
 #DiccFactor19.lev <- c(0,1) ; #DiccFactor19.lab <- c(0,1) ### DIAS.HOSPITALIZACION.MQ                                                   ### integer
 #DiccFactor20.lev <- c(0,1) ; #DiccFactor20.lab <- c(0,1) ### DIAS.HOSPITALIZACION.UPC                                                  ### integer
  DiccFactor21.lev <- c(0,1) ;  DiccFactor21.lab <- c("NO","SI") ### HOSPITALIZACION                                                     ### factor

  TipoDatosNum <- c(
   "integer"
  ,"integer"
  ,"character"
  ,"character"
  ,"numeric"
  ,"character"
  ,"character"
  ,"character"
  ,"integer"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"character"
  ,"integer"
  ,"integer"
  ,"character")

  TipoDatosFac <- c(
   "integer"
  ,"integer"
  ,"factor"
  ,"factor"
  ,"numeric"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"integer"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"factor"
  ,"integer"
  ,"integer"
  ,"factor")
