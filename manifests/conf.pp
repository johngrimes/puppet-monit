define monit::conf($content) {
  file { "/etc/monit/conf.d/${title}":
    ensure  => file,
    content => $content,
    owner   => 'root',
    group   => 'root',
    mode    => '640',
    require => Package['monit'],
    notify  => Service['monit']
  }
}
