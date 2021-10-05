# What is a Namespace?
- Namespaces are virtual clusters backed by the same physical cluster.
- Kubernetes objects, such as pods and containers, live in namespaces.
- Namespaces are a way to separate and organize objects in your cluster.

## Getting namespaces
```
kubectl get namespaces
```
### Get pods in a specific namespace
```
kubectl get pods --namespace kube-system
```
### Get pods in all namespaces
```
kubectl get pods --all-namespaces
```

## Create a namespace
```
kubectl create namespace my-namespace
```

**LAB Scenario**
- Create a new namespace called dev
- List the current namespaces
- Locate a pod with the name Quark and save the name of the pod's namespace to a file.

## Create the dev Namespace
1. Create a namespace in the cluster called dev:
```
kubectl create namespace dev
```

## Get a List of the Current Namespaces
1. List the current namespaces:
```
kubectl get namespace
```

2. Save the namespaces list to a file:
```
kubectl get namespace > /home/$USER/namespaces.txt
```

3. Verify the list saved to the file:
```
cat /home/$USER/namespaces.txt
```

## Find the quark Pod's Namespace
1. Locate the quark pod:
```
kubectl get pods --all-namespaces
```

2. Copy the name of the namespace where the quark pod is located.
3. Create a file in which to save its name: 
```
vi /home/$USER/quark-namespaces.txt
```
4. Paste in the name of the quark pod's namespace.
5. Save and exit the file by pressing Escape followed by :wq.