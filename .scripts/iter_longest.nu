export def longestProduct [ iter1 iter2 ] {

	let sorted = (

		[ $iter1 $iter2 ] 
		| wrap value
		| merge (
			[ $iter1 $iter2 ]
			| each { || length }
			| wrap length
		)
		| sort-by length
	)
	mut short = $sorted.0
	let long = $sorted.1
	$short.value = ($short.value | append ([ null ] * (($long.length ) - ($short.length))))
	$long.value | zip $short.value
}
