- We are first going to eplore to datasource and it outputs

Determine which Availability Zones support your instance type
```
aws ec2 describe-instance-type-offerings --location-type availability-zone --filters Name=instance-type,Values=t3.micro --region us-east-1 --output table
```