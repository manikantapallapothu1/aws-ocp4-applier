#!/bin/bash

# Install galaxy
ansible-galaxy install -r requirements.yml -p galaxy

# Grab cluster id
cluster_id=$(oc get machinesets -n openshift-machine-api -o jsonpath='{.items[0].metadata.labels.machine\.openshift\.io\/cluster-api-cluster}')

# Grab cloud region
cloud_region=$(oc get machinesets -n openshift-machine-api -o jsonpath='{.items[0].spec.template.spec.providerSpec.value.placement.region}')

#hard coding for the test

# Run applier

ansible-playbook -i .applier/ galaxy/openshift-applier/playbooks/openshift-cluster-seed.yml -e clusterid=${cluster_id} -e cloudregion=${cloud_region} -e role="infra" -e amiid="ami-0bc59aaa7363b805d" -e machinetype="m5.xlarge" -e include_tags="machinesets" -vvv

#ansible-playbook -i .applier/ galaxy/openshift-applier/playbooks/openshift-cluster-seed.yml -e clusterid=${cluster_id} -e cloudregion=${cloud_region} -e role="worker" -e amiid="ami-0bc59aaa7363b805d" -e include_tags="autoscaling" -vvv


