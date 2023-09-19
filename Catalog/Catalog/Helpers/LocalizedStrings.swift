//
//  LocalizedStrings.swift
//  Catalog
//
//  Created by Italo Sjobom on 19/09/23.
//

import Foundation

enum LocalizedStrings: String {
	case catalogScreenTitle = "catalog_screen_title"
	case errorAlertTitle = "error_alert_title"
	case okButton = "ok_button"
	case onSaleFilter = "on_sale_filter"
	case cartScreenTitle = "cart_screen_title"

	static func getString(for key: LocalizedStrings) -> String {
		return NSLocalizedString(key.rawValue, comment: "")
	}
}
