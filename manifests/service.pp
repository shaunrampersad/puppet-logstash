# == Class logstash::service
#
# This class is meant to be called from logstash.
# It ensure the service is running.
#
class logstash::service {

  file { '/etc/init.d/logstash' :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
    content => template('logstash/logstash_init.erb'),
  }

  service { 'logstash':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
