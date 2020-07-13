#LIMPIEZA DE DATA SOBRE DESIGUALDAD Y POBREZA

#librerias
library(rio)
library(htmltab)
library(stringr)

#IMPORTAR DATA HOJA POR HOJA
#se importa la data por hojas pues cada hoja trabaja un indicador diferente y es inviable hacer un merge entre las 3, dado que cada indicador es observado en un periodo de varios años

desig ="https://github.com/MilagrosBadillo/TrabajoFinalEAP2/raw/master/Poverty%20and%20GINI.xlsx"
gini <- import(desig, sheet = "GINI")
View(gini)

headpov <- import(desig, sheet = "Poverty headcount")
View(headpov)

nacpov <- import(desig, sheet = "Poverty nat")
View(nacpov)

#LIMPIAR DATA
names(gini)
names(nacpov)
names(headpov)

names(gini)=str_split(names(gini)," ",simplify = T)[,1]
names(nacpov)=str_split(names(nacpov)," ",simplify = T)[,1]
names(headpov)=str_split(names(headpov)," ",simplify = T)[,1]

gini[,c(1,2,4,28)]=NULL
nacpov[,c(1,2,4,5,6,7,8,22)]=NULL
headpov[,c(1,2,4,28)]=NULL
#eliminamos los códigod de países porque aunque facilitarían el trabajo con otras bases de datos, no están presentes en las otras bases de datos que se usarán en el trabajo grupal

#eliminar filas vacías de abajo
gini=gini[-c(26:30),]
headpov=headpov[-c(26:30),]
nacpov=nacpov[-c(26:30),]


gini[,]=lapply(gini[,], trimws,whitespace = "[\\h\\v]")
nacpov[,]=lapply(nacpov[,], trimws,whitespace = "[\\h\\v]")
headpov[,]=lapply(headpov[,], trimws,whitespace = "[\\h\\v]")

str(gini)
str(headpov)
str(nacpov)

gini[,c(2:24)]=lapply(gini[,c(2:24)],as.numeric)
nacpov[,c(2:20)]=lapply(nacpov[,c(2:20)],as.numeric)
headpov[,c(2:24)]=lapply(headpov[,c(2:24)],as.numeric)

#OJO:  no omitimos/eliminamos todos los valores NA porque, de hacerlo, nos quedamos con muy pocas variables

#gini=na.omit(gini)
#headpov=na.omit(headpov)

#Vemos que existen muchos casos con al menos un NA 

complete.cases(gini)

#por ende, en adelante, se agregará na.rm = TRUE al realizar operaciones con la data

mean(gini$`2002`, na.rm = TRUE)






