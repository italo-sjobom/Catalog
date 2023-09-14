//
//  ProductCatalogCell.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
	func addToCart(product: Product)
}

class ProductCatalogCell: ProductCell {
	lazy var onSaleLabel: UILabel = UILabel.getUILabel(text: "On Sale", fontSize: 12, fontWeight: .heavy)
	lazy var sizesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.clipsToBounds = true
		stackView.contentMode = .center
		stackView.distribution = .fillProportionally
		return stackView
	}()

	@objc func addToCart() {
		delegate?.addToCart(product: product!)
	}

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
		sizesStackView.subviews.forEach { sizeView in
			sizeView.removeFromSuperview()
		}
	}

	override func configureViews() {
		super.configureViews()
		infoStackView.addArrangedSubview(sizesStackView)
		infoStackView.insertArrangedSubview(onSaleLabel, at: 1)
	}

	override func setupCell(product: Product) {
		super.setupCell(product: product)
		sideButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
		sideButton.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
		sideButton.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .selected)
		if product.onSale {
			onSaleLabel.isHidden = false
		} else {
			onSaleLabel.isHidden = true
		}
		product.sizes.forEach { size in
			if size.available {
				let label = UILabel()
				label.text = size.size
				sizesStackView.addArrangedSubview(label)
			}
		}
	}
}
