def "xbps local packages" [] {

    ^xbps-query -l | lines 
    | each { || 
        parse -r 'ii\s+(?P<value>\S+)-\S+\s+(?P<description>.+) ' | into record
    } 
}
def "xbps all packages" [] {

    open ~/.cache/xbps-cache.json  # see ~/.scripts/xbps-cache.nu
}
export extern "sudo xbps-remove" [ 

	--config(-C)	# Path to confdir (xbps.d)
	--cachedir(-c)	# Path to cachedir
	--debug(-d)	# Debug mode shown to stderr
	--force-revdeps(-F)	# Force package removal even with revdeps or
	--force(-f)	# Force package files removal
	--help(-h)	# Print help usage
	--dry-run(-n)	# Dry-run mode
	--clean-cache(-O)	# Remove obsolete packages in cachedir
	--remove-orphans(-o)	# Remove package orphans
	--recursive(-R)	# Recursively remove dependencies
	--rootdir(-r)	# Full path to rootdir
	--verbose(-v)	# Verbose messages
	--yes(-y)	# Assume yes to all questions
	--version(-V)	# Show XBPS version
]
export extern "sudo xbps-install" [

	--automatic(-A)
	--config(-C)
	--cachedir(-c)
	--debug(-d)
	--download-only(-D)
	--force(-f)
	--help(-h)
	--ignore-conf-repos(-i)
	--ignore-file-conflicts(-I)
	--unpack-only(-U)
	--memory-sync(-M)
	--dry-run(-n)
	--rootdir(-r)
	--reproducible
	--sync(-S)
	--update(-u)
	--verbose(-v)
	--yes(-y)
	--version(-V)
	...targets: string@"xbps all packages"
]
export extern "xbps-query" [

	--config(-C)	# Path to confdir (xbps.d)
	--cachedir(-c)	# Path to cachedir
	--debug(-d)	# Debug mode shown to stderr
	--help(-h)	# Print help usage
	--ignore-conf-repos(-i)	# Ignore repositories defined in xbps.d
	--memory-sync(-M)	# Remote repository data is fetched and stored
	--property(-p)	# Show properties for PKGNAME
	--repository(-R)	# Enable repository mode. This mode explicitly
	--repository	# Enable repository mode and add repository
	--regex	# Use Extended Regular Expressions to match
	--fulldeptree	# Full dependency tree for -x/--deps
	--rootdir(-r)	# Full path to rootdir
	--version(-V)	# Show Xversion
	--verbose(-v)	# Verbose messages
	--list-pkgs(-l)	# List installed packages
	--list-repos(-L)	# List registered repositories
	--list-hold-pkgs(-H)	# List packages on hold state
	--list-repolock-pkgs	# List repolocked packages
	--list-manual-pkgs(-m)	# List packages installed explicitly
	--list-orphans(-O)	# List package orphans
	--ownedby(-o)	# FSearch for package files by matching STRING or REGEX
	--show(-S)	# Show information for PKG [default mode]
	--search(-s)	# Search for packages by matching PKG, STRING or REGEX
	--cat	# Print Ffrom PKG binpkg to stdout
	--files(-f)	# Show package files for PKG
	--deps(-x)	# Show dependencies for PKG
	--revdeps(-X)	# Show reverse dependencies for PKG
]

export extern "sudo xbps-alternatives" [

	--config(-C)	# Path to confdir (xbps.d)
	--debug(-d)	# Debug mode shown to stderr
	--group(-g)	# Group of alternatives to match
	--help(-h)	# Print usage help
	--rootdir(-r)	# Full path to rootdir
	--verbose(-v)	# Verbose messages
	--version(-V)	# Show Xversion
	--list(-l)	# List all alternatives or from PKG
	--set(-s)	# Set alternatives for PKG
]
export extern "sudo xbps-pkgdb" [
	
	--all(-a)	# Process all packages
	--config(-C)	# Path to confdir (xbps.d)
	--debug(-d)	# Debug mode shown to stderr
	--help(-h)	# Print usage help
	--mode(-m)	# Change PKGNto this mode
	--rootdir(-r)	# Full path to rootdir
	--update(-u)	# Update pkgdb to the latest format
	--verbose(-v)	# Verbose messages
	--version(-V)	# Show Xversion
]
