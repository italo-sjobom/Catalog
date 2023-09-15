//
//  CartManager.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartManaging: AnyObject {
	func add(product: Product) -> [Product: Int]
	func remove(product: Product) -> [Product: Int]
	func delete(product: Product) -> [Product: Int]
	func toggleState()
	func getProducts() -> [Product: Int]
	func getCurrentFilter() -> FilterState
	func getTotalCartPrice() -> Double
}

enum FilterState {
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
	private var filter: FilterState = .all
	static public var shared = CartManager()

	init(productsDictionary: [Product: Int] = [:]) {
		self.productsDictionary = productsDictionary
	}

	func add(product: Product) -> [Product: Int] {
		if productsDictionary[product] != nil {
			productsDictionary[product]! += 1
		} else {
			productsDictionary[product] = 1
		}
		return getProducts()
 	}

	func remove(product: Product) -> [Product: Int] {
		if let productCount = productsDictionary[product], productCount > 1 {
			productsDictionary[product]! -= 1
		} else {
			return delete(product: product)
		}
		return getProducts()
	}

	func delete(product: Product) -> [Product: Int] {
		productsDictionary = productsDictionary.filter { $0.key != product }
		return getProducts()
	}

	func toggleState() {
		filter = filter == .all ? .onSale : .all
	}

	private func getOnSaleProducts() -> [Product: Int] {
		return productsDictionary.filter { $0.key.onSale }
	}

	func getProducts() -> [Product: Int] {
		switch filter {
			case .all:
				return productsDictionary
			case .onSale:
				return getOnSaleProducts()
		}
	}

	func getCurrentFilter() -> FilterState {
		return filter
	}

	func getTotalCartPrice() -> Double {
		var sum: Double = 0
		getProducts().forEach { products in
			let valueString = products.key.onSale ? products.key.promotionalPrice : products.key.price
			if let number = Formatter.convertReaisStringToDouble(valueString: valueString) {
				sum += number * Double(productsDictionary[products.key]!)
			}
		}
		return sum
	}
}
