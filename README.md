# puppet-module-ecloud
===

Manage Electric Accelerator

===

# Compatibility
---------------
This module is built for use with Puppet v3 with Ruby versions 1.8.7 on the following OS families.

* EL 6

===

# Parameters
------------

package_name
------------
Name of the Electric Accelerator package

- *Default*: electricaccelerator

package_ensure
--------------
Ensure of the package

- *Default*: present

service_name
------------
Name of the Electric Accelerator service

- *Default*: ecagent

service_ensure
--------------
Ensure of the service, accepts 'running' or 'stopped'

- *Default*: running

service_enable
--------------
Should the service be enabled? Bool.

- *Default*: true

sysconfig_file
--------------
Path to the configuration file

- *Default*: /etc/sysconfig/ecagent.conf

sysconfig_ensure
----------------
Ensure of config file, accepts 'present', 'absent', 'file' or 'link'

- *Default*: file

sysconfig_owner
---------------
Owner of config file

- *Default*: root

sysconfig_group
---------------
Group of config file

- *Default*: root

sysconfig_mode
--------------
Mode of config file

- *Default*: 0644

cmhost
------
Hostname of the Cluster Manager

- *Default*: undef

cmport
------
Cluster Manager port

- *Default*: 8030

install_erunnerd
----------------
Should erunnerd be installed?

- *Default*: undef

log_remove
----------
Should logs be removed? Accepts 'Yes' or 'No'

- *Default*: No

lsf_host
--------
Lsf host? Accepts 'y' or 'n'

- *Default*: n

max_open_fds
------------
Max open fds

- *Default*: undef

agent_number
------------
Number of agents

- *Default*: $::processorcount

reboot
------
Reboot? Accepts 'Yes' or 'No'

- *Default*: No

secure_console
--------------
Secure console? Accepts 'y' or 'n'

- *Default*: n

tmp_path
--------
Path to temporary folder

- *Default*: /tmp
