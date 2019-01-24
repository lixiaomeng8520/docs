Supervisor
==========

* `Supervisor: A Process Control System <http://supervisord.org/>`_

安装easy_install
----------------

.. code-block:: bash

    yum install -y python-setuptools

安装supervisor
--------------

.. code-block:: bash

    easy_install supervisor

生成配置文件
------------

.. code-block:: bash

   echo_supervisord_conf > /etc/supervisord.conf

启动supervisord
---------------

.. code-block:: bash

    supervisord

program常用配置
---------------

.. code-block:: bash

    [program:name]
    command=
    user=
    autostart=true
    autorestart=true
    redirect_stderr=true
    stdout_logfile=
    environment=KEY="val"

注意事项
--------

默认sock, pid, log路径都在/tmp下，而系统有时会清理/tmp目录，所以修改这三个路径到/var下。比如：

1. /var/run/supervisor.sock
2. /var/run/supervisor.pid
3. /var/log/supervisor.log