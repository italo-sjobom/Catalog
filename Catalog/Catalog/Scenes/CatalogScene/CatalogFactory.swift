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
		let presenter = CatalogPresenter()
		let interactor = CatalogInteractor(presenter: presenter)
		viewController = CatalogViewController(interactor: interactor)
	}
	static func getViewController() -> UIViewController {
		CatalogFactory.makeScene()
		return viewController ?? UIViewController()
	}
}
