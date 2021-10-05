# Working with kubectl
## What is kubectl?
1. kubectl get
2. kubectl describe
3. kubectl create
4. kubectl apply
5. kubectl delete
6. kubectl exec


## What is kubectl?
**kubectl** is a command line tool that allows you to interact with Kubernetes.
kubectl uses the Kubernetes API to communicate with cluster and carry out your commands.

"You can use kubectl to deploy applications, inspect and manage cluster resource, and view logs."

1. ## kubectl get
Use *kubectl get* to list object in the Kubernetes cluster.
```
kubectl get <object type> <object name> -o 
<output> --sort-by <JSONPath> --selector 
<selector>
```

2. ## kubectl describe
You can get detailed information about Kubernetes objects using *kubectl describe*.
```
kubectl describe <object type> <object name>
```

3. ## kubectl create
Use *kubectl create* to create objects.

Supply a YAML file with -f to create an object from a YAML desciptor stored in the file.

***If you attempt to create an object that already exists, an error will occur.***
```
kubectl create -f <file name>
```

4. ## kubectl apply
*kubectl apply* is similar to kubectl create.
However, if you use *kubectl apply* on an object that already exists, it will modify the existing object, if possible
```
kubectl apply -f <file name>
```
5. ## kubectl delete
Use *kubectl delete* to delete objects from the cluster.
```
kubectl delete <object type> <object name>
```

6. ## kubectl exec
*kubectl exec* can be used to run commands inside containers. Keep in mind that, in order for a 
command to succeed, the necessary software must exist within the container to run it.

For pods with multiple container, specify the container name with **-c**
```
kubectl exec <pod name> -c <container name> -- <command>
```

# Kubectl Tips
1. Imperative Commands vs Declarative Commands
2. Quick Sample YAML
3. Record a Command
4. Use the Docs


1. ## Declarative
- Define obbject using data structure such as YANL or JSON.
    
## Imperative
- Define object using kubectl commands and flags. Some people find imperative commands faster.
```
kubectl create deployment my-deployment -- image=nginx
```

2. Qiuck Sample YAML
Use the *--dry-run* flag to run an imperative command without creating an object. Combine
it with *-o yaml* to quickly obtain a sample YAML file you can manipulate!

```
kubectl create deployment my-deploment --image-nginx --dry-run -o yaml
```

3. ## Record a Command 
Use the *--record* flag to record the command that was used to make a change
```
kubectl scale deployment my-deployment replicas=5 --record
```

4. ## Use the Docs
You can often find YAML examples in the Kubernetes documentation.
You are allowed to use this documentation during the exam.


# Managing K8s Role-Based Access Control (RBAC)
1. RBAC in K8s
2. RBAC Object


1. ## RBAC in K8s
Role-based access control (RBAC) in K8s allows you to control what users allowed to do and access within your cluster.

2. ## RBAC Objects
**Roles** and **ClusterRoles** are Kubernetes object that define a set of permissions. These permissions determines what 
users can do in the cluster.

A Roles defines permissions within a particular namespace, and a ClusterRole defines cluster-wide permissions not specific
to a single namespace.


**RoleBinding** and **ClusterRoleBinding** are objects that connect Roles and ClusterRoles to users.


# Service Account
1. What is a Service Account
2. Creating Service Account
3. Binding Roles to Service Accounts


1. ## What  is a Service Account?
In K7s, a **service account** is an account used by container processes within Pods to authenticate with the K8s API.

If your Pods need to communicate with the K8s API, you can use service accounts to control their access.

2. ## Creating Service Accounts
A service account object can be created with some YAML just like any other K8s object

```
apiVersion: v1
kind: ServiceAcount
metadata:
    name: my-serviceaccount
```

3. ## Binding Roles to Service Accounts
You can manage access control for service account, just like any other user, using ***RBAC*** objects.

Bind service accounts with ClusterRoles or ClusterRoleBindings to provide access to K7s API functionality.

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
    name: sa-pod-reader
subjects:
    - kind: ServiceAccount
      name: my-serviceaccount
      namespace: default
roleRef:
    kind: Role
    name: pod-reader
    apiGroup: rbac.authorization.k8s.io
```

# Inspecting Pod Resource Usage
1. Kubernetes Metrics Server
2. kubectl top


1. ## Kubernetes Metrics Server
In order to view metrics about the resource pods and containers are using, we need an add-on to collect 
and provide that data. One such add-on is **Kubernetes Metrics Server**.

2. ## kubectl top
With kubectl top, you can view data about resource usage in your pods and nodes.
kubectl top also supports flags like **--sort-by** and **--selector**

- kubectl apply -f https://raw.githubusercontent.com/linuxacademy/content-cka-resources/master/metrics-server-components.yaml
-  kubectl get --raw /apis/metrics.k8s.io
```
kubectl top pods
kubectl top pods --sort-by cpu  
kubectl top pods --sort-by memory
kubectl top pod --selector app=metrics-test
kubectl top node
kubectl top pod --sort-by <JSONPATH> --selector <selector>
```