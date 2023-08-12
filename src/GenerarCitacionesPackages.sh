  ### variable entorno
  declare -gx srcdir="$HOME/PUCV/est741_2019/caso02"

  ### extraer librerias cargadas en sesion
  grep -i --color 'library([A-Za-z]' ${srcdir}/src/sesion_caso02.R ${srcdir}/src/.Rhistory \
    | cut -d':' -f 2 \
    | sort | uniq \
    | sed -r 's/library\((.*)\)/utils::toBibtex( utils::citation( package = \"\1\" ) )/' \
    > ${srcdir}/src/GenerarCitacionesPackages.R

  ### ejecutar citaciones en bruto
  R --slave -f ${srcdir}/src/GenerarCitacionesPackages.R \
    > ${srcdir}/src/citaciones_caso02_paquetes_importar.bib
