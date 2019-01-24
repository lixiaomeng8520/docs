Time
====

时区设置
--------

.. code-block:: bash

    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    echo 'Asia/Shanghai' > /etc/timezone

时间同步
--------

安装服务

.. code-block:: bash

    yum install -y chrony

修改配置文件/etc/chrony.conf

.. code-block:: bash

    server 0.cn.pool.ntp.org iburst
    server 1.cn.pool.ntp.org iburst
    server 2.cn.pool.ntp.org iburst
    server 3.cn.pool.ntp.org iburst

启动

.. code-block:: bash

    systemctl start chronyd
    systemctl enable chronyd