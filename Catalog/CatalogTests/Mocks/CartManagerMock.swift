//
//  CartManagerMock.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import Foundation
@testable import Catalog

class CartManagerMock {
	private var productsDictionary: [Product: Int]

	init(productsDictionary: [Product: Int] = [:], products: [Product]) {
		self.productsDictionary = productsDictionary
		for index in 0...2 {
			add(product: products[index])
		}
	}

	private func add(product: Product) {
		if productsDictionary[product] != nil {
			productsDictionary[product]! += 1
		} else {
			productsDictionary[product] = 1
		}
	}

	func getProducts() -> [Product: Int] {
		return productsDictionary
	}
}
