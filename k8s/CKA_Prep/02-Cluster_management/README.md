# K8s Management Overview
- Introduction to High Availability
- Introducing K8s Management Tools
- Safely Draining a K8s Node
- Upgrading K8s with kubeadm
- Backing Up and restoring etcd Cluster Data

## High Availability in K8s
K8s facilitates high-availability applications, but you can also design the cluster itself ot be highly available.

To do this, you need multiple control plane nodes.

## K8s Management tools
There is a variety of **management tools** available for kubernetes.
These tools interface with Kubernetes to provide additional functionality.
When using kubernetes it is a good idea to be aware of some of these tools

### **kubectl**
**kubectl** is the official command line interface for Kubernetes. It is the main method you will use to work with Kubernetes in this course.

### **kubeadm**
We have already used **kubeadm**, which is a tool for quickly and easily creating Kubernetes clusters.

### **Minikube**
**Minikube** allows you to automatically set up a local single-node Kubernetes cluster. It is great for getting Kubernetes up and running quickly for development purposes.

### **Helm**
**Heml** provides templating and package management for Kubernetes objects. You can use it to manage your own templates (known as charts). You can also download and use shared templates.

### **Kompose**
**Kompose** helps you translate Docker compose files into Kubernetes objects. If you are using Docker compose for some part of your workflow, you can move your application to Kubernetes easily with Kompose.

### **Kustomize**
**Kustomize** is a configuration management tool for managing Kubernetes objects configurations. It allows you to share and re-use templated configurations for Kubernetes applications.

## Safely Draining a K8s Node

1. ### What is Draining
When performing maintanance, you may sometimes need to remove a Kubernetes node from service.

To do this, you can **drain** the node. Containers running on the node will be gracefully terminated (and potentially rescheduled on another node).

To drain a node, use the **kubectl drain** command.
```
kubectl drain <node name>
```

* #### Ingoring DaemonSets
    When draining a node, you may need to ignore DaemonSets (pods that are tied to each node). If you have any DaemonSet pods running on the node, you will likely need to use the **--ignore-daemonsets** flag
    ```
    kubectl drain <node name> --ignore-daemonsets
    ```

* #### Uncordoning a Node
    If the node remains part of the cluster, you allow pods to run to the node again when maintenance is complete using the **kubectl uncordon** command.
    ```
    kubectl uncordon <node name>
    ```
    