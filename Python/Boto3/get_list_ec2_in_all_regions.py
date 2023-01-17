import boto3
import jmespath
import csv
import itertools

client = boto3.client('ec2')
all_regions = client.describe_regions()

RegionList = []
for r in all_regions['Regions']:
    RegionList.append(r['RegionName'])

myData=[]    
for r in RegionList:
    client = boto3.client('ec2', region_name = r)
    response = client.describe_instances()
    output = jmespath.search("Reservations[].Instances[].[NetworkInterfaces[0].OwnerId, InstanceId, InstanceType, State.Name, Placement.AvailabilityZone, PrivateIpAddress, PublicIpAddress, KeyName, [Tags[?Key=='Name'].Value] [0][0]]", response)
    myData.append(output)

# Write myData to CSV file with headers
output = list(itertools.chain(*myData))
with open("ec2-inventory-latest.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(['AccountID','InstanceID','Type','State','AZ','PrivateIP','PublicIP','KeyPair','Name'])
    writer.writerows(output)
    