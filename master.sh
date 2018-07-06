#!/bin/bash -v
swapoff -a
sed -i '/swap/d' /etc/fstab

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
curl -sSL https://get.docker.com/ | sh
systemctl start docker

kubeadm init --token=${k8stoken}

#kubectl apply -f https://git.io/weave-kube
