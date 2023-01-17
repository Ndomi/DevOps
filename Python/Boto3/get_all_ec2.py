import boto3
from pprint import pprint
import csv

client = boto3.client('ec2')

response = client.describe_regions()['Regions']


RegionList=[]
for i in response:
    RegionList.append(i['RegionName'])
    
write_file=open('ec2_inventory.csv','w', newline='')
data_obj=csv.writer(write_file)
data_obj.writerow(['REGION', 'INSTANCE_ID', 'INSTANCE_TYPE', 'PRIVATE_IP_ADDR', 'PUBLIC_IP_ADDR'])


instanceList=[]
for i in RegionList:
    # client = boto3.client('ec2')
    ec2_resource = boto3.resource(service_name='ec2', region_name=i)
    
    for r in ec2_resource.instances.all():
        data_ob = r.instance_id
        # data_ob
        
        instance = ec2_resource.Instance(data_ob)
        if instance.state['Name'] == 'running':
            data_obj.writerow([i, r.instance_id, r.instance_type, r.private_ip_address, r.public_ip_address])
        
        if i != 'us-east-1':
            ec2_terminate = ec2_resource.instances.terminate(
                InstanceIds=[data_ob,],
            )
