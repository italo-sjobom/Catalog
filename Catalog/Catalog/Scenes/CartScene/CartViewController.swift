//
//  CartViewController.swift
//  Catalog
//
//  Created by Italo Sjobom on 11/09/23.
//

import UIKit

protocol CartDisplaying: AnyObject {
	func displayProducts(products: [Product: Int])
	func displayFilterButton(title: String)
	func displayTotalCartPrice(value: Double)
}

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
		label.text = "TOTAL: R$ "
		label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		return label
	}()
	lazy var filterButton: UIButton = {
		let button = UIButton()
		button.setTitle(LocalizedStrings.getString(for: .onSaleFilter), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .red
		button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
		return button
	}()
	private let interactor: CartInteracting
	private var products: [Product: Int]

	init(interactor: CartInteracting, products: [Product: Int]) {
		self.interactor = interactor
		self.products = products
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Não use storyboards")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = LocalizedStrings.getString(for: .cartScreenTitle)
		configureViews()
		interactor.calculateTotalCartPrice()
	}

	override func loadView() {
		let view = UIView()
		view.backgroundColor = .white
		self.view = view
		activity.stopAnimating()
	}

	@objc func filterAction() {
		interactor.toggleState()
		interactor.calculateTotalCartPrice()
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
		let product = Array<Product>(products.keys)[indexPath.row]
		let productCount = products[product]
		cell.delegate = self
		cell.setupCell(product: product, count: productCount ?? 0)
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
}

//MARK: UI
extension CartViewController {
	private func configureViews() {
		view.addSubview(filterButton)
		view.addSubview(tableView)
		view.addSubview(totalLabel)

		let margins = view.layoutMarginsGuide

		filterButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
		filterButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
		filterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		filterButton.widthAnchor.constraint(equalToConstant: 150).isActive = true

		tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 16).isActive = true
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

//MARK: Displaying
extension CartViewController: CartDisplaying {
	func displayProducts(products: [Product: Int]) {
		self.products = products
		interactor.calculateTotalCartPrice()
		reloadUI()
	}

	func displayFilterButton(title: String) {
		filterButton.setTitle(title, for: .normal)
	}

	func displayTotalCartPrice(value: Double) {
		totalLabel.text = nil
		totalLabel.text = "TOTAL: R$ " + String(format: "%.2f", value)
	}
}

//MARK: ProductCartCellDelegate
extension CartViewController: ProductCartCellDelegate {
	func addToCart(product: Product) {
		interactor.add(product: product)
	}

	func removeFromCart(product: Product) {
		interactor.remove(product: product)
	}

	func deleteFromCart(product: Product) {
		interactor.delete(product: product)
	}
}
