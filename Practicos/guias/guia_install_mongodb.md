# Guía de Instalación de MongoDB y Robo3T

En esta guía vamos a mostrar paso a paso como instalar MongoDB y Robo3T. Además, hacia el final de la guía, vamos a mostrar como cargar una Base de Datos NOSQL de MongoDB a través del comando __mongorestore__.

## Sistemas Operativos Windows

### Servidor MongoDB

Los pasos para instalar el servidor de MongoDB se describen a continuación:
1. En primer lugar, vamos a instalar el Servidor MongoBD, para ello debemos descargarlo desde [el Sitio Web, en la Sección Community](https://www.mongodb.com/download-center/community) y descargamos el Server (en la Sección Server) para nuestro Sistema Operativo Windows. 
2. Una vez que descargado el instalador, se instala optando por el tipo de instalación __complete__.
3. Ahora, debemos crear una carpeta llamada __data__ en la Unidad __C:__ y dentro de ella una carpeta que denominada __db__. El path completo de estos nuevos directorios quedará de la siguiente manera: __C:\data\db__.

A continuación podemos observar gráficamente estas últimas instrucciones:

<img src="./img/instalar_mongo.png" alt="drawing" width="700px" align="middle"/>

Ahora ya tenemos instalado el servidor mongoDB, cada vez que vayamos a trabajar con el debemos iniciarlo ejecutando el archivo __mongod__ que se encuentra en el directorio de instalación, generalmente en __C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin__. 
En caso que no sepas como hacerlo, seguí las siguientes instrucciones:
1. Abrimos una Consola de Windows escribiendo _cmd_ en la barra de búsqueda de la barra inferior de Windows.
2. Escribimos __cd C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin__.
3. Escribimos __mongod__ y damos Enter.
4. Cumplidos estos pasos, se iniciará el Servidor Mongo, el cual estará escuchando conexiones en el puerto 27017 (por defecto).

A continuación podemos observar gráficamente estas últimas instrucciones:

<img src="./img/ejecutar_mongo.png" alt="drawing" width="700px" align="middle"/>


### Robo3T
Si bien podríamos con MongoDB desde consola, ejecutando el archivo __mongo__, existen dos interfaces gráficas que harán mucho mas sencillas nuestras interacciones: Robo 3T y Meet Studio 3T (su hermano mayor según se anuncia en el sitio web oficial).

Nosotros vamos a trabajar con Robo 3T que es la opción mas sencilla y liviana para interactuar con nuestras Bases de Datos NOSQL. 

Los pasos para instalar el servidor de MongoDB se describen a continuación:
1. Descargamos ROBO 3T del [Sitio web de la herramienta](https://robomongo.org/download), de acuerdo a la versión de nuestro Sistema Operativo.
2. Ejecutamos el instalador, que es un instalador típico de Windows (siguiente, siguiente...) y listo.

<img src="./img/instalar_robo3t.png" alt="drawing" width="700px" align="middle"/>


## Sistemas Operativos UNIX

