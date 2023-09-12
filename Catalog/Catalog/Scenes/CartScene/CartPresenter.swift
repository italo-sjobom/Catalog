//
//  CartPresenter.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartPresenting {
	func presentProduct()
	func presentFilteredProducts(products: [Product])
	func presentFilterButton(title: String)
}

final class CartPresenter: CartPresenting {
	weak var viewController: CartViewController?
	
	func presentProduct() {
		
	}

	func presentFilteredProducts(products: [Product]) {
		viewController?.displayProducts(products: products)
	}

	func presentFilterButton(title: String) {
		viewController?.displayFilterButton(title: title)
	}
}
