//
//  CatalogNetworkingMock.swift
//  CatalogTests
//
//  Created by Italo Sjobom on 16/09/23.
//

import Foundation
@testable import Catalog

final class CatalogNetworkingMock: CatalogNetworking {
	private var capturedCompletion: ((Result<[Product], CustomError>) -> Void)?

	func makeRequest(_ urlString: String, _ session: URLSession, _ jsonDecoder: JSONDecoder, completion: @escaping (Result<[Product], CustomError>) -> Void) {
		capturedCompletion = completion
	}

	func complete(with result: Result<[Product], CustomError>) {
		capturedCompletion?(result)
	}
}
