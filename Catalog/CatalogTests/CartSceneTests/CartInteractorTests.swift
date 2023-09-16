//
//  CartInteractorTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import XCTest
@testable import Catalog

final class CartInteractorTests: XCTestCase {
	typealias Doubles = (
		presenterSpy: CartPresenterSpy,
		cartManagerSpy: CartManagerSpy,
		productsResponseMock: ProductsResponseMock
	)

	func makeSut() -> (CartInteractor, Doubles) {
		let presenterSpy = CartPresenterSpy()
		let cartManagerSpy = CartManagerSpy()
		let productsResponseMock = ProductsResponseMock()

		let sut = CartInteractor(presenter: presenterSpy, cartManager: cartManagerSpy)
		let doubles = (presenterSpy, cartManagerSpy, productsResponseMock)
		return (sut, doubles)
	}

	func testAddProduct_WhenCalled_ShouldPresentProducts() throws {
		let (sut, doubles) = makeSut()
		let product = doubles.productsResponseMock.getProducts().first!
		sut.add(product: product)
		XCTAssertEqual(doubles.presenterSpy.presentProductsCallsCount, 1)
	}

	func testRemoveProduct_WhenCalled_ShouldPresentProducts() throws {
		let (sut, doubles) = makeSut()
		let product = doubles.productsResponseMock.getProducts().first!
		sut.remove(product: product)
		XCTAssertEqual(doubles.presenterSpy.presentProductsCallsCount, 1)
	}

	func testDeleteProduct_WhenCalled_ShouldPresentProducts() throws {
		let (sut, doubles) = makeSut()
		let product = doubles.productsResponseMock.getProducts().first!
		sut.delete(product: product)
		XCTAssertEqual(doubles.presenterSpy.presentProductsCallsCount, 1)
	}

	func testToogleState_WhenCalled_ShouldCallPresentFilterButtonAndProducts() throws {
		let (sut, doubles) = makeSut()
		sut.toggleState()
		XCTAssertEqual(doubles.presenterSpy.presentFilterButtonCallsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentProductsCallsCount, 1)
	}

	func testCalculateTotalPrice_WhenCalled_ShouldCallPresentTotalPrice() throws {
		let (sut, doubles) = makeSut()
		sut.calculateTotalCartPrice()
		XCTAssertEqual(doubles.presenterSpy.presentTotalCartPriceCallsCount, 1)
	}
}
