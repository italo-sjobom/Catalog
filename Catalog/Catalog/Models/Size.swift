//
//  Size.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

/*{
	"available": false,
	"size": "PP",
	"sku": "5807_343_0_PP"
}*/

struct Size: Codable {
	let available: Bool
	let size: String
	let sku: String

	init(available: Bool, size: String, sku: String) {
		self.available = available
		self.size = size
		self.sku = sku
	}
}
