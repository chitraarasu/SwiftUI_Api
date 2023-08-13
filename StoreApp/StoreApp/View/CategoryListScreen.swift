//
//  CategoryListScreen.swift
//  StoreApp
//
//  Created by kirshi on 8/11/23.
//

import SwiftUI

struct CategoryListScreen: View {
    
    @EnvironmentObject private var storeModel: StoreController
    
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List(storeModel.categories, id: \.id) { item in
                    NavigationLink(value: item) {
                        HStack {
                            AsyncImage(url: item.image) { image in
                                image
                                    .resizable()
                                    .frame( maxWidth: 100,maxHeight: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            } placeholder: {
                                Rectangle()
                                    .frame(maxWidth: 100,maxHeight: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .foregroundColor(Color.gray.opacity(0.4))
                            }
                            
                            Text(item.name)
                        }
                    }.navigationDestination(for: Category.self) { category in
                        ProductListView(category:  category)
                    }
                }
                .task {
                    do {
                        try await storeModel.getCategories()
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
                Text(errorMessage)
            }
            .navigationTitle("Store")
        }
    }
}

struct CategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListScreen().environmentObject(StoreController())
    }
}
