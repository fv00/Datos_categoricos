library(readxl)
library(dplyr)

#Lectura de datos
datos_encuestas <- read_excel('resultados_categoricos.xlsx')
datos_encuestas

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

tabla_general <- datos_encuestas %>% 
    group_by(Genero, Belleza) %>% summarise(Resultado =sum(Resultado))
tabla_general <- t(matrix(tabla_general$Resultado, nrow = 2, ncol = 2))
tabla_general <- tabla_general[c(2,1),]
row.names(tabla_general) <- c('Mujer', 'Hombre')
colnames(tabla_general) <- c('Bonito', 'Feo')

tabla_mujeres <- datos_encuestas[datos_encuestas['Genero-Encuestado']=='F',] %>% 
    group_by(Genero, Belleza) %>% summarise(Resultado =sum(Resultado))
tabla_mujeres <- t(matrix(tabla_mujeres$Resultado, nrow = 2, ncol = 2))
row.names(tabla_mujeres) <- c('Mujer', 'Hombre')
colnames(tabla_mujeres) <- c('Bonito', 'Feo')

tabla_hombres <- datos_encuestas[datos_encuestas['Genero-Encuestado']=='M',] %>% 
    group_by(Genero, Belleza) %>% summarise(Resultado =sum(Resultado))
tabla_hombres <- t(matrix(tabla_hombres$Resultado, nrow = 2, ncol = 2))
tabla_hombres <- tabla_hombres[c(2,1),]
row.names(tabla_hombres) <- c('Mujer', 'Hombre')
colnames(tabla_hombres) <- c('Bonito', 'Feo')

##Pruebas de fisher sobre tablas

#Tabla general
fisher.test(tabla_general)
"Se concluye que la selección es estrictamente aleatoria"

#Tabla mujeres
fisher.test(tabla_mujeres)
"Se concluye que la selección es estrictamente aleatoria"

#Tabla hombres
fisher.test(tabla_hombres)
"Se concluye que la selección es estrictamente aleatoria"