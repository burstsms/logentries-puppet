# vim: set ts=2 sw=2 et :

define logentries::follow($path, $uiname)
{
  include logentries

  if ! $uiname {
    $uiname = $path
  }
  
  exec {
    $title:
      notify  => Service["logentries"],
      path    => ['/bin', '/usr/bin', '/usr/local/bin' ],
      command => "le follow $path --name $uiname",
      onlyif  => "test -f $path",
      unless  => "le followed $path",
      require => Exec['le_register'];
  }
}
