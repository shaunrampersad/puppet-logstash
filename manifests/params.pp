# == Class logstash::params
#
# This class is meant to be called from logstash.
# It sets variables according to platform.
#
class logstash::params {

  $version = '2.0.0'
  $install_dir = '/opt'
  $user = 'logstash'
  $group = 'logstash'
  $download_url = 'https://download.elastic.co/logstash/logstash'

}

