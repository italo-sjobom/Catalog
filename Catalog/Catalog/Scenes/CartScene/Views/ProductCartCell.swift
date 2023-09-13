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
	lazy var nameLabel: UILabel = getUILabel(fontSize: 12, fontWeight: .regular)
	lazy var priceLabel: UILabel = getUILabel(fontSize: 10, fontWeight: .regular)
	lazy var countLabel: UILabel = getUILabel(fontSize: 14, fontWeight: .regular)
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
		stackView.distribution = .fill
		stackView.spacing = 4
		stackView.addArrangedSubview(priceLabel)
		return stackView
	}()
	lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(removeButton)
		stackView.addArrangedSubview(countLabel)
		stackView.addArrangedSubview(addButton)
		stackView.backgroundColor = .red
		return stackView
	}()
	lazy var addButton: UIButton = {
		let button = UIButton()
		button.setTitle("+", for: .normal)
		button.backgroundColor = .blue
		button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
		return button
	}()
	lazy var removeButton: UIButton = {
		let button = UIButton()
		button.setTitle("-", for: .normal)
		button.backgroundColor = .blue
		button.addTarget(self, action: #selector(removeFromCart), for: .touchUpInside)
		return button
	}()
	lazy var deleteButton: UIButton = {
		let button = UIButton()
		button.setTitle("X", for: .normal)
		button.backgroundColor = .blue
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
	private var onSale: Bool = false
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
		task?.cancel()
	}

	func configureViews() {
		contentView.addSubview(productImageView)
		contentView.addSubview(infoStackView)

		productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		productImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

		infoStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
		infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}

	func setupCell(product: Product) {
		nameLabel.text = product.name
		priceLabel.text = product.onSale ? product.promotionalPrice : product.price
		setupImage(urlString: product.imageURL ?? "")
		countLabel.text = "1"
		self.product = product
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

	private func getUILabel(text: String = "", fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
		return label
	}
}

