### SSH keys
mkdir /root/.ssh
cat > /root/.ssh/authorized_keys << "EOF"
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAABAEAsZfYPVWZMdWHSSAz6TnW0chWaqstO3QgXm7+CQrZcDg0QELNQ/2nb7aXhU5OkZp+grJ1rUdbe1V0OiOPCKsjn2AaweH5cg4Niqv246v45LSU1+R2WDoF0unPUbXVBqgpVh7/6bh+FXcj5J9gD1v8wqtrl6QlDbWWHnDQFQpmVKKzcwcdxSuNMvYw/YxCn95DYGPs+2ocd+Y8z1Xj1PQXRQsEld7O/M0mMyDVMfEGsWb0SI2Z93yVtBQFOP91kpI3jDim3XRwwukQ2Cl8Ls15VB7UrGrM5jaHowh+6Urvh4WeHGLL5Eg1+rH0NQ2wg1mZeeZVVaiMp0LVffA0+ueXPES3iUsX12T2/ujj0THJRemEQp3ym+rJnZOrBWi5KPjqLs5tmoE+xjEXKPAtpZTMTd9MsisbO7FjfcrJJydzHJ5UahnVjQc0GWmE1lrxa9N/HpheKpjZHEDKzpfBwirGydEQkpxJbboTXX+bRAMIEkGXHj6cEEOCL+Y6gNWjB9vfEbt8yb9NsyMD202tudSzvipUl1E2RQumsBwbCFqO889yALQZNlti2q1HmwqdNNsZxRgnnCkycdc/79KWz1PS7MPunYTZND3sXLiz+pQWwX0ANJ2rXuKzCA/eHNWHWzD9Y8AHNuaZAoWucILJExNqP3SqhCAoM/xhuMR6nfacuWz5d5xPjH/K1dn8sR2YTthVs/qOzLyUd6hrnoNY5PIYg1fTQ2RC8rkDDrzX74I2pxp/GcN3BaZCXbE26coQcZ+y3AgkP+FNI1mAkOjYi/ieSIllRHHk7h3bU3gjxbkP9dlYt5m/m1kl/4Dw5Xo0nne5UbWclY/yDTReLRV25+3VnPuC4wwHUMc3hAtDWXARIJbpMmqKZVkel9MlNQfm+NkZtURAY/dBxJLbbE4EBK9HJBKbJoG/MLcM1aW38GR4WGOtzwqy3fbsXUR8yQCgyW8bYhHkQOFHWgv8NCPeIJUGaKrD+CpvA0LWZpgQSVDRnpXeahi2tgnfGw/GQCFLfAdtdgDEqzxPEt89zCjly6ct7VeLBACMoukiGpZ8xfd3n2NvP5i3+1TnM6qgT0rdzq5r9nvfn5l7yUJfw71UFmtmxgNuyO5cTPXTrykZRwoLWdbZ7aS8EokNqmUQz+oRQwiK6qC0AetLS7Rtu9bxtMtzpV0eznSKT0S8uuMUagsk7+3yoi4OL95ljUUALvyTctlnbMkHAVLuv7mwgBbS2VxGb2FuNeIPiQyAfkIGhxM9lAo4y5+UAOXC8G2ZULAQkKm01074ejGu1bHA5E7FdTpO/MiMHCKFOly+UZYmjo2bgYUDV+sWL8ep7EJN2W5qXiSH0i7lYM2ai2gdGEiDkfa5gw== mark@praseodym.net
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEeKZNc8NqwgGE0Ad4U+CbPz63SrY4uxLtQGFHGRhTpOfNvZUO54vTlN4cJrHImdM7Mysw4JCvfRtmsx6Z5s9CQX2zAK7IprwkjiBedCzz2cNylbhX4ajbqV0XNLfYbJPsq1Npk7UxK1jjKae1pkevbB+ZYGg7824M5yZatFuIkO8Zlmt2HkpuT1cucrEzmMh/24uZpeR6uS9/7JhsETakXG1Ix5UmFVymYGJG2AnoyXVO0HRhsR9Mtx3ntt4SM9qYdlfzbv9TfwxREhxvOOm3UMMyNZgM8hNe2FS9RMnijThz/zJo49sXGyYqzBrU5DrxFC+4qBlaEBty2O5Lb6C7 hermanbanken@gmail.com
EOF
mkdir /home/administrator/.ssh
cp /root/.ssh/authorized_keys /home/administrator/.ssh/
passwd -d administrator
passwd -d root

echo "%beheer ALL=(ALL) ALL" >> /etc/sudoers
echo "%pccom ALL=(ALL) ALL" >> /etc/sudoers

