//
//  CartInteractor.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartInteracting {
	func addProduct(product: Product)
	func removeProduct(product: Product)
	func openProduct(product: Product)
	func toggleState()
}

final class CartInteractor: CartInteracting {
	private let presenter: CartPresenting
	private let cartManager: CartManaging

	init(presenter: CartPresenting, cartManager: CartManaging) {
		self.presenter = presenter
		self.cartManager = cartManager
	}

	func addProduct(product: Product) {
		cartManager.addProduct(product: product)
	}

	func removeProduct(product: Product) {
		cartManager.removeProduct(product: product)
	}

	func openProduct(product: Product) {

	}

	func toggleState() {
		presenter.presentFilterButton(title: cartManager.getCurrentFilter().stateString())
		cartManager.toggleState()
		presenter.presentFilteredProducts(products: cartManager.getProducts())
	}
}
