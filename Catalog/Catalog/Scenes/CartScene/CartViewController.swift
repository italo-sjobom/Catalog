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
	private let interactor: CartInteracting
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	init(interactor: CartInteracting) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("Não use storyboards")
	}
	
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
