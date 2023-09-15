//
//  CatalogServiceMock.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 15/09/23.
//

@testable import Catalog

final class CatalogServiceMock: CatalogServicing {
	private(set) var fetchProductsCount = 0
	typealias FetchProductsCompletion = (Result<ProductsResponsing, CustomError>) -> Void
	var fetchProductsCompletion: ((@escaping FetchProductsCompletion) -> Void)?
	func fetchProducts(completion: @escaping (Result<ProductsResponsing, CustomError>) -> Void) {
		fetchProductsCount += 1
		fetchProductsCompletion?(completion)
	}
}
