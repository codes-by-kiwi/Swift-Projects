//
//  CartView.swift
//  jeanShop
//
//  Created by Fizza Usman on 11/3/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartFunctionality: CartFunctionality
    var body: some View {
        ScrollView{
            if cartFunctionality.products.count > 0 {
                ForEach(cartFunctionality.products, id:\.id){
                    product in
                    ProductRow(product: product)
                }
                
                HStack {
                    Text("Your cart total is")
                    Spacer()
                    Text("€\(cartFunctionality.totalp).00")
                        .bold()
                }
                .padding()
                
                
            } else {
            Text("Your cart is empty")

            }
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartFunctionality())
    }
}

