# Deployment
A K8s object that defines a **desired state** for a ReplicaSet (a set of replica Pods). \
The Deployment Controller seeks to maintain the desired state by creating, deleting, and \
replacing Pods with new configurations.

## A Deployment's Desired State Icludes...
1. **replicas**

The number of replica Pods the Deployment will seek to maintain

2. **selector**

A label selector used to identity the replica Pods managed by the Deployment.

3. **template**

A template Pod definition used to create replica Pods

## Use Cases
There are many use cases for Deployments, such as:

- Easily scale an application up or down by changing the number of replicas.
- Perform rolling updates to deploy a new software version.
- Roll back to a previous software version.

# What is Scaling?
**Scaling** refers to dedicating more (or fewer) resources to an application in order to \
meet changing needs.

K8s Deployments are very useful in **horizontal scaling**, which involves changing the \
number of containers running an application.

## Deployment Scaling
The Deployment's **replicas** setting determines how many replicas are desired in its desired state. \
If the **replicas** number is changed, replica Pods will be created or deleted to satisfy the new number.

### How to Scale a Deploymenrt?
1. Edit YAML

You can scale a deployment simply by \
changing the number of **replicas** in \
the YAML descriptor with **kubectl apply** \
or **kubectl edit**
```yaml
...
spec:
    replicas: 5

...
```

2. kubectl scale

Or use the special **kubectl scale** command
```yaml
kubectl scale deployment.v1.apps/my-deployment --replicas=5
```


# Managing Rolling Updates with Deployments

## Rolling Update
**Rolling updates** allow you to make changes to a Deployment's Pods at a  controlled rate, \
gradually replacing old Pods with new Pods. This allows you to update your Pods without incurring \
downtime.

## Rollback
If an update to a deployment causes a problem, you can **roll back** the deployment to a previous \
working state.

### Ways of doing a rolling update
```yaml
1. kubectl edit deployment my-deployment
2. kubectl set image deployment my-deployment nginx=nginx:1.19.1
```


- To see what happens with rolling update
```yaml
kubectl rollout status deployment.v1.apps/my-deployment
```

- Use **--record** to record the deployments
```yaml
kubectl set image deployment my-deployment nginx=nginx:1.19.3 --record
```

- To check the history info, run the below:
```yaml
kubectl rollout history deployment my-deployment
```

- Performing a Roll back
```yaml
kubectl rollout undo deployment my-deployment --to-revision=1
```