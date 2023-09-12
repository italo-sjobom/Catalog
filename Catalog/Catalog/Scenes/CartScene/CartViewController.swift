//
//  CartViewController.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import UIKit

final class CartViewController: UIViewController {
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundView = activity
		tableView.register(ProductCartCell.self, forCellReuseIdentifier: String(describing: ProductCartCell.self))
		tableView.rowHeight = 120
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .cyan
		return tableView
	}()
	lazy var activity: UIActivityIndicatorView = {
		let activity = UIActivityIndicatorView()
		activity.startAnimating()
		activity.hidesWhenStopped = true
		return activity
	}()
	lazy var totalLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "TOTAL: R$"
		label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		label.backgroundColor = .blue
		return label
	}()
	lazy var filterOnSale: UIButton = {
		let button = UIButton()
		button.setTitle("On Sale", for: .normal)
		button.setTitle("All products", for: .selected)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .red
		return button
	}()
	private let interactor: CartInteracting
	private let products: [Product]

	init(interactor: CartInteracting, products: [Product]) {
		self.interactor = interactor
		self.products = products
		products.forEach { p in
			print(p.name)
		}
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Não use storyboards")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Cart"
		configureViews()
	}

	override func loadView() {
		let view = UIView()
		view.backgroundColor = .white
		self.view = view
		activity.stopAnimating()
	}
}

//MARK: UITableViewDataSource e UITableViewDelegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCartCell.self), for: indexPath) as? ProductCartCell else {
			return UITableViewCell()
		}

		let product = products[indexPath.row]
		cell.delegate = self
		cell.setupCell(product: product)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
}

//MARK: UI
extension CartViewController {
	private func configureViews() {
		view.addSubview(filterOnSale)
		view.addSubview(tableView)
		view.addSubview(totalLabel)

		let margins = view.layoutMarginsGuide

		filterOnSale.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
		filterOnSale.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
		filterOnSale.heightAnchor.constraint(equalToConstant: 50).isActive = true
		filterOnSale.widthAnchor.constraint(equalToConstant: 150).isActive = true

		tableView.topAnchor.constraint(equalTo: filterOnSale.bottomAnchor, constant: 16).isActive = true
		tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 420).isActive = true

		totalLabel.bottomAnchor.constraint(greaterThanOrEqualTo: margins.bottomAnchor, constant: -100).isActive = true
		totalLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -0).isActive = true
		totalLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
		totalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		totalLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
	}

	private func reloadUI() {
		tableView.reloadData()
		activity.stopAnimating()
	}
}

extension CartViewController: ProductCartCellDelegate {
	func addToCart(product: Product) {
		interactor.addProduct()
	}

	func removeFromCart(product: Product) {
		interactor.removeProduct()
	}

	func deleteFromCart(product: Product) {
	}


}
