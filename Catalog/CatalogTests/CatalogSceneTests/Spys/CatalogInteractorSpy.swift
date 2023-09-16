//
//  CatalogInteractorSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//

import Foundation
@testable import Catalog

final class CatalogInteractorSpy: CatalogInteracting {
	var openCartCallsCount = 0
	func openCart() {
		openCartCallsCount += 1
	}

	var addToCartCallsCount = 0
	func addToCart(product: Catalog.Product) {
		addToCartCallsCount += 1
	}

	var openProductCallsCount = 0
	func openProduct() {
		openProductCallsCount += 1
	}

	var fetchProductsCallsCount = 0
	func fetchProducts() {
		fetchProductsCallsCount += 1
	}
}
