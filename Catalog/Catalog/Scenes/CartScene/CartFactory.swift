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
	static func getViewController() -> UIViewController
}

final class CartFactory {
	private static var viewController: CartViewController?

	private static func makeScene() {
		let presenter = CartPresenter()
		let interactor = CartInteractor(presenter: presenter)
		viewController = CartViewController(interactor: interactor)
		presenter.viewController = viewController
	}
	static func getViewController() -> UIViewController {
		CartFactory.makeScene()
		return viewController ?? UIViewController()
	}
}
