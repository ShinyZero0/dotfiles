use xbps-cmp.nu *

export alias pkin = sudo xbps-install -S
export alias pkrm = sudo xbps-remove
export alias pkup = sudo xbps-install -Su
export alias pkdb = sudo xbps-pkgdb
export def pkfd [ query ] {

	^xbps-query -Rs $query
		| lines
		| find --invert '-32bit'
		| each { |line|
			$line
			|  parse -r '\[.\]\s+(?P<value>\S+)-\S+\s+(?P<description>.+)'
			| into record
		}
}
export alias pkinf = xbps-query -RS
export alias pkls = open ~/.scripts/install/pc/packages.json
