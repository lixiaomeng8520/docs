镜像和仓库
----------

国内镜像
^^^^^^^^

* `阿里巴巴 <https://opsx.alibaba.com/mirror>`_
* `清华大学开源软件镜像站 <https://mirrors.tuna.tsinghua.edu.cn/>`_
* `科大开源镜像站 <http://mirrors.ustc.edu.cn/>`_

一些仓库
^^^^^^^^^

centos

.. code-block:: bash

    cat > /etc/yum.repos.d/centos.repo <<EOF
    [base]
    name=CentOS-7 - Base
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/os/\$basearch/
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7

    #released updates
    [updates]
    name=CentOS-7 - Updates
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/updates/\$basearch/
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7

    #additional packages that may be useful
    [extras]
    name=CentOS-7 - Extras
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/extras/\$basearch/
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
    EOF

epel::

    cat > /etc/yum.repos.d/epel.repo <<EOF
    [epel]
    name=epel
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/epel/7/\$basearch
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/epel/RPM-GPG-KEY-EPEL-7
    EOF

ius::

    cat > /etc/yum.repos.d/ius.repo <<EOF
    [ius-stable]
    name=ius - stable
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/ius/stable/CentOS/7/\$basearch
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/ius/IUS-COMMUNITY-GPG-KEY
    EOF

docker::

    cat > /etc/yum.repos.d/docker.repo <<EOF
    [docker-ce-stable]
    name=Docker CE Stable - \$basearch
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/7/\$basearch/stable
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/gpg
    EOF

mongodb::

    cat > /etc/yum.repos.d/mongodb.repo <<EOF
    [mongodb-org]
    name=MongoDB Repository
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/mongodb/yum/el7/
    gpgcheck=0
    enabled=1
    EOF