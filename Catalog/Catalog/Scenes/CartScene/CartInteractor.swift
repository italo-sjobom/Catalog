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
	private let cartManager: CartManaging

	init(presenter: CartPresenting, cartManager: CartManaging) {
		self.presenter = presenter
		self.cartManager = cartManager
	}

	func addProduct() {
		
	}

	func removeProduct() {

	}

	func openProduct() {

	}
}
