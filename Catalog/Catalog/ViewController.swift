//
//  ViewController.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

class ViewController: UIViewController {


	override func viewDidLoad() {
		super.viewDidLoad()
		let service = CatalogService()
		service.fetchProducts { result in
			DispatchQueue.main.async {
				switch result {
					case .success(let products):
						print(products)
					case .failure(let error):
						print(error)
				}
			}
		}
	}


}

