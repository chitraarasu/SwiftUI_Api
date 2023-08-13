//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by kirshi on 8/13/23.
//

import Foundation

struct CreateProductRequest: Encodable {
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]
}
