class monit (
    $admin_enabled = false,
    $admin_port = 2813,
    $admin_password = undef,
    $email_enabled = false,
    $smtp_host = undef,
    $smtp_port = undef,
    $smtp_username = undef,
    $smtp_password = undef,
) {
  package { 'monit':
    ensure => present
  }

  service { 'monit':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      File['/etc/monit/monitrc'],
      Package['monit']
    ]
  }

  group { 'monit': ensure => present }

  file { '/etc/monit/monitrc':
    ensure  => file,
    content => template('monit/monitrc.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    require => Package['monit'],
    notify  => Service['monit']
  }

  # Allow members of the `monit` group to execute monit commands.
  sudo::directive { 'monit':
    content => template('monit/monit.sudoers.erb'),
    require => Group['monit']
  }
}
