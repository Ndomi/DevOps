```Create a cluster using eksctl```

eksctl create cluster --name eksctl-test --nodegroup-name ng-default --node-type t3.micro --nodes 2


```Cleate Cluster using yaml```

eksctl create cluster --config-file=eksctl-create-cluster.yml