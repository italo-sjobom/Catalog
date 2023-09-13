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
	private var products: [Product]
	private var filter: FilterType = .all
	static public var shared = CartManager()

	init(products: [Product] = []) {
		self.products = products
	}

	func addProduct(product: Product) {
		products.append(product)
	}

	func removeProduct(product: Product) {
		products.removeAll { product in
			return product == product
		}
	}

	func toggleState() {
		filter = filter == .all ? .onSale : .all
	}

	private func getOnSaleProducts() -> [Product] {
		return products.filter { product in
			return product.onSale
		}
	}

	func getProducts() -> [Product] {
		switch filter {
			case .all:
				return products
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
