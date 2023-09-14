//
//  CartPresenter.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartPresenting {
	func present(product: Product)
	func present(products: [Product])
	func presentFilterButton(title: String)
	func presentTotalCartPrice(value: Double)
}

final class CartPresenter: CartPresenting {
	weak var viewController: CartViewController?
	
	func present(product: Product) {
		
	}

	func present(products: [Product]) {
		viewController?.displayProducts(products: products)
	}

	func presentFilterButton(title: String) {
		viewController?.displayFilterButton(title: title)
	}

	func presentTotalCartPrice(value: Double) {
		viewController?.displayTotalCartPrice(value: value)
	}
}
