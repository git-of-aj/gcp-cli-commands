#! /bin/bash

set -e



gcloud config set  compute/zone us-central1-a
gcloud config set  compute/region us-central1

cat<<EOF>mangu.sh

#! /bin/bash

sudo apt-get install nginx-light -y
sed -i 's/Welcome to nginx!/Welcome to the blue server!/g' /var/www/html/index.nginx-debian.html

EOF


gcloud compute instances create blue \
  --tags web-server \
  --metadata-from-file=startup-script=mangu.sh

sed -i 's/blue/green/g' mangu.sh

gcloud compute instances create green \
  --tags web-server \
  --metadata-from-file=startup-script=mangu.sh



gcloud compute firewall-rules create allow-http-web-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=icmp,tcp:22 --source-ranges=0.0.0.0/0 --target-tags web-server \



gcloud compute instances create test-vm --machine-type=f1-micro --subnet=default --zone=us-central1-a

echo -e "now start from Create a service account " 
