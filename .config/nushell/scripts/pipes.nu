use utils.nu *

export def invert [] {

	let value = $in
	if $value { false } else { true }
}
