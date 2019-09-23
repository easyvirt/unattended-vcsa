#!/bin/bash

VCSA_PATH="/mnt/vcsa/vcsa-cli-installer/lin64/"
VCSA_COMMAND="vcsa-deploy"
TEMPFILE=".json.tmp"

# Variables
VCSA_ESX_IP=$1
VCSA_IP=$2
VCSA_NAME=$3
DATASTORE=$4

PASSWORD="VMware1!"
VCSA_DNS="192.168.8.5"
VCSA_NETMASK="24"
VCSA_GATEWAY="192.168.8.1"
VCSA_DOMAIN="lan"

rm $TEMPFILE
echo "executing $iVCSA_PATH$VCSA_COMMAND..."

cp embedded_vCSA_on_ESXi.json $TEMPFILE

sed -i "s/<FQDN or IP address of the ESXi host on which to deploy the new appliance>/$VCSA_ESX_IP/g" $TEMPFILE
sed -i "s/<Password of the ESXi host root user. If left blank, or omitted, you will be prompted to enter it at the command console during template verification.>/$PASSWORD/g" $TEMPFILE

sed -i "s/<A specific ESXi host datastore, or a specific datastore in a datastore cluster.>/$DATASTORE/g" $TEMPFILE
sed -i "s/Embedded-vCenter-Server-Appliance/$VCSA_NAME/g" $TEMPFILE
sed -i "s/<Static IP address. Remove this if using dhcp.>/$VCSA_IP/g" $TEMPFILE
sed -i "s/<DNS Server IP Address. Remove this if using dhcp.>/$VCSA_DNS/g" $TEMPFILE
sed -i "s/<Network prefix length. Use only when the mode is 'static'. Remove if the mode is 'dhcp'. This is the number of bits set in the subnet mask; for instance, if the subnet mask is 255.255.255.0, there are 24 bits in the binary version of the subnet mask, so the prefix length is 24. If used, the values must be in the inclusive range of 0 to 32 for IPv4 and 0 to 128 for IPv6.>/$VCSA_NETMASK/g" $TEMPFILE
sed -i "s/<Gateway IP address. Remove this if using dhcp.>/$VCSA_GATEWAY/g" $TEMPFILE
sed -i "s/<FQDN or IP address for the appliance. Remove this if using dhcp.>/$VCSA_IP/g" $TEMPFILE
sed -i "s/<Appliance root password; refer to --template-help for password policy. If left blank, or omitted, you will be prompted to enter it at the command console during template verification.>/$PASSWORD/g" $TEMPFILE
sed -i "s/<vCenter Single Sign-On administrator password; refer to --template-help for password policy. If left blank, or omitted, you will be prompted to enter it at the command console during template verification.>/$PASSWORD/g" $TEMPFILE

$VCSA_PATH/$VCSA_COMMAND install --accept-eula --acknowledge-ceip --precheck-only $TEMPFILE
#$VCSA_PATH/$VCSA_COMMAND install --accept-eula --acknowledge-ceip $TEMPFILE
