//
//  CartManagerMock.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

@testable import Catalog

class CartManagerMock {
	private var productsDictionary: [Product: Int]
	var totalPrice: Double = 629.60000000000002

	init(productsDictionary: [Product: Int] = [:], products: [Product]) {
		self.productsDictionary = productsDictionary
		for index in 0...2 {
			if index == 0 {
				add(product: products[index], countAdded: 2)
			} else {
				add(product: products[index])
			}
		}
	}

	private func add(product: Product, countAdded: Int = 1) {
		if productsDictionary[product] != nil {
			productsDictionary[product]! += countAdded
		} else {
			productsDictionary[product] = countAdded
		}
	}

	func getProducts() -> [Product: Int] {
		return productsDictionary
	}
}
