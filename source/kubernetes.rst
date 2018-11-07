Kubernetes
==========

* `Learn Kubernetes in Under 3 Hours: A Detailed Guide to Orchestrating Containers <https://medium.freecodecamp.org/learn-kubernetes-in-under-3-hours-a-detailed-guide-to-orchestrating-containers-114ff420e882>`_
* `三小时攻克 Kubernetes！ <https://mp.weixin.qq.com/s/gLbfwS89cpAkkoVMzJc6sQ>`_
* `官网Setup <https://kubernetes.io/docs/setup/>`_
* `kubeadm 部署 kube1.10 <https://blog.csdn.net/golduty2/article/details/80700491>`_
* `kubectl-commands <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands>`_
* `官方入门教程 <https://blog.csdn.net/kikajack/article/details/79866006>`_
* `十分钟带你理解Kubernetes核心概念 <http://www.dockone.io/article/932>`_
* `RKE快速上手指南：开源的轻量级K8S安装程序 <https://segmentfault.com/a/1190000012288926>`_
* `Kubernetes中文手册 <https://www.kubernetes.org.cn/docs>`_
* `如何在Kubernetes中暴露服务访问 <https://segmentfault.com/a/1190000007990723>`_
* `kubernetes入门命令行操作（实例演示） <www.360doc.com/content/18/0225/21/11935121_732436265.shtml>`_
* `Kubernetes核心概念总结 <https://www.cnblogs.com/zhenyuyaodidiao/p/6500720.html>`_
* `从零开始搭建Kubernetes集群（一、开篇） <https://www.jianshu.com/p/78a5afd0c597>`_
* `Web UI (Dashboard) <https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/>`_
* `NGINX Ingress Controller <https://kubernetes.github.io/ingress-nginx/>`_
* `Kubernetes Nginx Ingress 教程 <https://mritd.me/2017/03/04/how-to-use-nginx-ingress/?utm_source=tuicool&utm_medium=referral>`_
* `Concepts <https://kubernetes.io/docs/concepts/>`_

安装
----

所有机器
^^^^^^^^

.. code-block:: bash

    #!/bin/bash

    if [ $# != 1 ]; then
        echo '参数错误'
        exit 1
    fi

    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

    hostnamectl set-hostname $1

    echo -e '192.168.56.21 master\n192.168.56.22 worker1\n192.168.56.23 worker2' >> /etc/hosts

    setenforce 0
    sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

    swapoff -a
    sed -i -e '/swap/{s/^/#/}' /etc/fstab

    systemctl stop firewalld
    systemctl disable firewalld

    mkdir /etc/yum.repos.d/bak && mv /etc/yum.repos.d/CentOS* /etc/yum.repos.d/bak
    
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

    cat > /etc/yum.repos.d/docker.repo <<EOF
    [docker-ce-stable]
    name=Docker CE Stable - \$basearch
    baseurl=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/7/\$basearch/stable
    enabled=1
    gpgcheck=1
    gpgkey=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/gpg
    EOF

    cat > /etc/yum.repos.d/kubernetes.repo <<EOF 
    [kubernetes]
    name=Kubernetes
    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
    EOF

    yum install -y docker-ce kubelet kubeadm kubectl chrony net-tools vim

    systemctl enable kubelet && systemctl start kubelet
    systemctl start chronyd && systemctl enable chronyd

    mkdir /etc/docker
    cat > /etc/docker/daemon.json <<EOF 
    {
        "insecure-registries": ["192.168.56.20:8018"]
    }
    EOF
    systemctl enable docker && systemctl start docker

    docker pull 192.168.56.20:8018/kube-apiserver:v1.12.1 && \
    docker pull 192.168.56.20:8018/kube-controller-manager:v1.12.1 && \
    docker pull 192.168.56.20:8018/kube-scheduler:v1.12.1 && \
    docker pull 192.168.56.20:8018/kube-proxy:v1.12.1 && \
    docker pull 192.168.56.20:8018/pause:3.1 && \
    docker pull 192.168.56.20:8018/etcd:3.2.24 && \
    docker pull 192.168.56.20:8018/coredns:1.2.2

    docker tag 192.168.56.20:8018/kube-apiserver:v1.12.1 k8s.gcr.io/kube-apiserver:v1.12.1 && \
    docker tag 192.168.56.20:8018/kube-controller-manager:v1.12.1 k8s.gcr.io/kube-controller-manager:v1.12.1 && \
    docker tag 192.168.56.20:8018/kube-scheduler:v1.12.1 k8s.gcr.io/kube-scheduler:v1.12.1 && \
    docker tag 192.168.56.20:8018/kube-proxy:v1.12.1 k8s.gcr.io/kube-proxy:v1.12.1 && \
    docker tag 192.168.56.20:8018/pause:3.1 k8s.gcr.io/pause:3.1 && \
    docker tag 192.168.56.20:8018/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24 && \
    docker tag 192.168.56.20:8018/coredns:1.2.2 k8s.gcr.io/coredns:1.2.2

master
^^^^^^

.. note::

    安装flannel，必须在init的时候指定--pod-network-cidr=10.244.0.0/16。

.. code-block:: bash
    
    kubeadm init --pod-network-cidr=10.244.0.0/16
    export KUBECONFIG=/etc/kubernetes/admin.conf
    echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
    
worker
^^^^^^

.. code-block:: bash

    kubeadm join master:6443 --token xxx --discovery-token-ca-cert-hash xxx

删除节点
^^^^^^^^

.. note::
    
    删除节点之后，可以重新kubectl init或kubectl join。

.. code-block:: bash

    kubectl drain master --delete-local-data --force --ignore-daemonsets
    kubectl delete node master
    kubeadm reset

部署应用
^^^^^^^^

语法

.. code-block:: bash

    kubectl run NAME --image=image [--env="key=value"] [--port=port] [--replicas=replicas] [--dry-run=bool] [--overrides=inline-json] [--command] -- [COMMAND] [args...]
    kubectl get [(-o|--output=)json|yaml|wide|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...] (TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags]
    kubectl expose (-f FILENAME | TYPE NAME) [--port=port] [--protocol=TCP|UDP|SCTP] [--target-port=number-or-name] [--name=name] [--external-ip=external-ip-of-service] [--type=type]
    kubectl delete ([-f FILENAME] | TYPE [(NAME | -l label | --all)])
    kubectl scale [--resource-version=version] [--current-replicas=count] --replicas=COUNT (-f FILENAME | TYPE NAME)

实例

.. code-block:: bash

    kubectl run hello --image jocatalin/kubernetes-bootcamp:v1 --replicas 1 --labels 'app=hello'

    kubectl get

    kubectl describe
    
    kubectl delete

    kubectl logs $POD_NAME

    kubectl exec -it $POD_NAME bash

    kubectl scale deployments hello --replicas=4

    kubectl expose deploy hello --port 8080 --name=hello-svc

