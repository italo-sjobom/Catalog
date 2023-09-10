//
//  Product.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

struct Product: Codable {
	let name: String
	let style: String
	let codeColor: String
	let colorSlug: String
	let color: String
	let onSale: Bool
	let price: String
	let promotionalPrice: String
	let discountPercentage: String?
	let installments: String
	let imageURL: String?
	let sizes: [Size]

	init(name: String, style: String, codeColor: String, colorSlug: String, color: String, onSale: Bool, price: String, promotionalPrice: String, discountPercentage: String?, installments: String, image: String?, sizes: [Size]) {
		self.name = name
		self.style = style
		self.codeColor = codeColor
		self.colorSlug = colorSlug
		self.color = color
		self.onSale = onSale
		self.price = price
		self.promotionalPrice = promotionalPrice
		self.discountPercentage = discountPercentage
		self.installments = installments
		self.imageURL = image
		self.sizes = sizes
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.style = try container.decode(String.self, forKey: .style)
		self.codeColor = try container.decode(String.self, forKey: .codeColor)
		self.colorSlug = try container.decode(String.self, forKey: .colorSlug)
		self.color = try container.decode(String.self, forKey: .color)
		self.onSale = try container.decode(Bool.self, forKey: .onSale)
		self.price = try container.decode(String.self, forKey: .price)
		self.promotionalPrice = try container.decode(String.self, forKey: .promotionalPrice)
		self.discountPercentage = try container.decodeIfPresent(String.self, forKey: .discountPercentage)
		self.installments = try container.decode(String.self, forKey: .installments)
		self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
		self.sizes = try container.decode([Size].self, forKey: .sizes)
	}

	enum CodingKeys: String, CodingKey {
		case name
		case style
		case codeColor = "code_color"
		case colorSlug = "color_slug"
		case color
		case onSale = "on_sale"
		case price = "regular_price"
		case promotionalPrice = "actual_price"
		case discountPercentage = "discount_percentage"
		case installments
		case imageURL = "image"
		case sizes
	}
}

