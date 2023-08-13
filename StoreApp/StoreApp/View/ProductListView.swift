//
//  ProductListView.swift
//  StoreApp
//
//  Created by kirshi on 8/11/23.
//

import SwiftUI

struct ProductListView: View {
    
    let category: Category
    
    @EnvironmentObject private var storeModel: StoreController
    @State private var isPresented = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            List(storeModel.products, id: \.id) { item in
                ProductCellView(product: item)
            }
            .listStyle(.plain)
            .task {
                do {
                    try await storeModel.getProductByCategory(category.id)
                } catch {
                    print("error" + errorMessage)
                    errorMessage = error.localizedDescription
                }
            }
            Text(errorMessage)
        }
        .navigationTitle(category.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Product") {
                    isPresented = true
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AddProductScreen()
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductListView(category: Category.preivew)
                .environmentObject(StoreController())
        }
    }
}
