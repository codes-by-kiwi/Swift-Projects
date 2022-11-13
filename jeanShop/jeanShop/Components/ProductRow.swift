//
//  ProductRow.swift
//  jeanShop
//
//  Created by Fizza Usman on 11/3/22.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartFunctionality: CartFunctionality
    var product: Product
    
    var body: some View {
        HStack(spacing: 20){
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                Text(product.name).bold()
                Text("€\(product.cost)")
            }
            Spacer()
            
            Image(systemName: "trash.circle").font(.system(size:40))
                .foregroundColor(Color(hue: 0.871, saturation: 0.952, brightness: 0.93))
                .onTapGesture {
                    cartFunctionality.removeFromCart(product: product)
                }
            
            
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productList[2])
            .environmentObject(CartFunctionality())
    }
}
