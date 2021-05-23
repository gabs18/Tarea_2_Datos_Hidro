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

inp[!complete.cases(inp),]

#Caudales de los ríos Estrella y Banano
plot(inp[,2], 
     main = "Variabilidad diaria del caudal de los ríos Estrella y Banano",
     xlab = "Días desde 1973 hasta 1983",
     ylab = "Caudal (mm/día)",
     type = "l", 
     col= "#CC3366")
legend(x = "topright",
       inset = c(0, 0),
       legend = c("Río Banano", "Río Estrella"), 
       lty = c(1, 1),
       col = c("#CC3366", "#009999"),
       lwd = 2,
       xpd = TRUE) 
lines(inp[,3], col = "#009999")


#Promedio de los caudales diarios por 10 años
#Cálculo de los caudales
summary(inp[,2:3])
#Historiogramas que muestran esos cálculos
hist(inp[,2],
     main = "Histograma del caudal del Río Estrella",
     xlab = "Valor del caudal (mm/día)",
     ylab = "Frecuencia",
     col=c("#009991", "red", "blue", "darkgreen", "magenta"))
hist(inp[,3],
     main = "Histograma del caudal del Río Banano",
     xlab = "Valor del caudal (mm/día)",
     ylab = "Frecuencia",
     col=c("lightblue", "darkgreen", "red", "green", "magenta"))

#Cambiar nombres de las columnas
names(inp) <- c("fecha", "Estrella", "Banano")
attach(inp)

#Definir el formato de fecha de nuestra serie de datos
Tempdate <- strptime(inp[,1], format = "%d/%m/%Y")

#Calcular el acumulado del volumen anual de agua transportado por los ríos
MAQ_Estrella <- tapply(inp[,2], format(Tempdate, format = "%Y"), FUN = sum)
MAQ_Banano <- tapply(inp[,3], format(Tempdate, format = "%Y"), FUN = sum)
write.csv(rbind(MAQ_Estrella, MAQ_Banano), file = "MAQ.csv")



#Graficar valores anuales

windows(width = 20, height = 15)
opar <- par(no.readonly = TRUE)
par(mar = c(5, 5, 5, 5))
plot(MAQ_Banano,
     ylim = c(100, 3000),
     xlab = "Años",
     ylab = "Caudal (mm/día)",
     main = "Valores anuales del caudal de los ríos Banano y Estrella",
     lwd = 2,
     col = "blue",
     type = "l")
legend(x = "bottom",
       inset = c(0, 0),
       legend = c("Río Banano", "Río Estrella"), 
       lty = c(1, 1),
       col = c("blue", "red"),
       lwd = 2,
       xpd = TRUE) 
on.exit(par(opar))
lines(MAQ_Estrella, col = "red", type = "l", lwd = 2)



#Graficar variabilidad anual
MMQ_Estrella <- tapply(inp[,2], format(Tempdate, format = "%m"), FUN = sum)
MMQ_Banano <- tapply(inp[,3], format(Tempdate, format = "%m"), FUN = sum)

#Análisis de correlación
corinp <- cor(inp[,2:3], method = "spearman")
plot(Estrella, Banano,
     col = "darkblue",
     main = "Análisis de correlación con el método Spearman")

#Correlación lineal
inp.lm <- lm("Estrella" ~ "Banano", data = inp)
plot(inp.lm)




