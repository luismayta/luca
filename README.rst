python-facebook-chatbot
#######################

|Wercker| |license|

:Version: 0.0.0
:Web: https://github.com/luismayta/python-facebook-chatbot
:Download: http://github.com/luismayta/python-facebook-chatbot
:Source: http://github.com/luismayta/python-facebook-chatbot
:Keywords: python-facebook-chatbot

.. contents:: Table of Contents:
    :local:

Python Facebok Chatbot

Features
********

- Task

Requirements:
*************

List of applications:

- `Python 3.6.0`_
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
    ༼ つ ◕_◕ ༽つ Actions for python-facebook-chatbot

    Usage:
        make environment               create environment with pyenv
        make install                   install dependences python by env
        make clean                     remove files of build
        make setup                     install requirements

        Docker:

            make docker.build         build all services with docker-compose
            make docker.down          down services docker-compose
            make docker.ssh           connect by ssh to container
            make docker.stop          stop services by env
            make docker.verify_network           verify network
            make docker.up             up services of docker-compose
            make docker.list           list services of docker
        Docs:

            docs.show                  Show restview README
        Tests:
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

Made with ♥️and ☕️by `author`_ and `company`_.

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
.. _Python 3.6.0: https://www.python.org/downloads/release/python-361
.. _Docker: https://www.docker.com/
.. _Docker Compose: https://docs.docker.com/compose/