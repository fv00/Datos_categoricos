library(readxl)

#Lectura de datos
datos_encuestas <- read_excel('resultados_categoricos.xlsx')

#Generacion de bases de datos
tablas <- list()
for(i in 1:10){
    datos <- as.data.frame(datos_encuestas[datos_encuestas['Tanda']==i,])
    datos <- t(matrix(datos$Resultado, nrow = 2, ncol = 2))
    row.names(datos) <- c('Mujer', 'Hombre')
    colnames(datos) <- c('Bonito', 'Feo')
    print(i)
    tablas[[i]] <- datos
}
tablas