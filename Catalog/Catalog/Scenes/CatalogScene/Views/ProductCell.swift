//
//  ProductCell.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
	func addToCart(product: Product)
}

class ProductCell: UITableViewCell {

	lazy var nameLabel: UILabel = getUILabel(fontSize: 12, fontWeight: .regular)
	lazy var priceLabel: UILabel = getUILabel(fontSize: 10, fontWeight: .regular)
	lazy var promotionalPriceLabel: UILabel = getUILabel(fontSize: 10, fontWeight: .bold)
	lazy var onSaleLabel: UILabel = getUILabel(text: "On Sale", fontSize: 12, fontWeight: .heavy)
	lazy var productImage: UIImageView = {
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
		stackView.addArrangedSubview(onSaleLabel)
		stackView.addArrangedSubview(priceStackView)
		stackView.addArrangedSubview(sizesStackView)
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
	lazy var sizesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalSpacing
		return stackView
	}()
	lazy var buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.clipsToBounds = true
		stackView.contentMode = .scaleAspectFit
		stackView.distribution = .equalSpacing
		stackView.addArrangedSubview(addButton)
		return stackView
	}()
	lazy var addButton: UIButton = {
		let button = UIButton()
		button.setTitle("Add", for: .normal)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 12
		button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
		return button
	}()


	@objc func addToCart() {
		delegate?.addToCart(product: product!)
	}

	private var task: URLSessionDataTask?
	private var product: Product!
	weak var delegate: ProductCellDelegate?

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
		priceLabel.text = ""
		priceLabel.attributedText = NSAttributedString()
		promotionalPriceLabel.text = ""
		task?.cancel()
	}

	func configureViews() {
		contentView.addSubview(productImage)
		contentView.addSubview(infoStackView)
		contentView.addSubview(buttonStackView)

		productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 100).isActive = true

		infoStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

		buttonStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: 16).isActive = true
		buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
		buttonStackView.widthAnchor.constraint(equalToConstant: 60).isActive = true
		buttonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
		buttonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}

	func setupCell(product: Product) {
		nameLabel.text = product.name
		priceLabel.text = product.price
		if product.onSale {
			promotionalPriceLabel.text = product.promotionalPrice
			priceLabel.attributedText = NSAttributedString.getStrikethroughAttributedString(string: product.price, widthLine: 1)
			onSaleLabel.isHidden = false
		} else {
			onSaleLabel.isHidden = true
		}
		setupImage(urlString: product.imageURL ?? "")
		self.product = product
	}

	private func setupImage(urlString: String) {
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

	private func getUILabel(text: String = "", fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
		return label
	}
}
