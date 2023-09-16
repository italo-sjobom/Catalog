//
//  CatalogServiceTests.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import XCTest
@testable import Catalog

final class CatalogServiceTests: XCTestCase {
	typealias Doubles = (
		netWorkingMock: CatalogNetworkingMock,
		cartManagerMock: CartManagerMock,
		productsResponseMock: ProductsResponseMock
	)

	func makeSut() -> (CatalogService, Doubles) {
		let netWorkingMock = CatalogNetworkingMock()
		let productsMock = ProductsResponseMock()
		let cartManagerMock = CartManagerMock(products: productsMock.getProducts())
		let sut = CatalogService(networking: netWorkingMock)
		let doubles = (netWorkingMock, cartManagerMock, productsMock)
		return (sut, doubles)
	}

	func testFetchProducts_WhenSuccess_ShouldReturnContactsList() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .success(doubles.productsResponseMock.products))
		XCTAssertEqual(expectedResult, .success(doubles.productsResponseMock.products))
	}

	func testFetchProducts_WhenFailure_ShouldReturnDecodedError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.decodedError(errorDescription: "Error de decoder")))
		XCTAssertEqual(expectedResult, .failure(.decodedError(errorDescription: "Error de decoder")))
	}

	func testFetchProducts_WhenFailure_ShouldReturnInvalidApiUrlError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.invalidApiUrl))
		XCTAssertEqual(expectedResult, .failure(.invalidApiUrl))
	}

	func testFetchProducts_WhenFailure_ShouldReturnInvalidDataError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.invalidData))
		XCTAssertEqual(expectedResult, .failure(.invalidData))
	}

	func testFetchProducts_WhenFailure_ShouldReturnInvalidResponseError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.invalidResponse))
		XCTAssertEqual(expectedResult, .failure(.invalidResponse))
	}

	func testFetchProducts_WhenFailure_ShouldReturnRequestError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.requestError(errorDescription: "Erro na request")))
		XCTAssertEqual(expectedResult, .failure(.requestError(errorDescription: "Erro na request")))
	}

	func testFetchProducts_WhenFailure_ShouldReturnResponseError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.responseError(code: 401)))
		XCTAssertEqual(expectedResult, .failure(.responseError(code: 401)))
	}

	func testFetchProducts_WhenFailure_ShouldReturnSessionError() {
		let (sut, doubles) = makeSut()
		var expectedResult: Result<[Product], CustomError>?
		sut.fetchProducts { result in
			expectedResult = result
		}
		doubles.netWorkingMock.complete(with: .failure(.sessionError(message: "Erro na session")))
		XCTAssertEqual(expectedResult, .failure(.sessionError(message: "Erro na session")))
	}
}
