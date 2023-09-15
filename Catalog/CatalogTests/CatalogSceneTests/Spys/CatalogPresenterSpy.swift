//
//  CatalogPresenterSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//
@testable import Catalog

final class CatalogPresenterSpy: CatalogPresenting {
	private(set)var presentCartCallsCount = 0
	func presentCart(cartManager: Catalog.CartManaging) {
		presentCartCallsCount += 1
	}

	private(set)var presentProductCallsCount = 0
	func presentProducts(products: [Catalog.Product]) {
		presentProductCallsCount += 1
	}

	private(set)var presentErrorCallsCount = 0
	func presentError(description: String) {
		presentErrorCallsCount += 1
	}
}
