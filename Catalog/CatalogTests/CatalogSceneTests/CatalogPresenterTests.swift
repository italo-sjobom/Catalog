//
//  CatalogPresenterTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//

import XCTest
@testable import Catalog

final class CatalogPresenterTests: XCTestCase {
	typealias Doubles = (
		viewControllerSpy: CatalogViewControllerSpy,
		cartManagerSpy: CartManagerSpy,
		productsResponseMock: ProductsResponseMock
	)

	func makeSut() -> (CatalogPresenter, Doubles) {
		let sut = CatalogPresenter()
		let viewControllerSpy = CatalogViewControllerSpy()
		let cartManagerSpy = CartManagerSpy()
		let productsMock = ProductsResponseMock()
		let doubles = (viewControllerSpy, cartManagerSpy, productsMock)
		return (sut, doubles)
	}

    func testPresentCart_WhenCalled_ShouldPresentCart() throws {
		let (sut, doubles) = makeSut()
		sut.viewController = doubles.viewControllerSpy
		sut.presentCart(cartManager: doubles.cartManagerSpy)
		XCTAssertEqual(doubles.viewControllerSpy.displaySceneCallsCount, 1)
    }

	func testPresentProducts_WhenCalled_ShouldPresentProducts() throws {
		let (sut, doubles) = makeSut()
		sut.viewController = doubles.viewControllerSpy
		sut.presentProducts(products: doubles.productsResponseMock.products)
		XCTAssertEqual(doubles.viewControllerSpy.displayProductsCallsCount, 1)
	}

	func testPresentError_WhenCalled_ShouldPresentError() throws {
		let (sut, doubles) = makeSut()
		sut.viewController = doubles.viewControllerSpy
		sut.presentError(description: "Error")
		XCTAssertEqual(doubles.viewControllerSpy.displayErrorCallsCount, 1)
	}
}
