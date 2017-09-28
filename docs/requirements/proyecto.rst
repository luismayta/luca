Proyecto
********

En este documento explicaremos las dependencias del proyecto, tanto como
puertos, servidores, dominios

Desarrollo
==========

Accesos:
--------

**puerto 22:**
Es usado por defecto por `ssh`_ para poder conectarnos a diferentes servicios
que se usa a nivel de desarrollo e infraestructura como codigo al desplegar
hacia diferentes servicios de `cloud computing`_

Uso:

- para el desarrollo de la aplicacion usamos `git`_ con el cual nos podemos
  conectar al `repositorio`_ y podemos subir y bajar el codigo desarrollado
- Despliegue de codigo del proyecto a `AWS EC2`_
- Despliegue automatizado con `Ansible`_

Arquitectura
============


Webhooks
--------


MicroServices
-------------

Es un enfoque para desarrollar una aplicación software como una serie de
pequeños servicios, cada uno ejecutándose de forma autónoma y comunicándose
entre sí, por ejemplo, a través de peticiones HTTP a sus API.

Alcance
=======


.. include:: ../_templates/links.rst
