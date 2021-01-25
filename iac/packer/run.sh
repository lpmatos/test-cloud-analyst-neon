INSTANCE_TYPE="${VARIABLE:-apache}"

if [[ "$INSTANCE_TYPE" == "apache" ]]; then
  packer inspect -var-file=./variables.json ./apache.json
  packer validate -var-file=./variables.json ./apache.json
  packer build -var-file=./variables.json ./apache.json
else
  packer inspect -var-file=./variables.json ./iis.json
  packer validate -var-file=./variables.json ./iis.json
  packer build -var-file=./variables.json ./iis.json
fi
