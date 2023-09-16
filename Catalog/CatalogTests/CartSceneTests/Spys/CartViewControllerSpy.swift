//
//  CartViewControllerSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

@testable import Catalog

final class CartViewControllerSpy: CartDisplaying {
	var displayProductsCallsCount = 0
	func displayProducts(products: [Catalog.Product : Int]) {
		displayProductsCallsCount += 1
	}
	var displayFilterButtonCallsCount = 0
	func displayFilterButton(title: String) {
		displayFilterButtonCallsCount += 1
	}
	var displayTotalCartPriceCallsCount = 0
	func displayTotalCartPrice(value: Double) {
		displayTotalCartPriceCallsCount += 1
	}
}
