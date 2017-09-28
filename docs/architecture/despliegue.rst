Despliegue
**********

El despliegue de los componentes se encuentra claramente definido en la
siguiente imagen:


.. uml::

  left to right direction

  actor Admin
  node "Laptop"
  component "Terraform"
  component "ansible"
  artifact "Inventory"
  artifact "playbook"
  cloud AWS
  node Application
  node ActiveMQ
  node Other1
  [Admin] --> [Laptop]
  [Laptop] --> [Terraform]
  [Terraform] --> [ansible]
  [ansible] <- [Inventory]
  [ansible] <- [playbook]
  [ansible] -- [AWS]
  [AWS] -- [Application]
  [AWS] -- [ActiveMQ]
  [AWS] -- [Other1]

Pasos
=====

Orquestar servicios:
--------------------

.. code-block:: bash

  λ terraform init
  λ make decrypt_vars env=stage
  λ terraform apply
  λ make encrypt_vars env=stage

Orquestar Servidores:
---------------------

.. code-block:: bash

  λ make ansible_provision env=stage
  λ make ansible_deploy env=stage

Orquestar Servidores:
---------------------

.. code-block:: bash

  λ make ansible_provision env=stage
  λ make ansible_deploy env=stage

Desplegar Aplicacion
--------------------

.. code-block:: bash

  λ make ansible_deploy_tags env=stage tags=deployment

Admin
=====


Laptop
======

Terraform
=========

Ansible
=======

Inventory
---------

Playbook
--------


.. rubric:: Notas

.. include:: ../_templates/links.rst
