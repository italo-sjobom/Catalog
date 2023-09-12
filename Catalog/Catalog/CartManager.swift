//
//  CartManager.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartManaging {
	func addProduct(product: Product)
	func deleteProduct(product: Product)
	func getProducts() -> [Product]
}

class CartManager: CartManaging {
	private var products: [Product]
	static public var shared = CartManager()

	init(products: [Product] = []) {
		self.products = products
	}

	func addProduct(product: Product) {
		products.append(product)
		print("Product added: ", product.name)
	}

	func deleteProduct(product: Product) {
		products.removeAll { product in
			return product == product
		}
	}

	func getProducts() -> [Product] {
		return products
	}

}
