#!/bin/bash

if [ $# != 1 ]; then
    echo '参数错误'
    exit 1
fi


### config yum source

mkdir -p /etc/yum.repos.d/bak && mv -f /etc/yum.repos.d/* /etc/yum.repos.d/bak

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


### config time

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yum install -y chrony
systemctl start chronyd && systemctl enable chronyd


### config hostname and hosts

hostnamectl set-hostname $1
echo -e '192.168.56.21 master\n192.168.56.22 node1\n192.168.56.23 node2' >> /etc/hosts


### some system config

setenforce 0
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

swapoff -a
sed -i -e '/swap/{s/^/#/}' /etc/fstab

systemctl stop firewalld
systemctl disable firewalld


### config net.bridge.bridge-nf-call-iptables

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system


### install docker-ce kubelet kubeadm kubectl

yum install -y docker-ce-18.06.1.ce kubelet kubeadm kubectl

systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet


### pull images

docker pull registry.cn-hangzhou.aliyuncs.com/pecid/kube-apiserver:v1.12.2 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/kube-controller-manager:v1.12.2 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/kube-scheduler:v1.12.2 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/kube-proxy:v1.12.2 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/pause:3.1 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/etcd:3.2.24 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/coredns:1.2.2 && \
docker pull registry.cn-hangzhou.aliyuncs.com/pecid/flannel:v0.10.0-amd64

docker tag registry.cn-hangzhou.aliyuncs.com/pecid/kube-apiserver:v1.12.2                     k8s.gcr.io/kube-apiserver:v1.12.2 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/kube-controller-manager:v1.12.2            k8s.gcr.io/kube-controller-manager:v1.12.2 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/kube-scheduler:v1.12.2                     k8s.gcr.io/kube-scheduler:v1.12.2 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/kube-proxy:v1.12.2                         k8s.gcr.io/kube-proxy:v1.12.2 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/pause:3.1                                  k8s.gcr.io/pause:3.1 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/etcd:3.2.24                                k8s.gcr.io/etcd:3.2.24 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/coredns:1.2.2                              k8s.gcr.io/coredns:1.2.2 && \
docker tag registry.cn-hangzhou.aliyuncs.com/pecid/flannel:v0.10.0-amd64                      quay.io/coreos/flannel:v0.10.0-amd64