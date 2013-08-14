HD_USR="shd"
HD_PWD="shd"
HD_HOME_DIR="/home/$HD_USR/"
EXPERIMENT="sincere-cloudera"
DOMAIN="$EXPERIMENT.dsl.emulab.net"
JDK="jdk1.7.0_17"
JDK_TAR="/users/blublud/works/hadoop/cluster_setup/jdk-7u17-linux-i586.gz"
HADOOP="hadoop-1.2.1"
HADOOP_TAR="/users/blublud/works/hadoop/cluster_setup/hadoop-1.2.1-bin.tar.gz"
CONF_PATH="/users/blublud/works/hadoop/cluster_setup/conf/*"
SSH_KEY_DIR="/users/blublud/works/hadoop/cluster_setup/ssh/"
OTHER_LIBS="/proj/DSL/cloudera/apts/libc6/l*.deb"

sudo useradd -m -d $HD_HOME_DIR -s /bin/bash $HD_USR
echo ${HD_USR}:${HD_PWD} | sudo chpasswd

echo $HD_PWD | sudo -u $HD_USR -S mkdir $HD_HOME_DIR/.ssh
echo $HD_PWD | sudo -u $HD_USR -S chmod 700 $HD_HOME_DIR/.ssh
echo $HD_PWD | sudo -u $HD_USR -S sh -c "cat $SSH_KEY_DIR/id_rsa > $HD_HOME_DIR/.ssh/id_rsa"
echo $HD_PWD | sudo -u $HD_USR -S chmod 700 $HD_HOME_DIR/.ssh/id_rsa
echo $HD_PWD | sudo -u $HD_USR -S sh -c "cat $SSH_KEY_DIR/id_rsa.pub >> $HD_HOME_DIR/.ssh/authorized_keys"

echo $HD_PWD | sudo -u $HD_USR -S sh -c "echo 'Host *.$DOMAIN' > $HD_HOME_DIR/.ssh/config"
echo $HD_PWD | sudo -u $HD_USR -S sh -c "echo '\tStrictHostKeyChecking no' >> $HD_HOME_DIR/.ssh/config"
echo $HD_PWD | sudo -u $HD_USR -S sh -c "echo '\tUserKnownHostsFile=/def/null' >> $HD_HOME_DIR/.ssh/config"

echo $HD_PWD | sudo -u $HD_USR -S tar -xzvf $JDK_TAR -C $HD_HOME_DIR
echo $HD_PWD | sudo -u $HD_USR -S mv $HD_HOME_DIR/$JDK/ $HD_HOME_DIR/jdk
echo $HD_PWD | sudo -u $HD_USR -S tar -xzvf $HADOOP_TAR -C $HD_HOME_DIR
echo $HD_PWD | sudo -u $HD_USR -S mv $HD_HOME_DIR/$HADOOP/ $HD_HOME_DIR/hadoop

#configure bashrc
echo $HD_PWD | sudo -u $HD_USR -S sh -c "echo export HADOOP_HOME=$HD_HOME_DIR/hadoop/ >> $HD_HOME_DIR/.bashrc"
echo $HD_PWD | sudo -u $HD_USR -S sh -c "echo export PATH=$HD_HOME_DIR/hadoop/bin:$HD_HOME_DIR/jdk/bin:$PATH >> $HD_HOME_DIR/.bashrc"

echo $HD_PWD | sudo -u $HD_USR -S cp $CONF_PATH $HD_HOME_DIR/hadoop/conf/

sudo dpkg -i $OTHER_LIBS

#start master services

#start slave services
