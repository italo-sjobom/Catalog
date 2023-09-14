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

class ProductCartCell: UITableViewCell {
	lazy var nameLabel: UILabel = UILabel.getUILabel(fontSize: 12, fontWeight: .regular)
	lazy var priceLabel: UILabel = UILabel.getUILabel(fontSize: 10, fontWeight: .regular)
	lazy var countLabel: UILabel = UILabel.getUILabel(fontSize: 14, fontWeight: .regular)
	lazy var promotionalPriceLabel: UILabel = UILabel.getUILabel(fontSize: 10, fontWeight: .bold)
	lazy var productImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	lazy var infoStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .fillEqually
		stackView.addArrangedSubview(nameLabel)
		stackView.addArrangedSubview(priceStackView)
		stackView.addArrangedSubview(buttonStackView)
		return stackView
	}()
	lazy var priceStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .fillEqually
		stackView.spacing = 4
		stackView.addArrangedSubview(priceLabel)
		stackView.addArrangedSubview(promotionalPriceLabel)
		return stackView
	}()
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
	lazy var deleteButtonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(deleteButton)
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
	lazy var deleteStackButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "trash.circle"), for: .normal)
		button.setImage(UIImage(systemName: "trash.circle.fill"), for: .highlighted)
		button.addTarget(self, action: #selector(deleteFromCart), for: .touchUpInside)
		return button
	}()
	lazy var deleteButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "trash"), for: .normal)
		button.setImage(UIImage(systemName: "trash.fill"), for: .highlighted)
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

	private var task: URLSessionDataTask?
	private var product: Product!
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
		nameLabel.text = ""
		priceLabel.attributedText = NSAttributedString(string: "")
		promotionalPriceLabel.text = ""
		task?.cancel()
	}

	func configureViews() {
		contentView.addSubview(productImageView)
		contentView.addSubview(infoStackView)
		contentView.addSubview(deleteButtonStackView)

		productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		productImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

		infoStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
		infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

		deleteButtonStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: 4).isActive = true
		deleteButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
		deleteButtonStackView.widthAnchor.constraint(equalToConstant: 40).isActive = true
		deleteButtonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		deleteButtonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}

	func setupCell(product: Product, count: Int) {
		nameLabel.text = product.name
		priceLabel.text = product.onSale ? product.promotionalPrice : product.price
		if product.onSale {
			promotionalPriceLabel.text = product.promotionalPrice
			priceLabel.attributedText = NSAttributedString.getStrikethroughAttributedString(string: product.price, widthLine: 1)
		}
		setupImage(urlString: product.imageURL ?? "")
		countLabel.text = String(count)
		self.product = product
		if count == 1 {
			removeButton.removeFromSuperview()
			buttonStackView.insertArrangedSubview(deleteStackButton, at: 0)
		} else {
			deleteStackButton.removeFromSuperview()
			buttonStackView.insertArrangedSubview(removeButton, at: 0)
		}
	}

	private func setupImage(urlString: String) {
		if let url = URL(string: urlString) {
			task = URLSession.shared.dataTask(with: url) { data, _, error in
				if error == nil, let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async { [weak self] in
						self?.productImageView.image = image
					}
				}
			}
			task?.resume()
		}
	}
}

