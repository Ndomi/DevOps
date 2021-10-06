# Managing Application Configuration

## Application Configuration
When you are running appliications in Kubernetes, you may want to pass dynamic values to your \
applications at runtime to control how they behave. This is known as **application configuration**.

## ConfigMaps
You can store configuration data in Kubernetes using **ConfigMaps**. \
ConfigMaps store data in the form of a key-value map. ConfigMap data \
can be passed to your container applications.

```
apiVersion: v1
kind: ConfigMap
metadata:
    name: my-configmap
data:
    key1: value1
    key2: value2
    key3:
        subkey:
            morekeys: data
            evenmore: some more data
    key4: |
        You can also do 
        multi-line 
        data.                    
```

## Secrets
**Secrets** are similar to ConfigMaps but are \
designed to store sensitive data, such as passwords \
or API keys, more securely. They are created and used \
similarly to ConfigMaps
```
echo -n 'secret' | base64
echo -n 'anothersecret' | base64
```

```
apiVersion: v1
kind: Secret
metadata:
    name: my-secret
type: Opaque
data:
    username: user
    password: mypass
```

## Environment Variables
You can pass ConfigMap and Secret data to your containers as \
**environment variables**. These variables will be visible \
to your container process at runtime.

```
spec:
    containers:
    -
        ...
        env:
        - name: ENVVAR
          valueFrom:
            configMapKeyRef:
                name: my-configmap
                key: mykey
```

## Configuration Volumes
Configuration data from ConfigMaps and Secret can also be passed \
to containers in the form of **mounted volumes**. This will cause the \
configuration data to appear in files available to container \
file system.

Each top-level key in the configuration data \
will appear as a file containing all keys below that \
top-level key.
```
...
volumes:
- name: secret-vol
  secret:
    secretName: my-secret
```

# Managing Container Resources
**Resource requests** allow you to define an amount of resources (such as CPU or \
memory) you expect a container to use. The Kubernetes scheduler will use resource \
requests to avoid scheduling pods on nodes that do not have enough available resources.

**Tip:** Containers are allowed to use more (or less) than the requested resources. \
Resource requests only affect scheduling.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: my-pod
spec:
    containers:
    - name: busybox
      image: busybox
      resources:
          requests: 
            cpu: "250m"
            memory: "128Mi"
```

## Resource Limits
**Resource Limits** provide a way for you to \
limit the amount of resources your \
containers can use. The container runtime is \
responsible for enforcing these limits, and \
different container runtimes do this differently.

**Tip:** Some runtimes will enforce these limits \
by terminating container processes that attempt to \
more than the allowed amount of resources.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: my-pod
spec:
    containers:
    - name: busybox
      image: busybox
      resources:
          limits:
            cpu: "250m"
            memory: "128Mi"
```

# Monitoring Container Health with Probes

## Container Health
K8s provides a number of features that allow you to build robust solutions, such \
as the ability to automatically restart unhealthy containers. To make the most of \
features, K8s needs to be able to accurately determine the status of your applications. \
This means actively monitoring **container health**.

### Liveness Probes
**Liveness probes** allow you to automatically determine whether or not a container \
application is in a healthy state.

By default, K8s will only consider a container to be "down" if the container process stops.

Liveness probes allow you to customize this detection mechanism and make it more sophisticated.


### Startup Probes
**Startup probes** are very similar to liveness probes. However, while probes run contantly \
on a schedule, startup probes run at container startup and stop running once they succeed.

They are used to determine when the application has successfully started up. Startup probes \
are especially useful for legacy applications that can have long startup times.

### Readiness Probe
**Readiness probes** are used to determine when a container is ready to accept requests. \
When you have a service backend by multiple container endpoints, user traffic will not be \
sent to a particular pod until its containers have all passed the readiness checks defined \
by their readiness probes.

Use readiness probes to prevent user traffic from being sent to pods that are still in the \
prcess of starting up.

# Building Self-Healing Pods with Restart Policies

## Restart Policies
k8s can automatically restart containers when they fail. **Restart policies** allow you \
to customize this behavior by defining when you want a pod's containers to be automatically \
restarted

Restart policies are an important component of self-healing applications, which are \
automatically repaired when a problem arises

## Always
**Always** is the default restart policy in K8s. With this policy, containers will always \
be restarted if they stop, even if they completed successfully. Use this policy for applications \
that should always be running.

## OnFailure
The **OnFailure** restart policy will restart containers only if the container process exits with an \
error code or the container is determined to be unhealthy by a liveness probe. Use this policy for \
applications that need to run successfully and then stop.

## Never
The **Never** restart policy will cause the pod's containers to never be restarted, even if the \
container exists or a liveness probe fails. Use this for applications that should run once and \
never be automatically restarted.

# Multi-Container Pods
A Kubernetes Pod can have one or more containers. A Pod with more than one container is a \
**multi-container Pod**

In a multi-container Pod, the containers share resources such as network and storage. They \
can interact with one another, working together to provide functionality.

**Best practice:** Keep containers in separate Pods unless they need to share resources.

## Cross-Container Interaction
Containers sharing the same Pod can interact with one another using shared resources.

### Network
Containers share the same networking namespace and can communicate with one another on any \
port, even if that port is not exposed to the cluster.

### Storage
Containers can use volumes to share data in Pod.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: multi-container-pod
spec:
    containers:
        - name: nginx
          image: nginx
        - name: redis
          image: redis
        - name: couchbase
          image: couchbase
```

## Init Containers
**Init containers** are containers that run once during the startup process of a pod. A pod can \
have any number of init containers, and they will each run once (in order) to completion.

You can use init containers to perform a variety of startup tassks. They can contain and use \
software and setup scripts that are not needed by your main containers.

They are often useful in keeping your main containers lighter and more secure by offloading \
tasks to a separate container.

### Use Cases for init Containers
Some sample use cases for init containers:
1. Cause a pod to wait for another K8s resource to be created before finishing startup.
2. Perform sensitive startup steps securely outside of app containers.
3. Populate data into a shared volume at startup.
4. Communicate with another service at startup