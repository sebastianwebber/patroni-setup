## almost copy and pasted from https://github.com/mcwarman/vagrant-docker-provider/blob/master/centos7/systemd/Dockerfile
FROM rockylinux:8

RUN dnf -y update; dnf clean all && \
    dnf -y install openssh-server openssh-clients passwd sudo iproute; dnf clean all

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN mkdir /var/run/sshd; \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''; \
    systemctl enable sshd.service; \
    sed -i '/^session.*pam_loginuid.so/s/^session/# session/' /etc/pam.d/sshd; \
    sed -i 's/Defaults.*requiretty/#Defaults requiretty/g' /etc/sudoers; \
    rm /usr/lib/tmpfiles.d/systemd-nologin.conf;

RUN useradd --create-home -s /bin/bash vagrant; \
    echo -e "vagrant\nvagrant" | (passwd --stdin vagrant); \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant; \
    chmod 440 /etc/sudoers.d/vagrant

RUN mkdir -p /home/vagrant/.ssh; \
    chmod 700 /home/vagrant/.ssh
ADD local-cluster-rsa-key.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys; \
    chown -R vagrant:vagrant /home/vagrant/.ssh

# VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]