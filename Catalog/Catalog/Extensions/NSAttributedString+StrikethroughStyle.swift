//
//  NSAttributedString+StrikethroughStyle.swift
//  Catalog
//
//  Created by Italo Sjobom on 13/09/23.
//

import UIKit

extension NSAttributedString {
	static func getStrikethroughAttributedString(string: String, widthLine: Int) -> NSAttributedString {
		let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: string)
		attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: widthLine, range: NSRange(location: 0, length: attributedString.length))
		return attributedString
	}
}
