class apache::install (
  $apache_user            = lookup('apache::user'),
  $apache_group           = lookup('apache::group'),
  $packages               = lookup('apache::packages'),
  $httpd_conf             = lookup('apache::httpd_conf'),
  $apache_document_root   = lookup('apache::document_root'),
  $directories            = lookup('apache::directories'),
)
{
   package { $packages:
     ensure => present,
   } ->
   file { "$httpd_conf":
     content => template('apache/httpd.conf.erb'),
   } ->
   file {$directories:
     ensure => directory,
   } ->
   file { "$apache_document_root/tier1/a.html":
     content => template('apache/tier1/a.html.erb'),
     group  => "$apache_group",
     owner  => "$apache_user",
   } ->
   file { "$apache_document_root/tier2/a.html":
     content => template('apache/tier2/a.html.erb'),
     group  => "$apache_group",
     owner  => "$apache_user",
   }
}
