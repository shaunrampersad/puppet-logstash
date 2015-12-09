# == Class logstash::install
#
# This class is called from logstash for install.
#
class logstash::install {


  class { '::staging':
    path  => '${::logstash::install_dir}/logstash/.staging',
    mode  => '0700',
    owner => $::logstash::user,
    group => $::logstash::group,
  }

  staging::file { "logstash-${::logstash::version}.tar.gz":
    source => "${::logstash::download_url}/logstash-${::logstash::version}.tar.gz",
  } ->
  
  staging::extract  { "logstash-${::logstash::version}.tar.gz":
    target => "${::logstash::install_dir}/logstash",
    creates => "${::logstash::install_dir}/logstash/logstash-${::logstash::version}/NOTICE.TXT",
    require => Staging::File["logstash-${::logstash::version}.tar.gz",
  } 

  file { "${::logstash::install_dir}/logstash/logstash-${::logstash::version}/config" :
    ensure  => directory,
    owner   => "$::logstash::user",
    group   => "$::logstash::group",
    mode    => "0640",
  }

  file { "${::logstash::install_dir}/logstash/latest" :
    ensure  => link,
    target   => "${::logstash::install_dir}/logstash/logstash-${::logstash::version}",
  }


}
