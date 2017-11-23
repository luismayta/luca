python-facebook-chatbot
#######################

|Wercker| |license|

:Version: 0.1.0
:Web: https://github.com/luismayta/python-facebook-chatbot
:Download: http://github.com/luismayta/python-facebook-chatbot
:Source: http://github.com/luismayta/python-facebook-chatbot
:Keywords: python-facebook-chatbot

.. contents:: Table of Contents:
    :local:

Python Facebook Chatbot

Features
********

- Task

Requirements:
*************

List of applications:

- `Python 3.6.1`_
- `Docker`_
- `Docker Compose`_

Quick Start
***********

- Fork this repository

Usage
=====

Install dependences
-------------------

.. code-block:: bash

  λ make setup

Build images
------------

.. code-block:: bash

  λ make docker.build


Up services
-----------

.. code-block:: bash

  λ make docker.up

Actions:
********

.. code-block:: bash

  λ make
    ༼ つ ◕_◕ ༽つ Makefile for python-facebook-chatbot
    Usage:
        environment               create environment with pyenv
        install                   install dependences python by env
        clean                     remove files of build
        setup                     install requirements
        hooks                     copy hooks for git

        Docker:

            docker.build         build all services with docker-compose
            docker.cleanup       Clean images docker unnecesary
            docker.down          down services docker-compose
            docker.list          list services of docker
            docker.ssh           connect by ssh to container
            docker.stop          stop services by env
            docker.status        status container by env
            docker.verify_network           verify network
            docker.up             up services of docker-compose
            docker.run            run {service} {env}
            docker.list           list services of docker

        Docs:

            docs.show                  Show restview README
            docs.make.html             Make documentation html
            docs.make.pdf              Make documentation pdf

        Tests:

            test                       Run All tests with coverage
            test.lint                  Run all pre-commit
            test.syntax                Run all syntax in code

License
*******

MIT

Changelog
*********

Please see `CHANGELOG`_ for more information what
has changed recently.

Contributing
************

Please see `CONTRIBUTING`_ for details.

Credits
*******

-  `author`_
-  `contributors`_

Made with :heart: ️:coffee:️ and :pizza: by `author`_ and `company`_.

.. |Wercker| image::
             https://app.wercker.com/status/642f4288274e91f723ec2ecf7c03966c/s/ 'wercker status'
  :target: https://app.wercker.com/project/byKey/642f4288274e91f723ec2ecf7c03966c
  :alt: wercker status
.. |license| image:: https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square
  :target: LICENSE
  :alt: License

.. Links
.. _`changelog`: CHANGELOG.rst
.. _`contributors`: AUTHORS
.. _`contributing`: CONTRIBUTING.rst


.. _`company`: https://github.com/labpositivatd
.. _`author`: https://github.com/luismayta

.. dependences
.. _Python 3.6.1: https://www.python.org/downloads/release/python-361
.. _Docker: https://www.docker.com/
.. _Docker Compose: https://docs.docker.com/compose/
