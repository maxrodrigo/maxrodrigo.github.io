---
title: My Home Raspberry Pi Kubernetes Cluster
---

https://itnext.io/building-your-home-raspberry-pi-kubernetes-cluster-14eeeb3c521e
https://wiki.alpinelinux.org/wiki/Classic_install_or_sys_mode_on_Raspberry_Pi
https://www.youtube.com/watch?v=jfUpF40--60
https://teada.net/k3s-on-alpine-linux/

Why ARM
Resources for nodes. More to CP or Node
ARGO vs Flux
benchmarks: https://www.reddit.com/r/kubernetes/comments/hi0qci/raspberry_pi_cluster_ep_5_benchmarking_the_turing/
Storage

## K3s

restar chrony, check date
curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="--disable=traefik --disable=servicelb" sh -s -

cat /var/lib/rancher/k3s/server/node-token

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.5:6443 K3S_TOKEN=K106a9b26bc044ed3e848ee45a8e78a2971d3ad61acfdd4ec7c101eb036a26cd7b9::server:1a20094dda48174be51d7278bb8e6b58 sh -

## Create the Kubernetes master

Optionally enable `PermitRootLogin yes` to the `/etc/ssh/sshd_config` file.

1. Install required packages.

    ```sh
    apk update
    apk add kubernetes docker cni-plugins kubelet kubeadm kubectl
    ```
1. Add services to the default runlevel and start

    ```sh
    rc-update add docker default
    rc-update add kubelet default
    service docker start
    kubeadm config images pull   # Get the necessary images
    ```
1. Generate a bootstrap token to authenticate nodes joining the cluster.

    ```sh
    TOKEN=$(kubeadm token generate)
    echo $TOKEN
    nc46pc.xv8mwxsbw9jswnsm
    ```

1. Initialize the Control Plane

    ```sh
    kubeadm init --token=${TOKEN} --pod-network-cidr=10.244.0.0/16
    ```

    If you see any `CGROUPS` related errors which stop the initialization process — you have missed one of the steps before.

    You can skip memory preflight warning appending `--ignore-preflight-errors=Mem` to the `kubeadm init`.

    Make a note of two things: first, the Kubernetes kubectl connection information has been written to /etc/kubernetes/admin.conf. This kubeconfig file can be copied to ~/.kube/config, either for root or a normal user on the master node or to a remote machine. This will allow you to control your cluster with the kubectl command.

    Second, the last line of the output starting with `kubeadm join` is a command you can run to join more nodes to the cluster.

1. Install a CNI add-on

    A CNI add-on handles configuration and cleanup of the pod networks. As mentioned, this exercise uses the Flannel CNI add-on. With the podCIDR value already set, you can just download the Flannel YAML and use kubectl apply to install it into the cluster. This can be done on one line using kubectl apply -f - to take the data from standard input. This will create the ClusterRoles, ServiceAccounts, and DaemonSets (etc.) necessary to manage the pod networking.

    ```sh
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    ```

1. Untaint the master node.

    ```sh
    kubectl taint nodes --all node-role.kubernetes.io/master-
    ```
