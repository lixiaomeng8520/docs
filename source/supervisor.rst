Supervisor
==========

* `Supervisor: A Process Control System <http://supervisord.org/>`_

安装easy_install

.. code-block:: bash

    yum install -y python-setuptools

安装supervisor

.. code-block:: bash

    easy_install supervisor

生成配置文件

.. code-block:: bash

   echo_supervisord_conf > /etc/supervisord.conf

启动supervisord

.. code-block:: bash

    supervisord

program常用配置

.. code-block:: bash

    [program:name]
    command=
    user=
    autostart=true
    autorestart=true
    redirect_stderr=true
    stdout_logfile=
    environment=KEY="val"