//
//  CatalogInteractor.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import Foundation

protocol CatalogInteracting {
	func openCart()
	func addToCart(product: Product)
	func openProduct()
	func fetchProducts()
}

final class CatalogInteractor: CatalogInteracting {
	private let presenter: CatalogPresenting
	private let service: CatalogServicing
	private let cartManager: CartManaging

	init(presenter: CatalogPresenting, service: CatalogService, cartManager: CartManaging) {
		self.presenter = presenter
		self.service = service
		self.cartManager = cartManager
	}

	func openCart() {
		presenter.presentCart(cartManager: cartManager)
	}

	func addToCart(product: Product) {
		cartManager.addProduct(product: product)
	}

	func openProduct() {
		//TODO: Chamar a apresentação da scene de detalhamento do produto
	}

	func fetchProducts() {
		service.fetchProducts { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
					case .success(let productResponse):
						self.presenter.presentProduct(products: productResponse.products)
					case .failure(let error):
						self.presenter.presentError(description: error.localizedDescription)
				}
			}
		}
	}

}
