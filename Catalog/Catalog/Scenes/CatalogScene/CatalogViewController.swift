//
//  CatalogViewController.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

class CatalogViewController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundView = activity
		tableView.register(ProductCell.self, forCellReuseIdentifier: String(describing: ProductCell.self))
		tableView.rowHeight = 120
		tableView.tableFooterView = UIView()
		return tableView
	}()
	lazy var activity: UIActivityIndicatorView = {
		let activity = UIActivityIndicatorView()
		activity.startAnimating()
		activity.hidesWhenStopped = true
		return activity
	}()
	var products: [Product] = []

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Catalog"
		configureViews()
		loadData()
	}

	override func loadView() {
		let view = UIView()
		view.backgroundColor = .white
		self.view = view
	}

	func configureViews() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
	}

	func loadData() {
		let service = CatalogService()
		service.fetchProducts { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
					case .success(let products):
						print(products)
						self.products = products.products
						self.tableView.reloadData()
						self.activity.stopAnimating()
					case .failure(let error):
						print(error)
						self.tableView.reloadData()
						self.activity.stopAnimating()
				}
			}
		}
	}

}

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
			return UITableViewCell()
		}

		let product = products[indexPath.row]
		cell.setupCell(name: product.name, imageURL: product.imageURL ?? "")

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}
