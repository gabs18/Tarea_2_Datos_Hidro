#Exploración de datos geográficos
##Tarea 2 del curso de Procesamiento de datos geográficos (GF0604)
###Fecha de entrega: lunes 24 de mayo 2021 hasta las 7:00 a.m.  

##Estudiante: Gabriela Becerra Sandoval (C01067)


#####En esta práctica se pretende analizar datos hidrológicos para determinar las relaciones correspondientes al flujo de agua en los ríos Banano y Estrella. En efecto, se estudia el caudal de cada uno de ellos según sus valores anuales, mensuales y la correlación entre cada uno de ellos.
#####El archivo con el que se trabaja muestra las fechas correspondientes a cuanta agua transportó el río Estrella, de la cuenca Pandora, y el río Banano. Entre más alto sea el valor, más mm diarios de agua fluyeron en ese río.


#1. Agregar y visualizar los datos del archivo FDC.csv
##Primero se crea el objeto de asociación inp con los datos del la hoja de cálculo. Dentro de los parámetros, agregamos la función "na.strings" que nos permite convertir los datos faltantes en un espacio vacío. De este modo, se obtiene una serie de datos continua.
##Luego, con la función "head(inp)" se visualiza el encabezado y las primeras líneas del archivos con los datos de los ríos Banano y Estrella.
##Finalmente, para tener una vista general de cuántas filas y columnas tiene el csv, se llama la función dim(inp).
inp <- read.csv("FDC.csv", na.strings = "")
head(inp)
dim(inp)
