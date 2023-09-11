//
//  ProductCell.swift
//  Catalog
//
//  Created by Italo Sjobom on 10/09/23.
//

import UIKit

class ProductCell: UITableViewCell {

	lazy var productName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		return label
	}()
	lazy var productImage: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.clipsToBounds = true
		imgView.contentMode = .scaleAspectFit
		return imgView
	}()
	private var task: URLSessionDataTask?

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
		productName.text = ""
		task?.cancel()
	}

	func configureViews() {
		contentView.addSubview(productImage)
		contentView.addSubview(productName)

		productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
		productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 100).isActive = true

		productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16).isActive = true
		productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
		productName.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		productName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}

	func setupCell(name: String, imageURL: String) {
		productName.text = name
		setupImage(urlString: imageURL)
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
}
