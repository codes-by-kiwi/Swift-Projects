//
//  ContentView.swift
//  jeanShop
//
//  Created by Fizza Usman on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartFunctionality = CartFunctionality()
    var columns = [GridItem(.adaptive(minimum:160),spacing: 20)]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns:columns, spacing:20) {
                    ForEach(productList, id:\.id){
                        product in
                        ProductCard(product: product)
                            .environmentObject(cartFunctionality)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("jeanShop"))
            .toolbar{
                NavigationLink{CartView()  .environmentObject(cartFunctionality)}
            label:{CartButton(noOfItems: cartFunctionality.products.count)}
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
