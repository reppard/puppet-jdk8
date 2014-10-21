# == Class: jdk8
# === Examples
# include jdk8
# === Authors
# Author Name <reppardwalker@gmail.com>

class jdk8(
  $version     = '8u25',
  $fullVersion = '8u25-b17',
  $arch        = 'x64',
  $extension   = 'rpm',
  $baseUrl     = 'http://download.oracle.com/otn-pub/java/jdk/',
){

  $fileName     = "jdk-${version}-linux-${arch}.${extension}"
  $fileUrl      = "${baseUrl}/${fullVersion}/${fileName}"
  $cookieString = 'oraclelicense=accept-securebackup-cookie'

  exec { 'curlRPM':
    command => "curl -L -C - -b ${cookieString} -O ${fileUrl}",
    cwd     => '/tmp',
    creates => "/tmp/${fileName}",
    path    => ['/usr/bin', '/usr/sbin'],
  }

  package {
    $fileName:
      ensure          => installed,
      require         => Exec['curlRPM'],
      provider        => rpm,
      source          => "/tmp/${fileName}",
      install_options => ['-ivh'],
  }
}
