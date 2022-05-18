//
//  Product.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import Foundation

struct Product: Codable, Hashable {
    var sku: String? = ""
    var amount: String? = ""
    var currency: String? = ""
}
