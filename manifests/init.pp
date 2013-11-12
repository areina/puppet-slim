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
    lens    => 'Slim.lns',
    context => "/files/etc/slim.conf",
    onlyif  => "get current_theme != archlinux-simplyblack",
    changes => "set current_theme archlinux-simplyblack",
    require => Package['archlinux-themes-slim']
  }
}
