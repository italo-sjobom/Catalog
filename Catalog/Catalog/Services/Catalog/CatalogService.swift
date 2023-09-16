//
//  CatalogService.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//
import Foundation

private let apiURL = "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"

protocol CatalogServicing {
	func fetchProducts(completion: @escaping (Result<[Product], CustomError>) -> Void)
}

class CatalogService: CatalogServicing {
	private let networking: CatalogNetworking
	private let session: URLSession
	private let jsonDecoder: JSONDecoder
	private let urlString: String

	init(networking: CatalogNetworking = CatalogNetwork(),
		 session: URLSession = .shared,
		 jsonDecoder: JSONDecoder = JSONDecoder(),
		 urlString: String = apiURL) {
		self.networking = networking
		self.session = session
		self.jsonDecoder = jsonDecoder
		self.urlString = urlString
	}

	func fetchProducts(completion: @escaping (Result<[Product], CustomError>) -> Void) {
		networking.makeRequest(urlString, session, jsonDecoder) { result in
			completion(result)
		}
	}
}
