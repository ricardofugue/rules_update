# rules_update
Custom rule update pipeline.  

Using OPA, Fugue gives customers the ability to write custom rules to check for violations in their cloud environments.  As more and more companies adopt a standard practice of using infrastructure as code, they also codify their policies.  

What we've done is use a simple example of a customer that needs to update an approved whitelist of Amazon Machine Images (AMIs).  
Here is the policy as code that we are using:
```# AWS.EC2.Instance
# All EC2 instances must use an approved AMI. Replace the AMI ID below with your AMI ID.

approved_amis = {
  'ami-04b762b4289fba92b'
}

allow {
    ami = input.ami  # Pull out AMIs
    approved_amis[ami]  # Assert
}```

This code tells Fugue to inspect all of the deployed AMIs and to flag the AMIs that are not on the approved whitelist.  The customer can then see to it that all AMIs that are in violation are redeployed.

# Process

For this pipeline we are using `AWS Codebuild` to run the actions and `AWS CodePipeline` to manage the end to end process and trigger the Codebuild actions.

When a new AMI is to be added to the whitelist, the developers or operations team members submit a new pull request with the modified AMIs listed in the `approved amis` section of the code.  Once the changes are merged into the master branch, the change triggers the pipeline to begin.  The pipeline then initiates the call to the Fugue rules API to update the list of new ami's and the Fugue visualizer will now highlight all of the EC2 instances deployed that are using an incorrect AMI.  The Fugue compliance report will also indicate the resource IDs of any deployed instance that does not have an approved AMI.

 






