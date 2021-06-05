import multiprocessing
import subprocess

#Definicion de las funciones para los 2 procesos
def enviar():
	#Funcion que permtie enviar todos archivos contenidos
	#en el directorio temporal /var/tmp/audios/
    subprocess.call(['bash', '/var/tmp/enviar.sh'])
def grabacion():
	#Funcion que permite grabar segmentos de audio según
	#la duracion de tiempo requerida, independiente de la conexión a internet
    subprocess.call(['bash','/var/tmp/grabar.sh'])

if __name__ == '__main__':
#Creacion de los procesos
    p = multiprocessing.Process(target=enviar,)
    q = multiprocessing.Process(target=grabacion,)
    p.start()
    q.start()
    p.join()
    q.join()
