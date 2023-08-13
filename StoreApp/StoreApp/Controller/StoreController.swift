//
//  StoreController.swift
//  StoreApp
//
//  Created by kirshi on 8/11/23.
//

import Foundation

@MainActor
class StoreController: ObservableObject {
    let client = StoreHTTPClient()
    
    //    private(set)
    
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    func getCategories() async throws {
        categories = try await client.load(Resource(url: URL.allCategories))
        //        categories = try await client.getCategories(url: URL.allCategories)
    }
    
    func getProductByCategory(_ categoryId: Int) async throws {
        products = try await client.load(Resource(url: URL.productByCategoryId(categoryId)))
        
        //        products = try await client.getProductsByCategory(url: URL.productByCategoryId(categoryId))
    }
    
    func saveProduct(_ createProductRequest: CreateProductRequest) async throws {
        let data = try JSONEncoder().encode(createProductRequest)
        

        let product: Product = try await client.load(Resource(url: URL.saveProduct, method: .post(data)))
        
        products.append(product)
    }
}
