# initialise fan and button control
curl https://raw.githubusercontent.com/gwylanscheeren/argonone_dietpi/master/argon1.sh | bash

# generate Mosquitto password and make configuration file:
mosquitto_passwd -c /etc/mosquitto/pwfile gwylan

mqttfile=/etc/mosquitto/conf.d/mosquitto.conf
sudo touch $mqttfile
sudo chmod 666 $mqttfile
echo 'allow_anonymous false' >> $mqttfile
echo 'password_file /etc/mosquitto/pwfile' >> $mqttfile

# add to home Assistant configuration file:
hafile=/home/homeassistant/.homeassistant/configuration.yaml
printf '\n' >> $hafile
echo 'mqtt:' >> $hafile
echo '  broker: localhost' >> $hafile
echo '  username: !secret mqtt_user' >> $hafile
echo '  password: !secret mqtt_pass' >> $hafile
echo '  discovery: true' >> $hafile
echo '  discovery_prefix: homeassistant' >> $hafile

# add to home Assistant secrets file:
secretsfile=/home/homeassistant/.homeassistant/secrets.yaml
sudo touch $secretsfile
sudo chmod 666 $secretsfile
printf '\n' >> $secretsfile
echo 'mqtt_user: gwylan' >> $secretsfile
echo 'mqtt_pass: XmhfesM7' >> $secretsfile

# download esphome files
espdir=/home/esphome/
mkdir -p $espdir && cd $espdir

gitsource=https://raw.githubusercontent.com/gwylanscheeren/Home-Automation/master/esphome/
wget "$gitsource"bathroom_pk.yaml &&
wget "$gitsource"boochcontrol.yaml &&
wget "$gitsource"kitchen.yaml &&
wget "$gitsource"testquin.yaml
