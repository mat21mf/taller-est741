  ### variables entorno
  declare -gx srcdir="$HOME/PUCV/est741_2019/caso02"

  ### eliminar espacios en blanco para evitar duplicados
  sed -r -i 's/, +/,/g' ${srcdir}/csv/dfmbio.csv
  sed -r -i 's/ +,/,/g' ${srcdir}/csv/dfmbio.csv
  ### corregir algunas categorias
  sed -r -i 's/FLUROQUINOLONA \+ AMINOGLICOSIDO/FLUOROQUINOLONA \+ AMINOGLICOSIDO/' ${srcdir}/csv/dfmbio.csv
  ### revisar correccion
  gawk -F, '{print $8}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c

 #gawk -F, '{print $1}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### integer
 #gawk -F, '{print $2}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### integer
# gawk -F, '{print $3}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $4}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
 #gawk -F, '{print $5}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### numeric
# gawk -F, '{print $6}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $7}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $8}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
 #gawk -F, '{print $9}'  ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### integer
# gawk -F, '{print $10}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $11}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $12}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $13}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $14}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $15}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $16}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $17}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
# gawk -F, '{print $18}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor
 #gawk -F, '{print $19}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### integer
 #gawk -F, '{print $20}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### integer
# gawk -F, '{print $21}' ${srcdir}/csv/dfmbio.csv | sort | uniq -c ### factor

### valores unicos
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f ANO.DEL.PROCEDIMIENTO                   ### integer
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f EDAD                                    ### integer
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f DIABETES                                ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f HOSPITALIZACION.ULTIMO.MES              ### factor
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f PSA                                     ### numeric
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f BIOPSIAS.PREVIAS                        ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f VOLUMEN.PROSTATICO                      ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS ### factor
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f NUMERO.DE.MUESTRAS.TOMADAS              ### integer
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f CUP                                     ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f ENF..CRONICA.PULMONAR.OBSTRUCTIVA       ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f BIOPSIA                                 ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f NUMERO.DE.DIAS.POST.BIOPSIA             ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f FIEBRE                                  ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f ITU                                     ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f TIPO.DE.CULTIVO                         ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f AGENTE.AISLADO                          ### factor
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f PATRON.DE.RESISTENCIA                   ### factor
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f DIAS.HOSPITALIZACION.MQ                 ### integer
 #mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f DIAS.HOSPITALIZACION.UPC                ### integer
  mlr --icsv --from ${srcdir}/csv/dfmbio.csv uniq -f HOSPITALIZACION                         ### factor

