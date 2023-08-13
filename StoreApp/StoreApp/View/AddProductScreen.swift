//
//  AddProductScreen.swift
//  StoreApp
//
//  Created by kirshi on 8/12/23.
//

import SwiftUI

struct AddProductScreen: View {
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    @State private var selectedCategory: Category?
    @State private var imageUrl: String = ""
    @State private var errorMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storeModel: StoreController
    
    private var isFormValid: Bool {
        !title.isEmpty && selectedCategory != nil && !imageUrl.isEmpty && !description.isEmpty && !price.isEmpty && (Double(price)?.isZero != true )
    }
    
    private func saveProduct() {
        guard let category = selectedCategory, let imageURL = URL(string: imageUrl) else {
            return
        }
        
        
        let createProductRequest = CreateProductRequest(title: title, price: Double(price) ?? 0, description: description, categoryId: selectedCategory!.id, images: [imageURL])
        
        Task{
            do {
               try await storeModel.saveProduct(createProductRequest)
                dismiss()
            } catch {
                errorMessage = "Unable to save product."
            }
        }
       
    }
    
    var body: some View {
        Form {
            TextField("Enter title", text: $title)
            TextField("Enter price", text: $price)
                .keyboardType(.decimalPad)
            TextField("Enter description", text: $description)
            
            Picker("Categories", selection: $selectedCategory) {
                ForEach(storeModel.categories, id: \.id) { item in
                    Text(item.name)
                }
            }.pickerStyle(.wheel)
            TextField("Image url", text: $imageUrl)
        }
        .navigationTitle("Add Product")
        .onAppear {
            selectedCategory = storeModel.categories.first
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    if(isFormValid){
                        saveProduct()
                    }
                }.disabled(!isFormValid)
            }
        }
    }
}

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        let storeModel = StoreController()
        storeModel.categories = [Category.preivew]
        return NavigationStack {
            AddProductScreen()
                .environmentObject(storeModel)
        }
    }
}
