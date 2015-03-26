# == Class: jdk8
# === Examples
# include jdk8
# === Authors
# Author Name <reppardwalker@gmail.com>

class jdk8(
  $version     = $jdk8::params::version,
  $full_version = $jdk8::params::full_version,
  $arch        = $jdk8::params::arch,
  $extension   = $jdk8::params::extension,
  $base_url     = $jdk8::params::base_url,
) inherits jdk8::params{

  $file_name     = "jdk-${version}-linux-${arch}.${extension}"
  $file_url      = "${base_url}/${full_version}/${file_name}"
  $cookie_string = 'oraclelicense=accept-securebackup-cookie'

  exec { 'curlRPM':
    command => "curl -L -C - -b ${cookie_string} -O ${file_url}",
    cwd     => '/tmp',
    creates => "/tmp/${file_name}",
    path    => ['/usr/bin', '/usr/sbin'],
  }

  package {
    $file_name:
      ensure          => $version,
      require         => Exec['curlRPM'],
      provider        => rpm,
      source          => "/tmp/${file_name}",
      install_options => ['-ivh'],
  }
}
