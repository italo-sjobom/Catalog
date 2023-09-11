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
	func fetchProducts()
}

final class CatalogInteractor: CatalogInteracting {
	private let presenter: CatalogPresenting
	private let service: CatalogServicing

	init(presenter: CatalogPresenting, service: CatalogService) {
		self.presenter = presenter
		self.service = service
	}

	func openChart() {

	}

	func addToChart() {

	}

	func openProduct() {

	}

	func fetchProducts() {
		service.fetchProducts { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
					case .success(let productResponse):
						print(productResponse)
						self.presenter.presentProduct(products: productResponse.products)
					case .failure(let error):
						print(error)
						self.presenter.presentError(description: error.localizedDescription)
				}
			}
		}
	}

}
