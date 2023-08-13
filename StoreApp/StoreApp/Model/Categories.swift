//
//  Categories.swift
//  StoreApp
//
//  Created by kirshi on 8/11/23.
//

import Foundation

struct Category: Codable, Hashable {
    let id: Int
    let name: String
    let image: URL
}

extension Category {
    static var preivew: Category {
        Category(id: 1, name: "Clothes", image: URL(string: "https://picsum.photos/640/640?r=1448")!)
    }
}

