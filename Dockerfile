FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    dnsutils && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

EXPOSE 22

CMD locale-gen "en_US.UTF-8" && \
    dpkg-reconfigure locales && \
    update-locale && \
    \
    sed -i \
        's/PermitRootLogin without-password/PermitRootLogin yes/' \
        /etc/ssh/sshd_config && \
    sed -i \
        's/#PasswordAuthentication yes/PasswordAuthentication no/' \
        /etc/ssh/sshd_config && \
    \
    echo 'export PROMPT_COMMAND='"'"'RETRN_VAL=$?;logger -p local6.debug "$(whoami) [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'"'" >> /etc/bash.bashrc && \
    echo 'local6.*    /var/log/commands.log' >> /etc/rsyslog.d/bash.conf && \
    echo '/var/log/commands.log' >> /etc/logrotate.d/rsyslog && \
    \
    mkdir -p ~/.ssh && \
    \
    _break=false && \
    \
    add_auth_key() { \
        touch /tmp/tmp.pub && \
        read -p "Enter authorized key: " auth_key && \
        echo "$auth_key" > /tmp/tmp.pub && \
        until ssh-keygen -lf /tmp/tmp.pub || [ "$_break" = true ]; do \
            printf '%s\n' "Invalid input. Try again." && \
            read -p "Enter authorized key: " auth_key && \
            echo "$auth_key" > /tmp/tmp.pub; \
        done && \
        if [ "$_break" = false ]; then \
            cat /tmp/tmp.pub >> ~/.ssh/authorized_keys; \
        fi; \
    } && \
    \
    add_auth_key && \
    \
    while true; do \
        trap - INT && \
        read -p "Continue add authorized keys? [Y/n] " yn && \
        trap "echo; _break=true" INT && \
        case $yn in \
            [Yy]* ) _break=false && echo -n "[Ctrl+C to cancel] " && add_auth_key;; \
            [Nn]* ) break;; \
            * ) echo "Please answer yes or no.";; \
        esac \
    done && \
    \
    service rsyslog start && \
    service ssh start && \
    echo -n 'Local  IP: ' && \
    /sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' && \
    echo -n 'Public IP: ' && \
    dig +short myip.opendns.com @resolver1.opendns.com && \
    tail -f /var/log/auth.log -f /var/log/commands.log
