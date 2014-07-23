define monit::conf(
  $content = undef,
  $source = undef
) {
  if ($content) {
    file { "/etc/monit/conf.d/${title}":
      ensure  => file,
      content => $content,
      owner   => 'root',
      group   => 'root',
      mode    => '640',
      require => Package['monit'],
      notify  => Service['monit']
    }
  } elsif ($source) {
    file { "/etc/monit/conf.d/${title}":
      ensure  => file,
      source  => $source,
      owner   => 'root',
      group   => 'root',
      mode    => '640',
      require => Package['monit'],
      notify  => Service['monit']
    }
  }
}
