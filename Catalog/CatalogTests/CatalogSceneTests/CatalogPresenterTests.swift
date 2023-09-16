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
		interactorSpy: CatalogInteractorSpy,
		cartManagerSpy: CartManagerSpy,
		productsResponseMock: ProductsResponseMock
	)

	func makeSut() -> (CatalogPresenter, Doubles) {
		let interactorSpy = CatalogInteractorSpy()
		let sut = CatalogPresenter()
		let viewControllerSpy = CatalogViewControllerSpy()
		let cartManagerSpy = CartManagerSpy()
		let productsMock = ProductsResponseMock()
		let doubles = (viewControllerSpy, interactorSpy, cartManagerSpy, productsMock)
		return (sut, doubles)
	}

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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


	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
}
