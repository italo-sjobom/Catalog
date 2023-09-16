//
//  CatalogNetwork.swift
//  Catalog
//
//  Created by Italo Sjobom on 16/09/23.
//

import Foundation

protocol CatalogNetworking {
	func makeRequest(_ urlString: String,_ session: URLSession,_ jsonDecoder: JSONDecoder, completion: @escaping (Result<[Product], CustomError>) -> Void)
}

final class CatalogNetwork: CatalogNetworking {
	private let requestMapper: CatalogRequestMapping

	init(requestMapper: CatalogRequestMapping = CatalogRequestMapper()) {
		self.requestMapper = requestMapper
	}

	func makeRequest(_ urlString: String,_ session: URLSession,_ jsonDecoder: JSONDecoder, completion: @escaping (Result<[Product], CustomError>) -> Void) {
		guard let url = URL(string: urlString) else {
			return completion(.failure(.invalidApiUrl))
		}

		let task = session.dataTask(with: url) { [requestMapper] (data, response, error) in
			completion(requestMapper.mapRequest(data: data, response: response, error: error))
		}
		task.resume()
	}
}

enum CustomError: Error, Equatable {
	case decodedError(errorDescription: String)
	case invalidApiUrl
	case invalidData
	case invalidResponse
	case requestError(errorDescription: String)
	case responseError(code: Int)
	case sessionError(message: String)


	static func == (lhs: CustomError, rhs: CustomError) -> Bool {
		switch (lhs, rhs) {
			case (.decodedError, decodedError),
				(.invalidApiUrl, .invalidApiUrl),
				(.invalidData, .invalidData),
				(.invalidResponse, .invalidResponse),
				(.requestError, .requestError),
				(.responseError, .responseError),
				(.sessionError, .sessionError):
				return true
			default:
				return false
		}
	}

}
