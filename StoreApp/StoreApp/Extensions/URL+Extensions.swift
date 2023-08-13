//
//  URL+Extensions.swift
//  StoreApp
//
//  Created by kirshi on 8/10/23.
//

import Foundation

extension URL {
    static var development: URL {
        URL(string: "https://api.escuelajs.co/")!
    }
    
    static var production: URL {
        URL(string: "https://api.escuelajs.co/")!
    }
    
    static var `default`: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var allCategories: URL {
        URL(string: "api/v1/categories", relativeTo: self.default)!
    }
    
    static func productByCategoryId(_ categoryId: Int) -> URL {
        URL(string: "api/v1/categories/\(categoryId)/products", relativeTo: self.default)!
    }
    
    static var saveProduct: URL {
        URL(string: "api/v1/products", relativeTo: self.default)!
    }
}
