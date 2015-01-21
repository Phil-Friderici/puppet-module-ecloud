# == Class: ecloud
#
# Module to manage ecloud
#
class ecloud (
  $package_name     = 'electricaccelerator',
  $package_ensure   = 'present',
  $service_name     = 'ecagent',
  $service_ensure   = 'running',
  $service_enable   = true,
  $sysconfig_file   = '/etc/sysconfig/ecagent.conf',
  $sysconfig_ensure = 'file',
  $sysconfig_owner  = 'root',
  $sysconfig_group  = 'root',
  $sysconfig_mode   = '0644',
  $cmhost           = undef,
  $cmport           = '8030',
  $install_erunnerd = undef,
  $log_remove       = 'No',
  $lsf_host         = 'n',
  $max_open_fds     = undef,
  $agent_number     = undef,
  $reboot           = 'No',
  $secure_console   = 'n',
  $tmp_path         = '/tmp',
) {

  validate_absolute_path($sysconfig_file)
  validate_absolute_path($tmp_path)

  validate_bool($service_enable)

  validate_string($package_name)
  validate_string($package_ensure)
  validate_string($service_name)
  validate_string($sysconfig_owner)
  validate_string($sysconfig_group)
  validate_string($sysconfig_mode)
  validate_string($cmport)

  validate_re($service_ensure, '^(running|stopped)$', "ecloud::service_ensure may be either 'running' or 'stopped' and is set to <${service_ensure}>.")
  validate_re($sysconfig_ensure, '^(present|absent|file|link)$', "ecloud::sysconfig_ensure may be either 'present', 'absent', 'file' or 'link' and is set to <${sysconfig_ensure}>.")

  if $cmhost == undef {
    fail('ecloud::cmhost needs to be defined.')
  } else {
    validate_string($cmhost)
  }

  if $install_erunnerd != undef {
    validate_string($install_erunnerd)
  }

  if $log_remove != undef {
    validate_re($log_remove, '^(Yes|No)$', "ecloud::log_remove may be either 'Yes' or 'No' and is set to <${log_remove}>.")
  }

  if $lsf_host != undef {
    validate_re($lsf_host, '^(y|n)$', "ecloud::lsf_host may be either 'y' or 'n' and is set to <${lsf_host}>.")
  }

  if $max_open_fds != undef {
    validate_string($max_open_fds)
  }

  if $agent_number != undef {
    validate_string($agent_number)
  }

  if $reboot != undef {
    validate_re($reboot, '^(Yes|No)$', "ecloud::reboot may be either 'Yes' or 'No' and is set to <${reboot}>.")
  }

  if $secure_console != undef {
    validate_re($secure_console, '^(y|n)$', "ecloud::secure_console may be either 'y' or 'n' and is set to <${secure_console}>.")
  }

  if $agent_number == undef {
    $agent_number_real = $::processorcount
  } else {
    $agent_number_real = $agent_number
  }

  package { $package_name :
    ensure => $package_ensure,
  }

  file { $sysconfig_file :
    ensure  => $sysconfig_ensure,
    owner   => $sysconfig_owner,
    group   => $sysconfig_group,
    mode    => $sysconfig_mode,
    content => template('ecloud/sysconfig.erb'),
    require => Package[$package_name],
  }

  service { $service_name :
    ensure    => $service_ensure,
    enable    => $service_enable,
    subscribe => File[$sysconfig_file],
  }
}
