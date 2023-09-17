//
//  ProductsResponse.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//
import Foundation

protocol ProductsResponsing: Codable {
	var products: [Product] { get }
}

struct ProductsResponse: ProductsResponsing {
	var products: [Product]
}

