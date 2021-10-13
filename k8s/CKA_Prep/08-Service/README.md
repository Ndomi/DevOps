# What is a Service
kubernetes **Services** provide a way to expose an application running as a set of Pods

They provide an abstract way for client to access application without needing to be aware \
of the application's Pods.

## Service Routing 
Clients make requestd to a Service, which **routes** traffic to its Pods in a load-balanced \
fashion.

## Endpints
**Endpoints** are the backend entities to which Services route traffic. For a Service that \
routes traffic to multiple Pods, each Pod will have an endpoint associated with the Service.

**Tip:** One way to determine which Pod(s) a Service is routing traffic to is to look at \
that service's Endpoints.

#### To view endpoints
```yaml
kubectl get endpoints svc-clusterip
```

## Service Types
Each Service has a type. The **Service type** determines how and where the Service will \
expose your application. There are four service types:
- ClusterIP
- NodePort
- LoadBalancer
- ExternalName (outside the scope of CKA)

## ClusterIP Services
**ClusterIP** Services expose applications **inside** the cluster network. Use them when \
your clients will be othe Pods within the cluster.

## NodePort Services
**NodePort** Services expose applications **outside** the cluster network. Use NodePort \
when applications or users will be acccessing your application from outside the cluster.

## LoadBalancer Service
**LoadBalancer** Services also expose applications **outside** the cluster network, but they \
use an **external cloud load balancer** to do so. This service type only works with cloud \
platforms that include load balancing functionality.

## Discovering K8s Service with DNS
The Kubernetes DNS (Domain Name System) assigns **DNS names** to Services, allowing application \
within the cluster to easily locate them

A service fully qualified domain name has the following format:
```yaml
service-name.namespace-name.svc.cluster-domain.example
```

The default cluster domain is **cluster.local**.

## Service DNS and Namespaces
A Service's fully qualified domain name can be used to reach the service from within **any Namespace** \
in the cluster.

```yaml
my-service.my-namespace.svc.cluster.local
```

However, Pods within the same Namespace can also simply use the service name.
```yaml
my-service
```

# Managing Access from Outside with K8s Ingrss

## What is an Ingress?
An **Ingress** is a Kubernetes object that manages external access ot Services in the cluster.

An Ingress is capable of providing more functionality tha a simple NodePort Service, such as SSL \
termination, advanced load balancing, or namebased virtual hosting

## Ingress Controllers
Ingress objects actually do nothing by themselves. In order for Ingresses to do anything, you must \
install one or more **Ingress controllers**.

There are variiety of Ingress Controllers available - all of which implement different methods for \
providing external access to you Services.


# Routing t a Service
Ingress define a set of **routing rules**. A routing rule' properties determines to which requests it \
applies.

Each rule has a set of **paths**, each with a **backend**. Requests matching a path will be routed to its \
associated backed.

In this eaxmple, a request to *http://<some-endpoint>/somepath* would be routed to port 80 on the \
*my-service* Service.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata: 
    name: my-ingress
spec:
    rules:
        - http:
            paths: 
                - path: /somepath
                  pathType: Prefix
                  backend: 
                      service:
                          name: my-service
                          port:
                              number: 80
```

## Routing to a Service with a Named Port
If a Service uses a **named port**, an Ingress can be also use the port's name to choose to which \
port it will route.

```yaml
apiVersion: v1
kind: Service
metadata:
    name: my-service
spec:
    selector:
        app: MyApp
    ports: 
        - name: web
          protocol: TCP
          port: 80
          targetPort: 8080
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: my-ingress
spec:
    rules:
        - http:
            paths:
                - path: /somepath
                  backend: 
                    service:
                        name: my-service
                        port: 
                            name: web
```