# ### recodificar valores string para que valores comiencen en cero y no en uno
# DIABETES=NO
# DIABETES=SI
# HOSPITALIZACION.ULTIMO.MES=NO
# HOSPITALIZACION.ULTIMO.MES=SI
# BIOPSIAS.PREVIAS=NO
# BIOPSIAS.PREVIAS=SI
# VOLUMEN.PROSTATICO=SI
# VOLUMEN.PROSTATICO=NO
# ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS=FLUOROQUINOLONA + AMINOGLICOSIDO
# ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS=CEFALOSPORINA + AMINOGLUCOCIDO
# ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS=FLUROQUINOLONA + AMINOGLICOSIDO
# ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS=FLUOROQUINOLONAS
# ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS=OTROS
# CUP=NO
# CUP=SI
# ENF..CRONICA.PULMONAR.OBSTRUCTIVA=NO
# ENF..CRONICA.PULMONAR.OBSTRUCTIVA=SI
# ENF..CRONICA.PULMONAR.OBSTRUCTIVA=SI; ASMA
# ENF..CRONICA.PULMONAR.OBSTRUCTIVA=SI; EPOC
# BIOPSIA=NEG
# BIOPSIA=ADENOCARCINOMA GLEASON 7
# BIOPSIA=ADENOCARCINOMA GLEASON 6
# BIOPSIA=ADENOCARCINOMA GLEASON 9
# BIOPSIA=PROSTATITIS
# BIOPSIA=HIPERPLASIA PROSTATICA
# BIOPSIA=ADENOCARCINOMA GLEASON 8
# BIOPSIA=ADENOCARCINOMA GLEASON 10
# BIOPSIA=CARCINOMA INDIFERENCIADO DE CELULAS CLARAS
# NUMERO.DE.DIAS.POST.BIOPSIA=1
# NUMERO.DE.DIAS.POST.BIOPSIA=2
# NUMERO.DE.DIAS.POST.BIOPSIA=3
# NUMERO.DE.DIAS.POST.BIOPSIA=5
# NUMERO.DE.DIAS.POST.BIOPSIA=9
# NUMERO.DE.DIAS.POST.BIOPSIA=NO
# FIEBRE=SI
# FIEBRE=NO
# ITU=NO
# ITU=SI
# TIPO.DE.CULTIVO=NO
# TIPO.DE.CULTIVO=UROCULTIVO
# TIPO.DE.CULTIVO=HEMOCULTIVO
# TIPO.DE.CULTIVO=HEMOCULTIVO Y UROCULTIVO
# AGENTE.AISLADO=NO
# AGENTE.AISLADO=E.COLI
# AGENTE.AISLADO=PSEUDOMONAS AERUGINOSA
# PATRON.DE.RESISTENCIA=NO
# PATRON.DE.RESISTENCIA=RESISTENTE A AMPI; CIPRO Y GENTA
# PATRON.DE.RESISTENCIA=AMPI R; CIPRO R; GENTA R; SULFA M R
# PATRON.DE.RESISTENCIA=MULTI SENSIBLE
# PATRON.DE.RESISTENCIA=RESISTENTE A AMPI; SULFA; CEFADROXILO; CEFUROXIMO; CIPRO Y CEFEPIME; CEFOTAXIMA
# HOSPITALIZACION=SI
# HOSPITALIZACION=NO

  ### replicar archivo
  rsync -rltz -O --update ${srcdir}/csv/dfmbio.csv ${srcdir}/csv/dfmbio_num.csv

  ### valores unicos
 #gawk                                                                                                                                 ${srcdir}/csv/dfmbio_num.csv ### integer ### 01
 #gawk                                                                                                                                 ${srcdir}/csv/dfmbio_num.csv ### integer ### 02
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$3) ; sub(/^SI$/,"1",$3) ; print $0}'                       ${srcdir}/csv/dfmbio_num.csv ### factor  ### 03
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$4) ; sub(/^SI$/,"1",$4) ; print $0}'                       ${srcdir}/csv/dfmbio_num.csv ### factor  ### 04
 #gawk                                                                                                                                 ${srcdir}/csv/dfmbio_num.csv ### numeric ### 05
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$6) ; sub(/^SI$/,"1",$6) ; print $0}'                       ${srcdir}/csv/dfmbio_num.csv ### factor  ### 06
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$7) ; sub(/^SI$/,"1",$7) ; print $0}'                       ${srcdir}/csv/dfmbio_num.csv ### factor  ### 07
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^FLUOROQUINOLONA \+ AMINOGLICOSIDO$/,"0",$8) ;
                                                            sub(/^CEFALOSPORINA \+ AMINOGLUCOCIDO$/  ,"1",$8) ;
                                                            sub(/^FLUROQUINOLONA \+ AMINOGLICOSIDO$/ ,"2",$8) ;
                                                            sub(/^FLUOROQUINOLONAS$/                 ,"3",$8) ;
                                                            sub(/^OTROS$/                            ,"4",$8) ; print $0}'             ${srcdir}/csv/dfmbio_num.csv ### factor  ### 08
 #                                                                                                                                     ${srcdir}/csv/dfmbio_num.csv ### integer ### 09
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$10) ; sub(/^SI$/,"1",$10) ; print $0}'                     ${srcdir}/csv/dfmbio_num.csv ### factor  ### 10
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/        ,"0",$11)
                                                            sub(/^SI$/        ,"1",$11)
                                                            sub(/^SI\; ASMA$/ ,"2",$11)
                                                            sub(/^SI\; EPOC$/ ,"3",$11) ; print $0}'                                   ${srcdir}/csv/dfmbio_num.csv ### factor  ### 11
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NEG$/                                         ,"0",$12)
                                                            sub(/^PROSTATITIS$/                                 ,"1",$12)
                                                            sub(/^HIPERPLASIA PROSTATICA$/                      ,"2",$12)
                                                            sub(/^CARCINOMA INDIFERENCIADO DE CELULAS CLARAS$/  ,"3",$12)
                                                            sub(/^ADENOCARCINOMA GLEASON 6$/                    ,"4",$12)
                                                            sub(/^ADENOCARCINOMA GLEASON 7$/                    ,"5",$12)
                                                            sub(/^ADENOCARCINOMA GLEASON 8$/                    ,"6",$12)
                                                            sub(/^ADENOCARCINOMA GLEASON 9$/                    ,"7",$12)
                                                            sub(/^ADENOCARCINOMA GLEASON 10$/                   ,"8",$12) ; print $0}' ${srcdir}/csv/dfmbio_num.csv ### factor  ### 12
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$13)
                                                            sub(/^1$/ ,"1",$13)
                                                            sub(/^2$/ ,"2",$13)
                                                            sub(/^3$/ ,"3",$13)
                                                            sub(/^5$/ ,"4",$13)
                                                            sub(/^9$/ ,"5",$13) ; print $0}'                                           ${srcdir}/csv/dfmbio_num.csv ### factor  ### 13
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$14) ; sub(/^SI$/,"1",$14) ; print $0}'                     ${srcdir}/csv/dfmbio_num.csv ### factor  ### 14
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$15) ; sub(/^SI$/,"1",$15) ; print $0}'                     ${srcdir}/csv/dfmbio_num.csv ### factor  ### 15
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/                       ,"0",$16)
                                                            sub(/^UROCULTIVO$/               ,"1",$16)
                                                            sub(/^HEMOCULTIVO$/              ,"2",$16)
                                                            sub(/^HEMOCULTIVO Y UROCULTIVO$/ ,"3",$16) ; print $0}'                    ${srcdir}/csv/dfmbio_num.csv ### factor  ### 16
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/                     ,"0",$17)
                                                            sub(/^E.COLI$/                 ,"1",$17)
                                                            sub(/^PSEUDOMONAS AERUGINOSA$/ ,"2",$17) ; print $0}'                      ${srcdir}/csv/dfmbio_num.csv ### factor  ### 17
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/                                                                              ,"0",$18)
                                                            sub(/^RESISTENTE A AMPI; CIPRO Y GENTA$/                                                ,"1",$18)
                                                            sub(/^AMPI R; CIPRO R; GENTA R; SULFA M R$/                                             ,"2",$18)
                                                            sub(/^MULTI SENSIBLE$/                                                                  ,"3",$18)
                                                            sub(/^RESISTENTE A AMPI; SULFA; CEFADROXILO; CEFUROXIMO; CIPRO Y CEFEPIME; CEFOTAXIMA$/ ,"4",$18) ; print $0}' ${srcdir}/csv/dfmbio_num.csv ### factor  ### 18
 #gawk                                                                                                                                                                     ${srcdir}/csv/dfmbio_num.csv ### integer ### 19
 #gawk                                                                                                                                                                     ${srcdir}/csv/dfmbio_num.csv ### integer ### 20
  gawk -i inplace 'BEGIN{FS=OFS=","} NR==1 {print $0} NR>1 {sub(/^NO$/,"0",$21) ; sub(/^SI$/,"1",$21) ; print $0}'                                                         ${srcdir}/csv/dfmbio_num.csv ### factor  ### 21

  ### verificar valores unicos
  ### valores unicos dfmbio_num - no tiene encabezado
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f ANO.DEL.PROCEDIMIENTO                   ### integer ### 01
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f EDAD                                    ### integer ### 02
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f DIABETES                                ### factor  ### 03
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f HOSPITALIZACION.ULTIMO.MES              ### factor  ### 04
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f PSA                                     ### numeric ### 05
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f BIOPSIAS.PREVIAS                        ### factor  ### 06
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f VOLUMEN.PROSTATICO                      ### factor  ### 07
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f ANTIBIOTICO.UTILIAZADO.EN.LA.PROFILAXIS ### factor  ### 08
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f NUMERO.DE.MUESTRAS.TOMADAS              ### integer ### 09
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f CUP                                     ### factor  ### 10
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f ENF..CRONICA.PULMONAR.OBSTRUCTIVA       ### factor  ### 11
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f BIOPSIA                                 ### factor  ### 12
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f NUMERO.DE.DIAS.POST.BIOPSIA             ### factor  ### 13
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f FIEBRE                                  ### factor  ### 14
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f ITU                                     ### factor  ### 15
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f TIPO.DE.CULTIVO                         ### factor  ### 16
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f AGENTE.AISLADO                          ### factor  ### 17
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f PATRON.DE.RESISTENCIA                   ### factor  ### 18
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f DIAS.HOSPITALIZACION.MQ                 ### integer ### 19
 #mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f DIAS.HOSPITALIZACION.UPC                ### integer ### 20
  mlr --icsv --from ${srcdir}/csv/dfmbio_num.csv uniq -f HOSPITALIZACION                         ### factor  ### 21
