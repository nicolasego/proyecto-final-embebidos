#!/bin/bash

#Crear la carpeta si no existe
mkdir -p /var/tmp/conect

while [ True ]
do
#Verificar si hay audios por enviar
if [ "$(ls /var/tmp/audios)" ]
then
#Ubicacion llave Azure
ubi_key="~/Macro/ProyectoFinal_key.pem"
#nombre audios enviados
nombre_audio="$(ls -c /var/tmp/audios | tail -1)"
#stdout del ping se desecha y stderr se almacena en un txt
ping -c 1 8.8.8.8 > /dev/null 2> /var/tmp/conect/ping.txt
#verificar si no hubo error haciendo el ping (si hay internet)
if [ ! -s /var/tmp/conect/ping.txt ]
then
#Enviar archivo via SCP. Descartar el stderr y el stdout
scp -i $ubi_key /var/tmp/audios/$nombre_audio azure@13.85.68.97:/home/azure/audios/$nombre_audio 2> /dev/null > /dev/null
echo "Enviado $nombre_audio"
#Eliminar el último archivo enviado
rm /var/tmp/audios/$nombre_audio
fi
sleep 1
fi
done

