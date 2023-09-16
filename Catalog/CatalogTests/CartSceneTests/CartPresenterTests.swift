//
//  CartPresenterTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import XCTest
@testable import Catalog

final class CartPresenterTests: XCTestCase {
	typealias Doubles = (
		viewControllerSpy: CartViewControllerSpy,
		cartManagerSpy: CartManagerSpy,
		cartManagerMock: CartManagerMock
	)

	func makeSut() -> (CartPresenter, Doubles) {
		let sut = CartPresenter()
		let viewControllerSpy = CartViewControllerSpy()
		sut.viewController = viewControllerSpy
		let cartManagerSpy = CartManagerSpy()
		let productsMock = ProductsResponseMock()
		let cartMock = CartManagerMock(products: productsMock.getProducts())
		let doubles = (viewControllerSpy, cartManagerSpy, cartMock)
		return (sut, doubles)
	}

	func testPresentProduct_WhenCalled_ShouldDisplayProducts() throws {
		let (sut, doubles) = makeSut()
		let products = doubles.cartManagerMock.getProducts()
		sut.present(products: products)
		XCTAssertEqual(doubles.viewControllerSpy.displayProductsCallsCount, 1)
	}

	func testPresentFilterButton_WhenCalled_ShouldDisplayFilterButton() throws {
		let (sut, doubles) = makeSut()
		sut.presentFilterButton(title: "All")
		XCTAssertEqual(doubles.viewControllerSpy.displayFilterButtonCallsCount, 1)
	}

	func testPresentTotalCartPrice_WhenCalled_ShouldDisplayTotalCartPrice() throws {
		let (sut, doubles) = makeSut()
		sut.presentTotalCartPrice(value: 123)
		XCTAssertEqual(doubles.viewControllerSpy.displayTotalCartPriceCallsCount, 1)
	}
}
