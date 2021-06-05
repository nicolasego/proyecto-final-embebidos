#!/bin/bash

#Crear carpetas si no existen
mkdir -p /var/tmp/{audios,conect}
conM=1
conD=1

while [ True ]
do

#Lleno = variable con el tamano actual de la carpeta
#tamaños en kB
lleno=$(sudo du -k /var/tmp | tail -1)
lleno=${lleno%	*}
#lim = variable con el límete de la carpeta
	#un porcentaje del tope máximo
lim=`echo "10000*0.7"|bc`
#verificamos que la carpeta no esté llena
if [ $lleno -gt ${lim%.*}  ]
then
#Si está llena la carpeta, enviar al servidor una sola vez un archivo de alarma
if [ $conM = 1 ]
then
echo "Carpeta llena:  $(date +"%Y%m%d-%H:%M:%S")" >> /var/tmp/audios/no_memo.log
conM=0
fi
echo "Carpeta llena"

else

if [ $conM = 0 ]
then
conM=1
fi

#stdout del ping se desecha y stderr se almacena en un txt
ping -c 1 8.8.8.8 > /dev/null 2> /var/tmp/conect/ping.txt
#verificar si hubo error haciendo el ping (no hay internet)
if [ -s /var/tmp/conect/ping.txt ]
then
#Ir llenando un archivo con las horas sin conexión a internet
echo "$(date +"%Y%m%d-%H:%M:%S")" >> /var/tmp/conect/desconexion_inet.log
echo "No hay conexion"
else
#Una vez haya internet
#Verificar si existe desconexion_inet.log
	#Verificar que hubo desconexion a internet
ubi_log="/var/tmp/conect/desconexion_inet.log"
if [ -f $ubi_log ]
then
nn="no_inet_$(date +"%Y%m%d-%H:%M:%S").log"
#Reducir el .log a la primera y ultima medicion de tiempo
#Es decir, hora de desconexion y reconexion
echo -e "Internet Desconectado:  $(head -1 $ubi_log)\nInternet Conectado:  $(tail -1 $ubi_log)" > $ubi_log
#Mover de carpeta para ser enviado el .log
mv $ubi_log /var/tmp/audios/$nn
fi
fi

#Listar dispositivos de sonido conectados
arecord -l > /var/tmp/conect/base.txt
#Verificar si el disposivo esta conectado
if [ $(</var/tmp/conect/base.txt wc -l) -gt "1" ]
then
#Dado un previo estado de desconexion, se envia un solo archivo 
#indicando la hora de reconexión del dispositivo
if [ $conD = 0 ]
then
echo "Dispositivo Conectado:  $(date +"%Y%m%d-%H:%M:%S")" >> /var/tmp/audios/dev_1.log
conD=1
fi

#Nombre de los segmentos de audio a enviar
nombre=$(date +"%Y%m%d-%H:%M:%S")

#Cantidad segundos de la grabacion como argumento
if [ $# -eq 0 ]
then
#5 segundos por defecto
param=5
else
param=$1
fi

#Grabacion de sonido
arecord -D plughw:2,0 -d $param /var/tmp/audios/$nombre.wav

else
#Si el dispositivo se desconecta, se envía un solo archivo con la hora de desconexion
if [ $conD = 1 ]
then
echo "Dispositivo Desconectado:  $(date +"%Y%m%d-%H:%M:%S")" >> /var/tmp/audios/dev_0.log
conD=0
fi
echo "Dispositivo Desconectado"
sleep 5
fi

fi #end lleno

done
