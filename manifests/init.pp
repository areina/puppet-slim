class slim {
  package { 'slim':
    ensure => installed,
    before => Exec['enable_slim'],
  }

  package { 'slim-themes':
    ensure => installed,
  }
  package { 'archlinux-themes-slim':
    ensure => installed,
  }

  exec { 'enable_slim':
    command => 'systemctl enable slim.service',
    user    => 'root'
  }

  augeas { "slim_conf/current_theme":
    context => "/files/etc/slim.conf",
    onlyif  => "get current_theme != archlinux-simplyback",
    changes => "set current_theme archlinux-simplyback",
    require => Package['archlinux-themes-slim']
  }
}
