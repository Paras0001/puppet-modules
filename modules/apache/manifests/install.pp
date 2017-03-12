class apache::install (
  $apache_user         = lookup('apache::user'),
  $apache_group        = lookup('apache::group'),
  $packages            = lookup('apache::packages'),
  $httpd_conf          = lookup('apache::httpd_conf'),
  $httpd_content_file  = lookup('apache::httpd_content_file'),
  $httpd_content_root  = lookup('apache::content_root'),
)
{
   package { $packages:
     ensure => present,
   } ->
   file { "$httpd_conf":
     content => template('apache/httpd.conf.erb'),
   } ->
   file { "$httpd_content_root":
     ensure => directory,
     group  => "$apache_group",
     owner  => "$apache_user",
   } ->
   file { "$httpd_content_file":
     content => template('apache/a.html.erb'),
     group  => "$apache_group",
     owner  => "$apache_user",
   }
   
}
