# rename/move the public/private keys
if [ -f /root/.ssh/id_docker ] ; then
    mv /root/.ssh/id_docker /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
fi

if [ -f /root/.ssh/id_docker.pub ] ; then
    mv /root/.ssh/id_docker.pub /root/.ssh/id_rsa.pub
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
fi

# install the salt-master and update it's config
zypper -n --no-gpg-checks in --force-resolution --no-recommends salt-master
cp -v /tmp/salt/master.d/* /etc/salt/master.d

# fix some permissions and missing dirs
[ -f /srv/salt/certs/certs.sh ] && chmod 755 /srv/salt/certs/certs.sh
[ -d /srv/files ] || mkdir -p /srv/files

# enable & start the salt master
systemctl enable salt-master
systemctl start salt-master
