# Class: logstash
# ===========================
#
# Full description of class logstash here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class logstash (
  $version = $::logstash::version,
  $install_dir = $::logstash::install_dir,
  $user = $::logstash::user,
  $group = $::logstash::group,
  $download_url = $::logstash::download_url


) inherits ::logstash::params {

  # validate parameters here
  
  class { '::logstash::install': } ->
  class { '::logstash::service': } ->
  Class['::logstash']
}
