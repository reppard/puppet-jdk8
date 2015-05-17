# Class jdk8
class jdk8::params {
  case $::osfamily {
    'redhat' :{
      $version     = '8u45'
      $full_version = '8u45-b14'
      $arch        = 'x64'
      $extension   = 'rpm'
      $base_url     = 'http://download.oracle.com/otn-pub/java/jdk/'
    }
    default: { fail('Your platform is not currently supported.')}
  }
}
