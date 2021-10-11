# Deployment of Prometheus on Kubernetes

- First, we will create a Kubernetes namespace for all our monitoring components.

- We should create a config map with all the Prometheus scrape config, \
  which will be mounted to the Prometheus container in */etc/prometheus* \
  as *prometheus.yaml* file.

- Create PV and PVC for Prometheus persistent volume

- Create a file named prometheus-deployment.yaml and copy the following contents onto the file. \
  In this configuration, we are mounting the Prometheus config map as a file inside **/etc/prometheus**. \
  It uses the official Prometheus image from the docker hub.

- To access the Prometheus dashboard over an IP or a DNS name, you need to expose it as Kubernetes \
  service with NodePort or a Load Balancer.

# Setting up Grafana for Viewing Metrics
Grafana is an open platform for beautiful analytics and monitoring. Prometheus has a basic expression \
browser for debugging purpose but to have a good-looking dashboard, use Grafana. Grafana has a data \
source ready to query Prometheus.

Using Grafana you can create dashboards from Prometheus metrics to monitor the Kubernetes cluster.


- Creating ConfigMap for Grafana which consist of configuration information about data source \
  Prometheus. If you have more data sources, you can add more data sources with different YAMLs \
  under the data section.