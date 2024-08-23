#!/bin/bash
function is_ubuntu() {
  [ -f /etc/os-release ] && . /etc/os-release
  [[ $ID =~ ubuntu ]] && return 0
  return 255
}

function is_centos() {
  [ -f /etc/os-release ] && . /etc/os-release
  [[ $ID =~ centos ]] && return 0
  return 255
}

function is_redhat() {
  [ -f /etc/os-release ] && . /etc/os-release
  [[ $ID =~ rhel ]] && return 0
  return 255
}

set -e
# set -x #uncomment this line if you want debugging

# Remove any old kernels
if is_centos || is_redhat; then
  echo -n "Cleaning YUM... "
  echo 'clean_requirements_on_remove=1' >> /etc/yum.conf # have YUM clean up after itself a little better
  yum remove -q -y epel-release &> /dev/null
  package-cleanup -y --oldkernels --count=1 &> /dev/null
  yum history new &> /dev/null

  yum clean -q all
  /bin/rm -f /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo
  /bin/rm -rf /var/cache/yum
fi
if is_ubuntu; then
  export DEBIAN_FRONTEND=noninteractive DISPLAY=":0" LANG=C.UTF-8
  echo -n "Cleaning APT...."
  apt-get -y -qq autoremove
  apt-get -y -qq clean
  apt-get -y -qq autoclean
  rm -rf /var/lib/apt/lists/* /var/cache/apt/*
fi
echo "done"

# turn off logging during shut down:
/bin/systemctl stop -q rsyslog.service

# Remove old logs
echo -n "Cleaning logs... "
is_ubuntu && rm -rf /var/log/unattended-upgrades
/bin/rm -f /var/log/*-???????? /var/log/*.gz /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda /var/log/ks.post02.log
# Truncate the audit logs
[ -f /var/log/audit/augit.log ] && truncate --size 0 /var/log/audit/audit.log
truncate --size 0 /var/log/wtmp
truncate --size 0 /var/log/lastlog
truncate --size 0 /var/log/cloud-init.log
if is_redhat || is_centos; then
  truncate --size 0 /var/log/messages
  truncate --size 0 /var/log/grubby
  truncate --size 0 /var/log/secure
fi
if is_ubuntu; then
  truncate --size 0 /var/log/syslog
  truncate --size 0 /var/log/auth.log
  truncate --size 0 /var/log/dpkg.log
  truncate --size 0 /var/log/kern.log
  truncate --size 0 /var/log/btmp
  truncate --size 0 /var/log/faillog
  truncate --size 0 /var/log/tallylog
fi
echo "done"

echo -n "Cleaning various files... "
# Clean /tmp out
/bin/rm -rf /tmp/* /var/tmp/*
#cleanup persistent udev rules
/bin/rm -f /etc/udev/rules.d/70-persistent-net.rules
/bin/rm -f /root/anaconda-ks.cfg
/bin/rm -f /root/original-ks.cfg
/bin/rm -rf /root/.cache /root/.pki /root/.ssh
echo "done"

# Remove the SSH host keys
echo -n "Cleaning SSH keys... "
/bin/rm -f /etc/ssh/*key*
#cleanup current ssh keys
/bin/rm -f /etc/ssh/ssh_host_*
echo "done"

echo -n "Zero-ing disks (this will take a while): "
for fs in $(findmnt -o TARGET -nlt xfs,ext3,ext4 --mtab); do
  echo -n "  ${fs}... "
  dd if=/dev/zero of=${fs}/zerofile bs=1M &>/dev/null || /bin/rm -f ${fs}/zerofile
  sleep 2
  /bin/sync
  echo "complete"
done

#cleanup shell history
history -w
history -c
