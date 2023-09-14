//
//  CartInteractor.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartInteracting {
	func add(product: Product)
	func remove(product: Product)
	func delete(product: Product)
	func open(product: Product)
	func toggleState()
	func calculateTotalCartPrice()
}

final class CartInteractor: CartInteracting {
	private let presenter: CartPresenting
	private let cartManager: CartManaging

	init(presenter: CartPresenting, cartManager: CartManaging) {
		self.presenter = presenter
		self.cartManager = cartManager
	}

	func add(product: Product) {
		presenter.present(products: cartManager.add(product: product))
	}

	func remove(product: Product) {
		presenter.present(products: cartManager.remove(product: product))
	}

	func delete(product: Product) {
		presenter.present(products: cartManager.delete(product: product))
	}

	func open(product: Product) {

	}

	func calculateTotalCartPrice() {
		presenter.presentTotalCartPrice(value: cartManager.getTotalCartPrice())
	}

	func toggleState() {
		presenter.presentFilterButton(title: cartManager.getCurrentFilter().stateString())
		cartManager.toggleState()
		presenter.present(products: cartManager.getProducts())
	}
}
