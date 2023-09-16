//
//  CatalogViewControllerSpy.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//

@testable import Catalog
import UIKit

final class CatalogViewControllerSpy: CatalogDisplaying {
	var displayProductsCallsCount = 0
	func displayProducts(products: [Catalog.Product]) {
		displayProductsCallsCount += 1
	}

	var displayErrorCallsCount = 0
	func displayError(description: String) {
		displayErrorCallsCount += 1
	}

	var displaySceneCallsCount = 0
	func displayScene(viewController: UIViewController) {
		displaySceneCallsCount += 1
	}
}

