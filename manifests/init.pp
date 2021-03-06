class slim {
  $path_slim_conf = '/etc/slim.conf'

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
    lens    => 'Spacevars.simple_lns',
    context => "/files${path_slim_conf}",
    incl    => $path_slim_conf,
    onlyif  => "get current_theme != archlinux-simplyblack",
    changes => "set current_theme archlinux-simplyblack",
    require => Package['archlinux-themes-slim']
  }
}
