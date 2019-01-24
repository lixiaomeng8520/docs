Samba
=====

安装

.. code-block:: bash

    yum -y install samba

查看用户

.. code-block:: bash

    pdbedit -L

添加用户（系统已存在用户）

.. code-block:: bash

    smbpasswd -a root

修改配置/etc/samba/smb.conf

.. code-block:: bash

    [homes]
    xxxx
    valid users = root
    xxxx

启动

.. code-block:: bash

    systemctl start smb
    systemctl enable smb

访问：在windows资源管理器里输入 \192.168.56.20\