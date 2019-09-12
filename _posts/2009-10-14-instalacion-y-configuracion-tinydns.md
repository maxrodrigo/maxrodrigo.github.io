---
title: Instalación y configuración de TinyDNS [ES]
---

TinyDNS es el servidor de nombres de [djbDNS](http://cr.yp.to/djbdns.html), una suite de herramientas para DNS, creada por [Daniel J. Berstein](http://cr.yp.to/djb.html). Por defecto el servidor solo responde a consultas de las zonas previamente declaradas, no responde consultas inversas ni transferencia de zonas. Para estas otras funcionalidades otra serie de herramientas estan disponibles dentro de la suite. Esta modularidad lo hace muy potente, versatil y rápido.

djbDNS se compone de 6 herramientas:

- TinyDNS: Servidor de Nombres.
- DNScache: Almacena y resuelve direcciones, como aquellas que TinyDNS no tiene declaradas.
- WallDNS: Resuleve consultas inversas.
- RblDNS: Provee información sobre direcciónes IP.
- AxfrDNS: Responde consultas de tranferencia de zona.
- Axfr-get: Realiza las transferencias de zona.

djbDNS tiene 2 dependencias, daemontools 0.70+ y ucspi-tcp que debemos instalar antes de continuar.

## Setup

Creamos un directorio para almacenar nuestras descargas.

```sh
mkdir /package
chmod 755 /package
cd /package
```


## Compilar Daemontools

> Deamontools es la colección de herramientas para el manejo de servicios en UNIX.

Descargamos daemontools 0.76 y descomprimimos.

``` sh
wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz
tar xvfz daemontools-0.76.tar.gz
```

### Compilamos

Si estamos trabajando en Linux y no en BSD o Solaris es probable que al compilar recibamos el siguiente error:

`/usr/bin/ld: errno: TLS definition in /lib64/libc.so.6 section .tbss mismatches non-TLS reference in envdir.o.`

Editamos `/package/admin/daemontools-0.76/src/conf--cc` e incluimos `-include /usr/include/errno.h` al final de la primer linea.  

Deberia quedarnos asi:

`gcc -O2 -Wimplicit -Wunused -Wcomment -Wchar-subscripts -Wuninitialized -Wshadow -Wcast-qual -Wcast-align -Wwrite-strings -include /usr/include/errno.h`

```sh
cd admin/daemontools-0.76/
package/install
```

Por defecto la instalación carga `svscan` a la rutina de incio y agrega `SV:12345:respawn:/command/svscanboot` a `/etc/inittab`. Ejecutemos `svscan`.

```sh
svscan /service &
```

## Instalación de ucspi-tcp

> [ucspi-tcp](http://cr.yp.to/ucspi-tcp.html) es el acronimo de UNIX Client-Server Program Interface for TCP es una herramienta de linea de comando para crear aplicaciones TCP de cliente-servidor.

Descargamos ucspi-tcp 0.88 y descomprimimos.

``` sh
cd /package
wget http://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz
tar xvzf ucspi-tcp-0.88.tar.gz
```

### Compilamos

Al igual que daemontools es probable que al compilar recibas un error de `libc.so`. Editamos `/package/ucspi-tcp-0.88/conf-cc` y al final de la primer linea agregamos `-include /usr/include/errno.h`.  

Deberia quedarnos asi:

`gcc -O2 -include /usr/include/errno.h`

``` sh
cd ucspi-tcp-0.88/
make
make setup check
```

## Instalación de djbDNS y TinyDNS

Descargamos y descomprimimos djbDNS.

``` sh
cd /package
wget http://cr.yp.to/djbdns/djbdns-1.05.tar.gz
tar xvzf djbdns-1.05.tar.gz
cd djbdns-1.05/
```

### Compilamos

``` sh
echo gcc -O2 -include /usr/include/errno.h > conf-cc
make
make setup check
```

Ya con djbDNS y sus dependencias creamos dos usuarios: `Gtinydns` y `Gdnslog`.

``` sh
useradd Gtinydns
useradd Gdnslog
```

Ejecutamos `tinydns-conf` para crear la carpeta del servicio en `/etc/tinydns`.

> Recuerda correr el commando con la IP publica de tu servidor.

```sh
tinydns-conf Gtinydns Gdnslog /etc/tinydns <public-ip>
```

> La IP debe estar configurada en el servidor y no debe utilizar DNScache ni algun otro servicio en el puerto 53.
> Si se desea usar DNSCache en el mismo servidor se puede utilizar otra interfaz en el mismo servidor.

Le notificamos a `svscan` del nuevo servicio y usamos `svstat` para validar que el servicio esté corriendo.

``` sh
ln -s /etc/tinydns /service/tinydns
svstat /service/tinydns
```

Si reciben un `supervise` error, comprueben que el proceso este corriendo.

```sh
ps aux | grep sv
```

De no estarlo pueden ejectuarlo manualmente `svscan /service &`

Re-ejecutar `svstat /service/tinydns` debería devolver el pid.

```sh
/service/tinydns: up (pid ####) ## seconds
```

## Delegación y zonas

Primero debemos configurar en nuestro proovedor de dominios (GoDaddy, Namecheap, etc) nuestros dominios. Registraremos un Nameserver con nuestra IP. Una vez hecho esto, debemos configurar nuestro servidor para que responda a nuestro dominio. Recuerden usar nuestra IP.
Usaremos los commandos `add-host` y `add-alias` que se encuentran en el directorio `/etc/tinydns/root`. Estos comandos editan el archivo `/etc/tinydns/root/data`. Luego de editado este archivo debemos compilarlo con el comando `make`.

Podemos editar el archivo `data` de manualmente.

Agreguemos nuestro NS al archivo data y compilemos.

```sh
cd /etc/tinydns/root
./add-ns dominio.com 1.2.3.4
make
```

Si quisieramos agregar un nuevo dominio simplemente con add-host.

```sh
./add-host new-domain.com 1.2.3.4
```

Una alternativa es editar el archivo `data` manualmente con la siguiente forma:

```sh
`=tiger.heaven.af.mil:1.8.7.5` para add-host, o `+www.heaven.af.mil:1.8.7.4` para add-alias.
```

No olvides compilar el archivo data al finalizar la edición.
