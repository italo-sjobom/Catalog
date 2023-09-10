//
//  Product.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

/*"name": "VESTIDO TRANSPASSE BOW",
"style": "20002605",
"code_color": "20002605_613",
"color_slug": "tapecaria",
"color": "TAPEÇARIA",
"on_sale": false,
"regular_price": "R$ 199,90",
"actual_price": "R$ 199,90",
"discount_percentage": "",
"installments": "3x R$ 66,63",
"image": "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
"sizes": [{
	"available": false,
	"size": "PP",
	"sku": "5807_343_0_PP"
}, {
	"available": true,
	"size": "P",
	"sku": "5807_343_0_P"
}, {
	"available": true,
	"size": "M",
	"sku": "5807_343_0_M"
}, {
	"available": true,
	"size": "G",
	"sku": "5807_343_0_G"
}, {
	"available": false,
	"size": "GG",
	"sku": "5807_343_0_GG"
}]
*/

struct Product: Codable {
	let image: String?
	let name: String
	let price: String
	let onSale: Bool
	let promotionalPrice: String
	let sizes: [Size]

	init(image: String? = nil, name: String, price: String, onSale: Bool, promotionalPrice: String, sizes: [Size]) {
		self.image = image
		self.name = name
		self.price = price
		self.onSale = onSale
		self.promotionalPrice = promotionalPrice
		self.sizes = sizes
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		price = try values.decode(String.self, forKey: .price)
		onSale = try values.decode(Bool.self, forKey: .onSale)
		promotionalPrice = try values.decode(String.self, forKey: .promotionalPrice)
		image = nil
		name = ""
		sizes = []
	}

	enum CodingKeys: String, CodingKey {
		case price = "regular_price"
		case onSale = "on_sale"
		case promotionalPrice = "actual_price"
	}
}

