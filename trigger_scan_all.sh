# This script will iterate through all of your current environments and trigger 
# an immediate scan.  Modifications can made to trigger updates to each environment.

# To run this script, you will need curl and jq. Your Fugue CLIENT_ID and CLIENT_SECRET 
# should be stored as environment variables. 


curl https://api.riskmanager.fugue.co/v0/environments \
  -u $CLIENT_ID:$CLIENT_SECRET | jq -r '.items[].id' >> scanlist.txt
file=scanlist.txt

while read -r line; do
   curl -X POST https://api.riskmanager.fugue.co/v0/scans?environment_id=$line \
   -u $CLIENT_ID:$CLIENT_SECRET | jq '.'
done < "$file"

rm scanlist.txt 