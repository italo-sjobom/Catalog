//
//  Formatter.swift
//  Catalog
//
//  Created by Italo Sjobom on 13/09/23.
//

import Foundation

extension Formatter {
	static func convertReaisStringToDouble(valueString: String) -> Double? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencySymbol = "R$ "
		return formatter.number(from: valueString)?.doubleValue
	}
}
