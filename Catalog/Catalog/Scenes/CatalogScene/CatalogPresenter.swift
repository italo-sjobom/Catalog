//
//  CatalogPresenter.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import Foundation

protocol CatalogPresenting {
	func presentChart()
	func presentProduct(products: [Product])
	func presentError(description: String)
}

final class CatalogPresenter: CatalogPresenting {
	weak var viewController: CatalogViewController?

	func presentChart() {

	}

	func presentProduct(products: [Product]) {
		viewController?.displayProducts(products: products)
	}

	func presentError(description: String) {
		viewController?.displayError(description: description)
	}
}
