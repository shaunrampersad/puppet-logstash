# == Class logstash::params
#
# This class is meant to be called from logstash.
# It sets variables according to platform.
#
class logstash::params {

  $package_version => '2.0.0'
  $install_dir => '/opt'
}

#  case $::osfamily {
#    'Debian': {
#      $package_name = 'logstash'
#      $service_name = 'logstash'
#    }
#    'RedHat', 'Amazon': {
#      $package_name = 'logstash'
#      $service_name = 'logstash'
#    }
#    default: {
#      fail("${::operatingsystem} not supported")
#    }
#  }
#}