### Store configuration
cat > /etc/nsswitch.conf << "EOF"
passwd:   files ldap
group:    files ldap
shadow:   files ldap
hosts:    files dns
networks: files
protocols: db files
services: db files
ethers:   db files
rpc:      db files
netgroup: ldap
EOF

cat > /etc/nslcd.conf << "EOF"
# /etc/nslcd.conf
# nslcd configuration file. See nslcd.conf(5)
# for details.

# The user and group nslcd should run as.
uid nslcd
gid nslcd

# The location at which the LDAP server(s) should be reachable.
uri ldaps://joost.chnet/
uri ldaps://ank.chnet/

bind_timelimit 3
timelimit 3

# The search base that will be used for all queries.
base dc=ank,dc=chnet

# The LDAP protocol version to use.
ldap_version 3

# SSL options
tls_cacertfile  /etc/ssl/certs/wisvch.pem
tls_reqcert     demand

# The search scope.
#scope sub

# Mappings
map passwd homeDirectory homeDirectoryCH
EOF

cat > /etc/ssl/certs/wisvch.pem << "EOF"
-----BEGIN CERTIFICATE-----
MIID8jCCAtoCCQCbEj/bHhLhUTANBgkqhkiG9w0BAQUFADCBujELMAkGA1UEBhMC
TkwxFTATBgNVBAgTDFp1aWQtSG9sbGFuZDEOMAwGA1UEBxMFRGVsZnQxJjAkBgNV
BAoTHVcuSS5TLlYuICdDaHJpc3RpYWFuIEh1eWdlbnMnMQ8wDQYDVQQLEwZCZWhl
ZXIxJjAkBgNVBAMTHVcuSS5TLlYuICdDaHJpc3RpYWFuIEh1eWdlbnMnMSMwIQYJ
KoZIhvcNAQkBFhRiZWhlZXJAY2gudHVkZWxmdC5ubDAeFw0xMDEyMTkxNDQ2MzJa
Fw0yMDEyMTYxNDQ2MzJaMIG6MQswCQYDVQQGEwJOTDEVMBMGA1UECBMMWnVpZC1I
b2xsYW5kMQ4wDAYDVQQHEwVEZWxmdDEmMCQGA1UEChMdVy5JLlMuVi4gJ0Nocmlz
dGlhYW4gSHV5Z2VucycxDzANBgNVBAsTBkJlaGVlcjEmMCQGA1UEAxMdVy5JLlMu
Vi4gJ0NocmlzdGlhYW4gSHV5Z2VucycxIzAhBgkqhkiG9w0BCQEWFGJlaGVlckBj
aC50dWRlbGZ0Lm5sMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnIIg
jXNI3a7kvmMc0mfBG6D+ebJW5jPiih66tOoYopS39LnbGgJ1yhkj3kq+vQBENGKS
YPHh/tpmdWH1YzmRCwk+sX2qpr8nR/MQse0cafbuF8Rd07rJFdBgy/r/Y6xoEbof
llsYvvwJ7+usq4uyhEjynXe99SpV5dTjFj03KkAw1qycr2Mp/D7zNdJ4rIds97/3
0zRT/qjZg04nOsLBxlaCQkfSmJn7DZTN8Pno44B0tfcG/1ofGrXCB8X6R9kwZ3rI
jmRTMy4IcC++//PNvlalsJ3S0VFahT1lf8k1cSVBvnhZ3FUhKrV5jhiq+auxav1M
F0+cC0IqGCsXoEPm2wIDAQABMA0GCSqGSIb3DQEBBQUAA4IBAQArtc4bXffXWXR9
6LKxzg23+wIl3AprPTekV08+kEZlx1Cq3hXWShd0J2my+SnBksjloJ998C6jTqIC
J48zSBM4WT6mmbCMXEvHCOhaaU5WzbberEKLdkDc7Lg+eHcT8viD9VgVa5MWxyXQ
5fVg+vFQ1250LJ457WGKoUMOcJdh5RgCed9KTMkxxUvIcJy3HuNh/PLWlSGfQUta
xjCQpwnH0rWcKWawJw502Nypf4YuIC1+SxdJrYUBdQzB+f6lqa+lgSAvBR2hkvH0
lQ/x0L/qYDwrwMeR07LWLkBPpNwoPQc8l3MrM+QdnLcsF5JSG8X7p8lQvciFNitg
i3QSstfZ
-----END CERTIFICATE-----
EOF

echo "session    required    pam_mkhomedir.so skel=/etc/skel/ umask=0022" >> /etc/pam.d/common-session 

sudo /usr/lib/lightdm/lightdm-set-defaults --hide-users false --allow-guest false --show-remote-login false --show-manual-login true
#sudo service lightdm restart
sudo apt-get remove lightdm -y
sudo apt-get install gdm
#sudo dpkg-reconfigure gdm -y