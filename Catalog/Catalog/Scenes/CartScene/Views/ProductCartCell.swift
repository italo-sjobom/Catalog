//
//  ProductCartCell.swift
//  Catalog
//
//  Created by Italo Sjobom on 12/09/23.
//

import UIKit

protocol ProductCartCellDelegate: AnyObject {
	func addToCart(product: Product)
	func removeFromCart(product: Product)
	func deleteFromCart(product: Product)
}

class ProductCartCell: ProductCell {
	lazy var countLabel: UILabel = UILabel.getUILabel(fontSize: 14, fontWeight: .regular)
	lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalCentering
		stackView.addArrangedSubview(countLabel)
		stackView.addArrangedSubview(addButton)
		return stackView
	}()
	lazy var addButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
		button.setImage(UIImage(systemName: "plus.circle.fill"), for: .highlighted)
		button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
		return button
	}()
	lazy var removeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
		button.setImage(UIImage(systemName: "minus.circle.fill"), for: .highlighted)
		button.addTarget(self, action: #selector(removeFromCart), for: .touchUpInside)
		return button
	}()
	lazy var deleteButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "trash.circle"), for: .normal)
		button.setImage(UIImage(systemName: "trash.circle.fill"), for: .highlighted)
		button.addTarget(self, action: #selector(deleteFromCart), for: .touchUpInside)
		return button
	}()

	@objc func addToCart() {
		delegate?.addToCart(product: product!)
	}

	@objc func removeFromCart() {
		delegate?.removeFromCart(product: product!)
	}

	@objc func deleteFromCart() {
		delegate?.deleteFromCart(product: product!)
	}

	weak var delegate: ProductCartCellDelegate?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configureViews()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}

	override func configureViews() {
		super.configureViews()
		infoStackView.addArrangedSubview(buttonStackView)
		sideButtonStackView.addArrangedSubview(deleteButton)
	}

	func setupCell(product: Product, count: Int) {
		super.setupCell(product: product)
		setupImage(urlString: product.imageURL ?? "")
		countLabel.text = String(count)
		if count == 1 {
			removeButton.removeFromSuperview()
			buttonStackView.insertArrangedSubview(deleteButton, at: 0)
		} else {
			deleteButton.removeFromSuperview()
			buttonStackView.insertArrangedSubview(removeButton, at: 0)
		}
		sideButton.setImage(UIImage(systemName: "trash"), for: .normal)
		sideButton.setImage(UIImage(systemName: "trash.fill"), for: .highlighted)
		sideButton.addTarget(self, action: #selector(deleteFromCart), for: .touchUpInside)
	}
}

