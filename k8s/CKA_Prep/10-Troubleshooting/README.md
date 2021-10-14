# K8s Troubleshooting Overview
1. Troubleshooting Your K8s Cluster
2. Checking Cluster and Node Logs
3. Troubleshooting Your Applications
4. Checking Container Logs
5. Troubleshooting K8s Networking Issues


1. Troubleshooting Your K8s Cluster
   ## Kube API Server
    If the **K8s API server is down**, you will not be able to use kubectl to interact with the cluster. \
    You may get a message that looks something like:

```yaml
$ kubectl get nodes
The connection to the server localhost:6443 was refused -
did you specify the right host or port?
```

Assuming your kubeconfig is set up correctly, this may mean the API server is down.

## Possible fixes:
Make sure the *docker* and *kubelet* services are up and running on your control plane node(s).

## Checking Node Status
**Check** the status of your nodes to see if any them are experiencing issues.

Use *kubectl describe node* to get more information on any nodes that are not in the **READY** state

```yaml
$ kubectl describe node node name
```

If a node is having problems, it may be because a **service** is down on that node.

Each node runs the *kubelet* and *container runtime* (i.e Docker) Services

### systemctl status
View the status of a service.
```yaml
systemctl status kubelet
```

### systemctl start
Start a stopped service
```yaml
systemctl start kubelet
```

### systemctl enable
Enable a service so it starts automatically on system startup.
```yaml
systemctl enable kubelet
```

## Checking System Pods
In a *kubeadm* cluster, several K8s components run as pods in the *kube-system* namespace.

Check the status of these components wiht *kubectl get pods* and *kubectl describe pod*.

```yaml
kubectl get pods -n kube-system
kubectl describe pod podname -n kube-system
```

# Checking Cluster and Node Logs
## Service Logs
You can check thelogs for K8s-related services on each node using *journalctl*.

```yaml
$ sudo journalctl -u kubelet
$ sudo journalctl -u docker
```

## Cluster Component Logs
The Kubernetes cluster components have log output redirected to */var/log*. For example:

```yaml
/var/log/kube-apiserver.log
/var/log/kube-scheduler.log
/var/log/kube-controller-manager.log
```

Note that these log files may not appear for kubeadm clusters, since some components \
run inside containers. In that case, you can access them with *kubectl logs*.


# Troubleshooting Your Applications
## Checking Pod Status
You can see a Pod's status wiht *kubectl get pod*.
```
$ kubectl get pods
```

Use *kubectl describe pod* to get more information about may be going on with an unhealthy Pod.
```
$ kubectl describe pod podname
```

## Running Commands Inside Containers
If you need to troubleshoot what is going on inside a container, you can execute \
commands within the container with *kubectl exec*

```
kubectl exec podname -c containername -- command
```

Note that you cannot use *kubectl exec* to run any software that is not present within the container.

# Checking Container Logs
K8s containers maintain **logs**, which you can use to gain insight into whta is going on within the container.

A container's log contains everything written to the standard output (stdout) and \
error (stderr) streams by the container process.

## kubectl logs
Use the **kubectl logs** command to view a container's logs.

```
kubectl logs podname -c containername
```

# Troubleshooting K8s Networking Issues
## Kube-proxy and DNS
In addition to checking on your K8s networking plugin, it may be a good idea to look at kube-proxy \
and the K8s DNS if you are experiencing issues within the K8s cluster network.

In a kubeadm cluster, the K8s DNS and kube-proxy run as Pods in the kube-system namespace.

## netshoot

**Tip:** You can run a container in the cluster that you can use commands to test and gather information \
about network functionality.

The *nicolaka/netshoot* image is a great tool for this. This image contains a variety \
of networking exploration and troubleshooting tools.

Create a container running this image, and then use *kubectl exec* to explore away!

073 064 6572

064 287 6157