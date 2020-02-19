#Updates the rule ID listed below.  The rule ID must be entered or stored as 
#an environment variable in the build project.

curl -X PATCH \
"https://api.riskmanager.fugue.co/v0/rules/12697c3a-ddce-44fd-8ce4-484b7f17860a" \
  -u $CLIENT_ID:$CLIENT_SECRET \
  -H "Content-Type: application/json" \
  -d @custom_rule.json
