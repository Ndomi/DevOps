import boto3
import jmespath
import csv

aws_resource = boto3.client("ec2")
response = aws_resource.describe_instances()

myData = jmespath.search("Reservations[].Instances[].[NetworkInterfaces[0].OwnerId, InstanceId, InstanceType, State.Name, Placement.AvailabilityZone, PrivateIpAddress, PublicIpAddress, KeyName, [Tags[?Key=='Name'].Value] [0][0]]", response)

myFile = open('inventory.csv', 'w')
with myFile:
    writer = csv.writer(myFile)
    writer.writerows(myData)

print(myData)