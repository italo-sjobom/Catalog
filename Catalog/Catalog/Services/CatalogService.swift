//
//  CatalogService.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//
import Foundation

private let apiURL = "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"

protocol CatalogServicing {
	func fetchProducts(completion: @escaping (Result<Products, CustomError>) -> Void)
}

class CatalogService: CatalogServicing {
	let session: URLSession
	let url: String

	init(session: URLSession = URLSession.shared, url: String = apiURL) {
		self.session = session
		self.url = url
	}

	func fetchProducts(completion: @escaping (Result<Products, CustomError>) -> Void) {
		guard let api = URL(string: url) else {
			return completion(.failure(.invalidApi))
		}

		let task = session.dataTask(with: api) { (data, response, error) in
			if let error = error {
				completion(.failure(.sessionError(message: error.localizedDescription)))
			}

			if let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode {
				return completion(.failure(.responseError(code: httpResponse.statusCode)))
			}

			guard let jsonData = data else {
				return completion(.failure(.invalidData))
			}

			do {
				let decoder = JSONDecoder()
				let decoded = try decoder.decode(Products.self, from: jsonData)
				completion(.success(decoded))
			} catch {
				completion(.failure(.decodedError(error)))
			}
		}

		task.resume()
	}
}

enum CustomError: Error {
	case decodedError(Error)
	case invalidApi
	case invalidData
	case responseError(code: Int)
	case sessionError(message: String)
}
