//
//  CatalogViewController.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

protocol CatalogDisplaying: AnyObject {
	func displayProducts(products: [Product])
	func displayError(description: String)
	func displayScene(viewController: UIViewController)
}

final class CatalogViewController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundView = activity
		tableView.register(ProductCatalogCell.self, forCellReuseIdentifier: String(describing: ProductCatalogCell.self))
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
	let interactor: CatalogInteracting

	init(interactor: CatalogInteracting) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("Não use storyboards")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = LocalizedStrings.getString(for: .catalogScreenTitle)
		configureViews()
		loadData()
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(openCart))
	}

	override func loadView() {
		let view = UIView()
		view.backgroundColor = .white
		self.view = view
	}
}

//MARK: UITableViewDataSource and UITableViewDelegate
extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCatalogCell.self), for: indexPath) as? ProductCatalogCell else {
			return UITableViewCell()
		}

		let product = products[indexPath.row]
		cell.delegate = self
		cell.setupCell(product: product)

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//TODO: Disparar a lógica para a abertura da scene de detalhamento do produto
	}
}

//MARK: Displaying
extension CatalogViewController: CatalogDisplaying {
	func displayProducts(products: [Product]) {
		DispatchQueue.main.async { [weak self] in
			self?.products = products
			self?.reloadUI()
		}
	}

	func displayError(description: String) {
		DispatchQueue.main.async { [weak self] in
			self?.displayAlert(title: LocalizedStrings.getString(for: .errorAlertTitle), message: description)
			self?.reloadUI()
		}
	}

	func displayScene(viewController: UIViewController) {
		navigationController?.pushViewController(viewController, animated: true)
	}
}

//MARK: Actions
extension CatalogViewController {
	@objc func openCart() {
		interactor.openCart()
	}
}

//MARK: UI
extension CatalogViewController {
	private func configureViews() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
	}

	private func reloadUI() {
		tableView.reloadData()
		activity.stopAnimating()
	}

	private func displayAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: LocalizedStrings.getString(for: .okButton), style: .default, handler: nil))
		present(alert, animated: true)
	}
}

//MARK: Data
extension CatalogViewController {
	private func loadData() {
		interactor.fetchProducts()
	}
}

//MARK: ProductCell
extension CatalogViewController: ProductCellDelegate {
	func addToCart(product: Product) {
		interactor.addToCart(product: product)
	}
}
