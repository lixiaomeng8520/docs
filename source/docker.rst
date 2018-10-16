Docker
======

容器技术

* `dockerd <https://docs.docker.com/engine/reference/commandline/dockerd/>`_
* `https://docs.docker.com/compose/startup-order/ <https://docs.docker.com/compose/startup-order/>`_
* `控制docker-compose中服务的启动顺序 <https://blog.csdn.net/xiao_jun_0820/article/details/78676765>`_
* `你的Docker镜像仓库占用了多少空间？删除镜像与空间回收 <https://zhuanlan.zhihu.com/p/33324217>`_

安装
----

资料

* `Get Docker CE for CentOS <https://docs.docker.com/install/linux/docker-ce/centos/>`_
  
导入Docker仓库

.. code-block:: bash

    cat > /etc/yum.repos.d/docker.repo <<EOF
    [docker-ce-stable]
    name=Docker CE Stable - \$basearch
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/7/\$basearch/stable
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/gpg
    EOF

卸载老版本：

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

安装新版本

.. code-block:: bash

    yum install docker-ce

卸载新版本

.. code-block:: bash

    yum remove docker-ce

/var/lib/docker保存docker的镜像，卷，网络等，如果不需要了，可以删掉：

.. code-block:: bash

    rm -rf /var/lib/docker

****

Swarm
-----

资料

* `Swarm mode overview <https://docs.docker.com/engine/swarm/>`_

UI

* `docker-swarm-visualizer <https://github.com/dockersamples/docker-swarm-visualizer>`_
* `swarmpit <https://github.com/swarmpit/swarmpit>`_

集群

+----------------------------+--------------------------------------------------------------------------------------------+
| 描述                       | 命令                                                                                       |
+============================+============================================================================================+
| 初始化swarm                | docker swarm init --advertise-addr 192.168.56.20                                           |
+----------------------------+--------------------------------------------------------------------------------------------+
| 获取worker的join-token     | docker swarm join-token worker                                                             |
+----------------------------+--------------------------------------------------------------------------------------------+
| 加入集群                   | docker swarm join --token aaa 192.168.56.20                                                |
+----------------------------+--------------------------------------------------------------------------------------------+

节点

+----------------------------+--------------------------------------------------------------------------------------------+
| 描述                       | 命令                                                                                       |
+============================+============================================================================================+
| 查看节点                   | docker node ls                                                                             |
+----------------------------+--------------------------------------------------------------------------------------------+
| 剔除一个节点               | docker node update --availability drain worker1                                            |
+----------------------------+--------------------------------------------------------------------------------------------+
| 激活一个节点               | docker node update --availability active worker1                                           |
+----------------------------+--------------------------------------------------------------------------------------------+

服务

+----------------------------+--------------------------------------------------------------------------------------------+
| 描述                       | 命令                                                                                       |
+============================+============================================================================================+
| 部署一个服务               | docker service create --replicas 1 --name helloworld alpine ping docker.com                |
+----------------------------+--------------------------------------------------------------------------------------------+
| 查看服务列表               | docker service ls                                                                          |
+----------------------------+--------------------------------------------------------------------------------------------+
| 查看服务详情               | docker service inspect --pretty helloworld                                                 |
+----------------------------+--------------------------------------------------------------------------------------------+
| 查看哪些节点在运行服务     | docker service ps helloworld                                                               |
+----------------------------+--------------------------------------------------------------------------------------------+
| 伸缩服务                   | docker service scale hellowrld=5                                                           |
+----------------------------+--------------------------------------------------------------------------------------------+
| 删除服务                   | docker service rm helloworld                                                               |
+----------------------------+--------------------------------------------------------------------------------------------+
| 升级服务                   | docker service update --image redis:3.0.7 redis                                            |
+----------------------------+--------------------------------------------------------------------------------------------+

Logs
----

资料

* `View logs for a container or service <https://docs.docker.com/config/containers/logging/>`_
* https://stackoverflow.com/questions/40030555/docker-gelf-driver-env-option

使用gelf驱动转存到logstash
^^^^^^^^^^^^^^^^^^^^^^^^^^

logstash开启gelf 12201端口

.. code-block:: bash

    gelf {
        port => 12201
    }

run

.. code-block:: bash

    docker run -d --name tomcat --log-driver gelf --log-opt gelf-address=udp://192.168.1.2:12201 --log-opt labels=mhost,lname --label mhost=192.168.1.1 --label lname=test tomcat:8.5.32

compose

.. code-block:: bash

    version: '3'
   
    services:
        yanyu-server:
            image: tomcat:8.5.32
            labels:
                mhost: 192.168.1.1
                lname: test
            logging:
                driver: gelf
                options:
                    gelf-address: udp://192.168.1.2:12201
                    labels: mhost,lname


Compose
-------

* `Compose file version 3 reference <https://docs.docker.com/compose/compose-file/>`_

2种特殊挂载
^^^^^^^^^^^

描述

+-----------+----------------------------------------------------------------+
| 配置      | 默认挂载路径                                                   |
+===========+================================================================+
| configs   | /<config_name>                                                 |
+-----------+----------------------------------------------------------------+
| secrets   | /run/secrets/<secret_name>                                     |
+-----------+----------------------------------------------------------------+

语法

.. code-block:: bash

    services:
        redis:
            configs:
                - source:redis_config
                  target:/etc/redis.config
    
    configs:
        redis_config
            file: ./redis.config

Registry
--------

* `Configuring a registry <https://docs.docker.com/registry/configuration/>`_
* `mortensteenrasmussen/docker-registry-manifest-cleanup <https://github.com/mortensteenrasmussen/docker-registry-manifest-cleanup>`_
* `Authenticate proxy with nginx <https://docs.docker.com/registry/recipes/nginx/>`_
* `Docker Registry镜像清理问题 <https://ningyu1.github.io/site/post/46-docker-registry/>`_
  
清理未tagged的manifest
^^^^^^^^^^^^^^^^^^^^^^

1. 执行API逻辑删除manifest
   
.. code-block:: bash

    docker pull mortensrasmussen/docker-registry-manifest-cleanup

    docker run -it --rm --net host -v /sda/docker/registry:/registry -e REGISTRY_URL=https://user:pass@reg1.dahe.cn [-e DRY_RUN=true] mortensrasmussen/docker-registry-manifest-cleanup

2. 在registry container里执行garbage-collect
   
.. code-block:: bash

    registry garbage-collect [-d] /etc/docker/registry/config.yml
