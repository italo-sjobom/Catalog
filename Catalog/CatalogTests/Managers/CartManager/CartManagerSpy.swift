//
//  CartManagerSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//
@testable import Catalog

final class CartManagerSpy: CartManaging {
	var addCallsCount = 0
	func add(product: Catalog.Product) -> [Catalog.Product : Int] {
		addCallsCount += 1
		return [:]
	}
	var removeCallsCount = 0
	func remove(product: Catalog.Product) -> [Catalog.Product : Int] {
		removeCallsCount += 1
		return [:]
	}
	var deleteCallsCount = 0
	func delete(product: Catalog.Product) -> [Catalog.Product : Int] {
		deleteCallsCount += 1
		return [:]
	}
	var toggleStateCallsCount = 0
	func toggleState() {
		toggleStateCallsCount += 1
	}
	var getProductsCallsCount = 0
	func getProducts() -> [Catalog.Product : Int] {
		getProductsCallsCount += 1
		return [:]
	}
	var getCurrentFilterCallsCount = 0
	func getCurrentFilter() -> Catalog.FilterState {
		getCurrentFilterCallsCount += 1
		return .all
	}
	var getTotalCartPriceCallsCount = 0
	func getTotalCartPrice() -> Double {
		getTotalCartPriceCallsCount += 1
		return 0
	}
}
