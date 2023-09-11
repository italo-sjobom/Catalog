//
//  CartInteractor.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartInteracting {
	func addProduct()
	func removeProduct()
	func openProduct()
}

final class CartInteractor: CartInteracting {
	private let presenter: CartPresenting

	init(presenter: CartPresenting) {
		self.presenter = presenter
	}

	func addProduct() {

	}

	func removeProduct() {

	}

	func openProduct() {

	}
}
