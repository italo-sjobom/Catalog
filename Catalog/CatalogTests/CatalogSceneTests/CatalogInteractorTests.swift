//
//  CatalogInteractorTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 14/09/23.
//

import XCTest
@testable import Catalog

final class CatalogInteractorTests: XCTestCase {
	typealias Doubles = (
		serviceMock: CatalogServiceMock,
		productsResponseMock: ProductsResponseMock,
		presenterSpy: CatalogPresenterSpy,
		cartManagerSpy: CartManagerSpy
	)

	func makeSut() -> (CatalogInteractor, Doubles) {
		let serviceMock = CatalogServiceMock()
		let productResponseMock = ProductsResponseMock()
		let presenterSpy = CatalogPresenterSpy()
		let cartManagerSpy = CartManagerSpy()

		let sut = CatalogInteractor(presenter: presenterSpy, service: serviceMock, cartManager: cartManagerSpy)
		let doubles = (serviceMock, productResponseMock, presenterSpy, cartManagerSpy)
		return (sut, doubles)
	}
	
    func testFetchProducts_WhenCalled_ShouldReturnSuccess() throws {
        let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.success(doubles.productsResponseMock.products))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentProductCallsCount, 1)
    }

	func testFetchProducts_WhenCalled_ShouldReturnFailureWithApiError() throws {
		let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.failure(.invalidApiUrl))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentErrorCallsCount, 1)
	}

	func testFetchProducts_WhenCalled_ShouldReturnFailureWithDecodedError() throws {
		let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.failure(.decodedError(errorDescription: "Erro no Decode")))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentErrorCallsCount, 1)
	}

	func testFetchProducts_WhenCalled_ShouldReturnFailureWithInvalidDataError() throws {
		let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.failure(.invalidData))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentErrorCallsCount, 1)
	}

	func testFetchProducts_WhenCalled_ShouldReturnFailureWithInvalidResponseError() throws {
		let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.failure(.invalidResponse))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentErrorCallsCount, 1)
	}

	func testFetchProducts_WhenCalled_ShouldReturnFailureWithInvalidSessionError() throws {
		let (sut, doubles) = makeSut()
		doubles.serviceMock.fetchProductsCompletion = { completion in
			completion(.failure(.sessionError(message: "Erro na session")))
		}
		sut.fetchProducts()
		XCTAssertEqual(doubles.serviceMock.fetchProductsCount, 1)
		XCTAssertEqual(doubles.presenterSpy.presentErrorCallsCount, 1)
	}

	func testOpenCart_WhenCalled_ShouldOpen() throws {
		let (sut, doubles) = makeSut()
		sut.openCart()
		XCTAssertEqual(doubles.presenterSpy.presentCartCallsCount, 1)
	}

	func testAddToCart_WhenCalled_ShouldAddAProduct() throws {
		let (sut, doubles) = makeSut()
		sut.addToCart(product: doubles.productsResponseMock.getProducts().randomElement()!)
		XCTAssertEqual(doubles.cartManagerSpy.addCallsCount, 1)
	}
}
