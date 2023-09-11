//
//  CatalogFactory.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

final class CatalogFactory {
	private static var viewController: CatalogViewController?

	private static func makeScene() {
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
