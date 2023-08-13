//
//  ProductCellView.swift
//  StoreApp
//
//  Created by kirshi on 8/12/23.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(product.title)
                    .bold()
                
                Spacer()
                
                Text(product.price, format: .currency(code: Locale.currentCode))
                    .padding(5)
                    .foregroundColor(.white)
                    .background(
                        .green
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            Text(product.description)
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product.preivew)
    }
}
