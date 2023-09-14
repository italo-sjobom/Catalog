//
//  CartManager.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartManaging: AnyObject {
	func addProduct(product: Product)
	func removeProduct(product: Product)
	func deleteProduct(product: Product)
	func toggleState()
	func getProducts() -> [Product]
	func getCurrentFilter() -> FilterType
	func getTotalCartPrice() -> Double
}

enum FilterType {
	case all
	case onSale

	func stateString() -> String {
		switch self {
			case .all: return "All"
			case .onSale: return "On Sale"
		}
	}
}

class CartManager: CartManaging {
	private var productsDictionary: [Product: Int]
	private var filter: FilterType = .all
	static public var shared = CartManager()

	init(productsDictionary: [Product: Int] = [:], products: [Product] = []) {
		self.productsDictionary = productsDictionary
	}

	func addProduct(product: Product) {
		if productsDictionary[product] != nil {
			productsDictionary[product]! += 1
		} else {
			productsDictionary[product] = 1
		}
 	}

	func removeProduct(product: Product) {
		if let productCount = productsDictionary[product], productCount > 1 {
			productsDictionary[product]! -= 1
		} else {
			deleteProduct(product: product)
		}
	}

	func deleteProduct(product: Product) {
		productsDictionary = productsDictionary.filter { $0.key != product }
	}

	func toggleState() {
		filter = filter == .all ? .onSale : .all
	}

	private func getOnSaleProducts() -> [Product] {
		return productsDictionary.keys.filter { $0.onSale }
	}

	func getProducts() -> [Product] {
		switch filter {
			case .all:
				return Array<Product>(productsDictionary.keys)
			case .onSale:
				return getOnSaleProducts()
		}
	}

	func getCurrentFilter() -> FilterType {
		return filter
	}

	func getTotalCartPrice() -> Double {
		var sum: Double = 0
		getProducts().forEach { product in
			let valueString = product.onSale ? product.promotionalPrice : product.price
			if let number = Formatter.convertReaisStringToDouble(valueString: valueString) {
				sum += number
			}
		}
		return sum
	}
}
