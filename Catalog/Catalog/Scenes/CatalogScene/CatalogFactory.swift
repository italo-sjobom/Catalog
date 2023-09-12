//
//  CatalogFactory.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

protocol CatalogFactoring {
	static var viewController: CatalogViewController? { get set }
	static func makeScene() -> UIViewController
}

final class CatalogFactory: CatalogFactoring {
	static var viewController: CatalogViewController?

	static func makeScene() -> UIViewController {
		let cartManager = CartManager.shared
		let service = CatalogService()
		let presenter = CatalogPresenter()
		let interactor = CatalogInteractor(presenter: presenter, service: service, cartManager: cartManager)
		viewController = CatalogViewController(interactor: interactor)
		presenter.viewController = viewController
		return viewController ?? UIViewController()
	}
}
