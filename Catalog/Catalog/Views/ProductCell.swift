//
//  ProductCell.swift
//  Catalog
//
//  Created by Italo Sjobom on 14/09/23.
//

import UIKit

class ProductCell: UITableViewCell {
	lazy var nameLabel: UILabel = UILabel.getUILabel(fontSize: 12, fontWeight: .regular)
	lazy var priceLabel: UILabel = UILabel.getUILabel(fontSize: 10, fontWeight: .regular)
	lazy var promotionalPriceLabel: UILabel = UILabel.getUILabel(fontSize: 10, fontWeight: .bold)
	lazy var productImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(systemName: "photo")
		imageView.tintColor = .gray
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
	lazy var sideButtonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(sideButton)
		return stackView
	}()
	lazy var sideButton: UIButton = {
		let button = UIButton()
		return button
	}()

	private var task: URLSessionDataTask?
	var product: Product!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configureViews()
	}

	override func awakeFromNib() {
		super.awakeFromNib()
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
		contentView.addSubview(productImage)
		contentView.addSubview(infoStackView)
		contentView.addSubview(sideButtonStackView)

		productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 100).isActive = true

		infoStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

		sideButtonStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: 16).isActive = true
		sideButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
		sideButtonStackView.widthAnchor.constraint(equalToConstant: 60).isActive = true
		sideButtonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		sideButtonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}

	func setupCell(product: Product) {
		nameLabel.text = product.name
		priceLabel.text = product.price
		if product.onSale {
			promotionalPriceLabel.text = product.promotionalPrice
			priceLabel.attributedText = NSAttributedString.getStrikethroughAttributedString(string: product.price, widthLine: 1)
		}
		setupImage(urlString: product.imageURL ?? "")
		self.product = product
	}

	func setupImage(urlString: String) {
		if let url = URL(string: urlString) {
			task = URLSession.shared.dataTask(with: url) { data, _, error in
				if error == nil, let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async { [weak self] in
						self?.productImage.image = image
					}
				}
			}
			task?.resume()
		}
	}
}

