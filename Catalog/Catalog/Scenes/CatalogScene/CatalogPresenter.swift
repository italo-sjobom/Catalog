//
//  CatalogPresenter.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import Foundation

protocol CatalogPresenting {
	func presentCart(cartManager: CartManaging)
	func presentProducts(products: [Product])
	func presentError(description: String)
}

final class CatalogPresenter: CatalogPresenting {
	weak var viewController: CatalogDisplaying?

	func presentCart(cartManager: CartManaging) {
		viewController?.displayScene(viewController: CartFactory.makeScene(cartManager: cartManager))
	}

	func presentProducts(products: [Product]) {
		viewController?.displayProducts(products: products)
	}

	func presentError(description: String) {
		viewController?.displayError(description: description)
	}
}
