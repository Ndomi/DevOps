# What is scheduling

## Scheduling
The process of assigning Pods to Nodes so kubelets can run them.

## Scheduler
Control plane component that handles scheduling

# Scheduling Process
The kubernetes scheduler selects a suitable Node for each Pod. It takes into account \
things like:

- Resource requests vs. available node resource
- Various configurations that affect scheduling using node labels


### nodeSelector
You can configure a **nodeSelector** for your Pods to limit which Node(s) the Pod can be scheduled on.

Node selectors use node labels to filter suitable nodes

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: nginx
spec:
    containers:
    - name: nginx
      image: nginx
    nodeSelector: 
      mylabel: mvvalue
```

### nodeName
You can bypass scheduling and assign a Pod to a specific Node by name using **nodeName**

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: nginx
spec:
    containers:
    - name: nginx
      image: nginx
    nodeName: k8s-worker1
```

#### Create a labels in a node
```yaml
kubectl label nodes worker-1 special=true
```

# DaemonSets
Automatically runs a copy of a pod on each node.

DaemonSets will run a copy of the Pod on new nodes as they are added to cluster.

## DaemonSets and Scheduling
DaemonSets respect normal scheduling rules around node labels, taints, and tolerations. \
If a pod would not normally be scheduled on a node, a DaemonSet will not create copy of \
the Pod on that Node.

# Static Pod
A Pod that is managed directly by the kubelet on a node, not by the K8s API server. They \
can run even if even if there is no K8s API server present.

Kubelet automatically create static Pods from YAML manifest files located in the manifest \
path on the node.

# Mirror Pods
Kubelet will create a **mirror Pod** for each static Pod. Mirror Pods allow you to see the \
status of the static Pod via the K8s API, but you cannot change or manage them via the API.