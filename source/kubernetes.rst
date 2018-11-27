Kubernetes
==========

官方文档

* `Setup <https://kubernetes.io/docs/setup/>`_
* `Concepts <https://kubernetes.io/docs/concepts/>`_
* `API <https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.12/>`_
* `kubectl-commands <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands>`_
* `Web UI (Dashboard) <https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/>`_
* `NGINX Ingress Controller <https://kubernetes.github.io/ingress-nginx/>`_
* `Kubernetes中文手册 <https://www.kubernetes.org.cn/docs>`_

第三方参考

* `Kubernetes Ingress实战(一)：在Kubernetes集群中部署NGINX Ingress Controller <https://blog.frognew.com/2018/06/kubernetes-ingress-1.html>`_
* `Setting up a Nginx Ingress with Kubernetes on bare-metal servers <http://blog.will3942.com/nginx-kubernetes-bare-metal>`_
* `Kubernetes指南 <https://kubernetes.feisky.xyz/>`_
* `Learn Kubernetes in Under 3 Hours: A Detailed Guide to Orchestrating Containers <https://medium.freecodecamp.org/learn-kubernetes-in-under-3-hours-a-detailed-guide-to-orchestrating-containers-114ff420e882>`_
* `三小时攻克 Kubernetes！ <https://mp.weixin.qq.com/s/gLbfwS89cpAkkoVMzJc6sQ>`_
* `kubeadm 部署 kube1.10 <https://blog.csdn.net/golduty2/article/details/80700491>`_
* `官方入门教程 <https://blog.csdn.net/kikajack/article/details/79866006>`_
* `十分钟带你理解Kubernetes核心概念 <http://www.dockone.io/article/932>`_
* `RKE快速上手指南：开源的轻量级K8S安装程序 <https://segmentfault.com/a/1190000012288926>`_
* `如何在Kubernetes中暴露服务访问 <https://segmentfault.com/a/1190000007990723>`_
* `Kubernetes核心概念总结 <https://www.cnblogs.com/zhenyuyaodidiao/p/6500720.html>`_
* `从零开始搭建Kubernetes集群（一、开篇） <https://www.jianshu.com/p/78a5afd0c597>`_
* `Kubernetes Nginx Ingress 教程 <https://mritd.me/2017/03/04/how-to-use-nginx-ingress/?utm_source=tuicool&utm_medium=referral>`_
* `kubernetes 1.12.1 Ingress-nginx 部署使用 <https://www.jianshu.com/p/e30b06906b77>`_
* `Kubernetes Ingress实战 <http://www.cnblogs.com/zhaojiankai/p/7896357.html>`_
* `Metallb – 贫苦 K8S 用户的负载均衡支持 <https://it.baiked.com/kubernetes/3215.html>`_
* `一篇讲透Kubernetes与GlusterFS之间的爱恨情仇（一） <http://rdc.hundsun.com/portal/article/826.html>`_
* `一篇讲透Kubernetes与GlusterFS之间的爱恨情仇（二） <http://rdc.hundsun.com/portal/article/827.html>`_

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
--------

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

对象类型
--------

NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND
bindings                                                                      true         Binding
componentstatuses                 cs                                          false        ComponentStatus
configmaps                        cm                                          true         ConfigMap
endpoints                         ep                                          true         Endpoints
events                            ev                                          true         Event
limitranges                       limits                                      true         LimitRange
namespaces                        ns                                          false        Namespace
nodes                             no                                          false        Node
persistentvolumeclaims            pvc                                         true         PersistentVolumeClaim
persistentvolumes                 pv                                          false        PersistentVolume
pods                              po                                          true         Pod
podtemplates                                                                  true         PodTemplate
replicationcontrollers            rc                                          true         ReplicationController
resourcequotas                    quota                                       true         ResourceQuota
secrets                                                                       true         Secret
serviceaccounts                   sa                                          true         ServiceAccount
services                          svc                                         true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io   false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io   false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io           false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io         false        APIService
controllerrevisions                            apps                           true         ControllerRevision
daemonsets                        ds           apps                           true         DaemonSet
deployments                       deploy       apps                           true         Deployment
replicasets                       rs           apps                           true         ReplicaSet
statefulsets                      sts          apps                           true         StatefulSet
tokenreviews                                   authentication.k8s.io          false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io           true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io           false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io           false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io           false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling                    true         HorizontalPodAutoscaler
cronjobs                          cj           batch                          true         CronJob
jobs                                           batch                          true         Job
certificatesigningrequests        csr          certificates.k8s.io            false        CertificateSigningRequest
leases                                         coordination.k8s.io            true         Lease
events                            ev           events.k8s.io                  true         Event
daemonsets                        ds           extensions                     true         DaemonSet
deployments                       deploy       extensions                     true         Deployment
ingresses                         ing          extensions                     true         Ingress
networkpolicies                   netpol       extensions                     true         NetworkPolicy
podsecuritypolicies               psp          extensions                     false        PodSecurityPolicy
replicasets                       rs           extensions                     true         ReplicaSet
networkpolicies                   netpol       networking.k8s.io              true         NetworkPolicy
poddisruptionbudgets              pdb          policy                         true         PodDisruptionBudget
podsecuritypolicies               psp          policy                         false        PodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io      false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io      false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io      true         RoleBinding
roles                                          rbac.authorization.k8s.io      true         Role
priorityclasses                   pc           scheduling.k8s.io              false        PriorityClass
storageclasses                    sc           storage.k8s.io                 false        StorageClass
volumeattachments                              storage.k8s.io                 false        VolumeAttachment

Ingress
-------

ingress
^^^^^^^

必须安装的资源

* namespace/ingress-nginx created
* configmap/nginx-configuration created
* serviceaccount/nginx-ingress-serviceaccount created
* clusterrole.rbac.authorization.k8s.io/nginx-ingress-clusterrole created
* role.rbac.authorization.k8s.io/nginx-ingress-role created
* rolebinding.rbac.authorization.k8s.io/nginx-ingress-role-nisa-binding created
* clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-clusterrole-nisa-binding created
* deployment.extensions/nginx-ingress-controller created

ingress本身需要对外，则默认用nodePort

* service/ingress-nginx
  
metalLB
  
* namespace/metallb-system created
* serviceaccount/controller created
* serviceaccount/speaker created
* clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
* clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
* role.rbac.authorization.k8s.io/config-watcher created
* clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
* clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
* rolebinding.rbac.authorization.k8s.io/config-watcher created
* daemonset.apps/speaker created
* deployment.apps/controller created

