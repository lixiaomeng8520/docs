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
  
官方实例

* `Pull an Image from a Private Registry <https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/>`_
* `Tools for Monitoring Resources <https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/>`_

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
* `Force pods to re-pull an image without changing the image tag <https://github.com/kubernetes/kubernetes/issues/33664>`_
* `10 Most Common Reasons Kubernetes Deployments Fail  <https://kukulinski.com/10-most-common-reasons-kubernetes-deployments-fail-part-2/#10containerimagenotupdating>`_
* `以Kubeadm方式安装的Kubernetes集群的探索 <https://tonybai.com/2017/01/24/explore-kubernetes-cluster-installed-by-kubeadm/>`_
* `使用Filebeat收集Kubernetes的应用日志 <https://www.kubernetes.org.cn/2011.html>`_
* `How To Setup Prometheus Monitoring On Kubernetes Cluster <https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/>`_
* `Get Kubernetes Cluster Metrics with Prometheus in 5 Minutes <https://akomljen.com/get-kubernetes-cluster-metrics-with-prometheus-in-5-minutes/>`_
* `DCOS之k8s的容器监测探针 <https://blog.csdn.net/zouyee/article/details/50755608>`_

安装
----

所有机器
^^^^^^^^

`安装脚本 <https://raw.githubusercontent.com/lixiaomeng8520/docs/master/source/script/k8s-install.sh>`_

master
^^^^^^

.. note::

    安装flannel，必须在init的时候指定 --pod-network-cidr=10.244.0.0/16。

    注意安装版本号，默认会联网查找最新版本，也可指定版本 --kubernetes-version=v1.12.2。

    当有多网卡的时候，注意指定ip --apiserver-advertise-address=192.168.56.20。

.. code-block:: bash
    
    kubeadm init --pod-network-cidr=10.244.0.0/16
    #export KUBECONFIG=/etc/kubernetes/admin.conf
    #echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
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

NOTE
----

1. 重新用上一个tag部署会导致无效，可以set env来强制重新部署。
   
.. code-block:: bash

    kubectl set env deploy nginx DEPLOY_DATE="$(date)"

2. livenessProbe 和 readinessProbe
   
livenessProbe代表running, pending, terminating等状态

readinessProbe代表 1/3 pod内容器的就绪状态

当``apply``或者``set env``来重新部署时，会先添加一个po，再删减一个po。删减的时机是当所有容器都处于就绪状态才会触发。所以可以进行就绪性检测，当网站可访问时（返回200等），才处于就绪状态，进而开始删减，这样可以保证业务不间断，不会因为老po太早删减而新po服务还未启动使得服务有一段时间不可访问。
