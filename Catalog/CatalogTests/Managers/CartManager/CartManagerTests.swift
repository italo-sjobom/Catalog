//
//  CartManagerTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import XCTest
@testable import Catalog

final class CartManagerTests: XCTestCase {
	typealias Doubles = (
		productsMock: ProductsResponseMock,
		cartManagerMock: CartManagerMock
	)

	func makeSut() -> (CartManager, Doubles) {
		let productsMock = ProductsResponseMock()
		let cartMock = CartManagerMock(products: productsMock.getProducts())

		let sut = CartManager(productsDictionary: cartMock.getProducts())
		let doubles = (productsMock, cartMock)
		return (sut, doubles)
	}

	func testGetInitialFilter_WhenCalled_ShouldReturnInitialFilterAll() throws {
		let (sut, _) = makeSut()
		let filter = sut.getCurrentFilter()
		XCTAssertEqual(filter.stateString(), "All")
	}

	func testToggleFilter_WhenCalled_ShouldToggleFilter() throws {
		let (sut, _) = makeSut()
		let filterBeforeToggle = sut.getCurrentFilter()
		sut.toggleState()
		let filterAfterToggle = sut.getCurrentFilter()
		XCTAssertNotEqual(filterBeforeToggle, filterAfterToggle)
	}

	func testGetProducts_WhenCalled_ShouldReturnAllProducts() throws {
		let (sut, doubles) = makeSut()
		let productsMock = doubles.cartManagerMock.getProducts()
		let products = sut.getProducts()
		XCTAssertEqual(products, productsMock)
	}

	func testAddProduct_WhenCalled_ShouldAddAProduct() throws {
		let (sut, doubles) = makeSut()
		let productsAfterAddition = sut.add(product: doubles.productsMock.getProducts().last!)
		XCTAssertEqual(productsAfterAddition, sut.getProducts())
	}

	func testRemoveProduct_WhenCalled_ShouldRemoveAProductWhenThereIsMoreThanOneProduct() throws {
		let (sut, doubles) = makeSut()
		let productsAfterRemoval = sut.remove(product: doubles.productsMock.getProducts().first!)
		XCTAssertEqual(productsAfterRemoval, sut.getProducts())
	}

	func testRemoveProduct_WhenCalled_ShouldRemoveAProductWhenThereIsOnlyOneProduct() throws {
		let (sut, doubles) = makeSut()
		let productsAfterRemoval = sut.remove(product: doubles.productsMock.getProducts().last!)
		XCTAssertEqual(productsAfterRemoval, sut.getProducts())
	}

	func testDeleteProduct_WhenCalled_ShouldDeleteAProduct() throws {
		let (sut, doubles) = makeSut()
		let productsAfterDeletion = sut.delete(product: doubles.productsMock.getProducts().first!)
		XCTAssertEqual(productsAfterDeletion, sut.getProducts())
	}

	func testCalculateTotalPrice_WhenCalled_ShouldReturnTotalCartPrice() throws {
		let (sut, doubles) = makeSut()
		let productsMockTotalPrice = doubles.cartManagerMock.totalPrice
		let totalPrice = sut.getTotalCartPrice()
		XCTAssertEqual(productsMockTotalPrice, totalPrice)
	}
}
