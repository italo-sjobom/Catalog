//
//  CartFactory.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import UIKit

protocol CartFactoring {
	static var viewController: CatalogViewController? { get set }
	static func makeScene()
}

final class CartFactory {
	private static var viewController: CartViewController?

	static func makeScene(cartManager: CartManaging) -> UIViewController {
		let presenter = CartPresenter()
		let interactor = CartInteractor(presenter: presenter, cartManager: cartManager)
		viewController = CartViewController(interactor: interactor, products: cartManager.getProducts())
		presenter.viewController = viewController
		return viewController ?? UIViewController()
	}
}
