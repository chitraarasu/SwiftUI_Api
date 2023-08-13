//
//  Product.swift
//  StoreApp
//
//  Created by kirshi on 8/11/23.
//

import Foundation

struct Product: Codable, Hashable {
    var id: Int
    let title: String
    let price: Double
    let description: String
    let images: [URL]
    let category: Category
}

extension Product {
    static var preivew: Product {
        Product(id: 19, title: "Regular Fit V-Neck Patterned Short Sleeve Crop Shirt", price: 366, description: "Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles", images: [
            URL(string: "https://dfcdn.defacto.com.tr/7/A6860AX_23SM_OG78_01_02.jpg")!,
        ], category: Category.preivew)
    }
}
