//
//  CatalogInteractor.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import Foundation

protocol CatalogInteracting {
	func openChart()
	func addToChart()
	func openProduct()
}

final class CatalogInteractor: CatalogInteracting {
	private let presenter: CatalogPresenting

	init(presenter: CatalogPresenting) {
		self.presenter = presenter
	}

	init() {
		self.presenter = CatalogPresenter()
	}

	func openChart() {

	}

	func addToChart() {

	}

	func openProduct() {

	}


}
