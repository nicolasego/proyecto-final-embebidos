# proyecto-final-sistemas-embebidos
Grabadora de voz segura en la nube.

El presente repositorio presenta el proyecto  final de sistemas embebidos, que corresponde con una grabadora segura en la nube, compuesta de los siguientes scripts:

El programa principal mediante el cual se crea la partición de la RAM, se pide la llave para la desencripción de los archivos y se habilita un programa en python que tiene el multiproceso-----> https://github.com/nicolasego/proyecto-final-embebidos/blob/main/pyMacro.sh

De igual forma se presenta un programa en python, que presenta un multiproceso, que consta del proceso de creación de grabaciones y el proceso de envio de las mismas a la nube-----> https://github.com/nicolasego/proyecto-final-embebidos/blob/main/multi.py

Tambien se cuenta con el proceso de grabación----> https://github.com/nicolasego/proyecto-final-embebidos/blob/main/grabar.sh

y el proceso de envio a la nube----> https://github.com/nicolasego/proyecto-final-embebidos/blob/main/enviar.sh

Demonio con systemd----> https://github.com/nicolasego/proyecto-final-embebidos/blob/main/macro.service

El proyecto requirió de codigos en bash y python, así como el uso de servicio de nube, los multiprocesos, la creación de demonios usando systemd y el uso de llaves para la seguridad del mismo.


Conclusiones:

o Se logró aplicar gran parte del contenido de la asignatura durante la adecuación del sistema.

o Se permite contar con un sistema que esta siempre arriba, gracias al uso de systemd.

o Se evidencio y se puso en practica la importancia y gran utilidad de los multiprocesos.

o Se usaron y apropiaron los servicios de la nube para contar con un almacenamiento constante de las salidas del sistema.

o Se logró crear un sistema seguro mediante el uso de archivos temporales y el uso de llaves.

o Se pudo comprender lo que podria ser una solución presentada a nivel compercial y lo que se puede ofrecer mediante dichos sistemas.
