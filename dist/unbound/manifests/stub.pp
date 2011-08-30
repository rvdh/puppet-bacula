define unbound::stub (
  $address,
  $insecure = false
) {
  include unbound::params

  $unbound_confdir = $unbound::params::unbound_confdir

  concat::fragment { "unbound-stub-$name":
    order   => '05',
    target  => "$unbound_confdir/unbound.conf",
    content => template("unbound/stub.erb"),
  }

  if $insecure == true {
    concat::fragment { :
      order   => '01',
      target  => "$unbound_confdir/unbound.conf",
      content => "  domain-insecure: \"${name}\"",
    }
  }

}
