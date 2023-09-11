//
//  CatalogFactory.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

protocol CatalogFactoring {
	static var viewController: CatalogViewController? { get set }
	static func makeScene()
	static func getViewController() -> UIViewController
}

final class CatalogFactory: CatalogFactoring {
	static var viewController: CatalogViewController?

	static func makeScene() {
		let service = CatalogService()
		let presenter = CatalogPresenter()
		let interactor = CatalogInteractor(presenter: presenter, service: service)
		viewController = CatalogViewController(interactor: interactor)
		presenter.viewController = viewController
	}
	static func getViewController() -> UIViewController {
		CatalogFactory.makeScene()
		return viewController ?? UIViewController()
	}
}
