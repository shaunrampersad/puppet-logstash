# == Class logstash::install
#
# This class is called from logstash for install.
#
class logstash::install {

  file { "${::logstash::install_dir}/logstash" :
    ensure => directory,
    owner  => $::logstash::user,
    group  => $::logstash::group,
    mode   => '0750',
  } ->

  staging::file { "logstash-${::logstash::version}.tar.gz":
    source => "${::logstash::download_url}/logstash-${::logstash::version}.tar.gz",
  } ->
  
  staging::extract  { "logstash-${::logstash::version}.tar.gz":
    target  => "${::logstash::install_dir}/logstash",
    creates => "${::logstash::install_dir}/logstash/logstash-${::logstash::version}/NOTICE.TXT",
    require => Staging::File["logstash-${::logstash::version}.tar.gz"],
  } ->

  file { '/etc/logstash' :
    ensure => directory,
    owner  => $::logstash::user,
    group  => $::logstash::group,
    mode   => '0750',
  }

  file { '/etc/logstash/conf.d' :
    ensure  => directory,
    owner   => $::logstash::user,
    group   => $::logstash::group,
    mode    => '0750',
    require => File['/etc/logstash'],
  }

  file { "${::logstash::install_dir}/logstash/latest" :
    ensure  => link,
    owner   => $::logstash::user,
    group   => $::logstash::group,
    target  => "${::logstash::install_dir}/logstash/logstash-${::logstash::version}",
    require => Staging::Extract["logstash-${::logstash::version}.tar.gz"],
  }
}
