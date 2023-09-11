//
//  CartPresenter.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import Foundation

protocol CartPresenting {
	func presentProduct()
}

final class CartPresenter: CartPresenting {
	weak var viewController: CartViewController?
	
	func presentProduct() {

	}
}
