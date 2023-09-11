//
//  CatalogFactory.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

enum CatalogFactory {
	static func make() -> UIViewController {
		let presenter = CatalogPresenter()
		let interactor = CatalogInteractor(presenter: presenter)
		let viewController = CatalogViewController(interactor: interactor)
		return viewController
	}
}
