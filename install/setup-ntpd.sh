#!/bin/sh
sudo ln -s /etc/runit/sv/ntpd /var/run/runit/service/ && sudo sv start npd
