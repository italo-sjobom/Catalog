//
//  CatalogRequestMapper.swift
//  Catalog
//
//  Created by Italo Sjobom on 16/09/23.
//

import Foundation

protocol CatalogRequestMapping {
	func mapRequest(data: Data?, response: URLResponse?, error: Error?) -> Result<[Product], CustomError>
}

final class CatalogRequestMapper: CatalogRequestMapping {
	func mapRequest(data: Data?, response: URLResponse?, error: Error?) -> Result<[Product], CustomError> {
		if let error = error {
			return .failure(.requestError(errorDescription: error.localizedDescription))
		}

		if let httpResponse = response as? HTTPURLResponse {
			guard 200...299 ~= httpResponse.statusCode else {
				return .failure(.responseError(code: httpResponse.statusCode))
			}
		} else {
			return .failure(.invalidResponse)
		}

		guard let jsonData = data else {
			return .failure(.invalidData)
		}

		do {
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(ProductsResponse.self, from: jsonData)
			return .success(decoded.products)
		} catch {
			return.failure(.decodedError(errorDescription: error.localizedDescription))
		}
	}
}
