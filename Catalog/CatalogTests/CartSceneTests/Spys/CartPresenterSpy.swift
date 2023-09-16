//
//  CartPresenterSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

@testable import Catalog

final class CartPresenterSpy: CartPresenting {
	var presentProductCallsCount = 0
	func present(product: Catalog.Product) {
		presentProductCallsCount += 1
	}
	var presentProductsCallsCount = 0
	func present(products: [Catalog.Product : Int]) {
		presentProductsCallsCount += 1
	}
	var presentFilterButtonCallsCount = 0
	func presentFilterButton(title: String) {
		presentFilterButtonCallsCount += 1
	}
	var presentTotalCartPriceCallsCount = 0
	func presentTotalCartPrice(value: Double) {
		presentTotalCartPriceCallsCount += 1
	}
}
