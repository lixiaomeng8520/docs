安装与卸载
==========

资料

* `Get Docker CE for CentOS <https://docs.docker.com/install/linux/docker-ce/centos/>`_
  
导入Docker仓库
--------------

.. code-block:: bash

    cat > /etc/yum.repos.d/docker.repo <<EOF
    [docker-ce-stable]
    name=Docker CE Stable - \$basearch
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/7/\$basearch/stable
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/gpg
    EOF

卸载老版本
----------

卸载软件包：

.. code-block:: bash

    yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

/var/lib/docker保存docker的镜像，卷，网络等，如果不需要了，可以删掉：

.. code-block:: bash

    rm -rf /var/lib/docker

安装
----

.. code-block:: bash

    yum install docker-ce

卸载
----

卸载软件包

.. code-block:: bash

    yum remove docker-ce

/var/lib/docker保存docker的镜像，卷，网络等，如果不需要了，可以删掉：

.. code-block:: bash

    rm -rf /var/lib/docker
