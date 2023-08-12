# ### preparar imagenes y tablas
# bash ./src/PrepararInsumos.sh

  ### compilar informe pdf
  R --slave -e "rmarkdown::render( \"borrador_caso02.R\" )"

  ### compilar presentacion pdf
  R --slave -e "rmarkdown::render( \"presentacion_caso02.R\" )"

# ### funcion para modificar documento
# source ./src/FuncionesAuxiliares.sh

# ### compilar word modificado
# pandoc -s -S ./word/resumen_word.md -o ./word/resumen_word.docx
