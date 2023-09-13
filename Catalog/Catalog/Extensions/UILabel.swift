//
//  UILabel.swift
//  Catalog
//
//  Created by Italo Sjobom on 13/09/23.
//

import UIKit

extension UILabel {

	static func getUILabel(text: String = "", fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
		return label
	}
}
