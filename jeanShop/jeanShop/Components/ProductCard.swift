//
//  ProductCard.swift
//  jeanShop
//
//  Created by Fizza Usman on 11/3/22.
//

//productcard is one card or square in the jeanshop that represents 1 kind of jean available for purchase 

import SwiftUI

//environment object is used to share data b/w views

struct ProductCard: View {
    @EnvironmentObject var cartFunctionality: CartFunctionality
    var product: Product
    
    
    //zstack organizes views on top of one another
    //the image will be below everything
    var body: some View {
        
        //parent zstack for the plus button to add it to cart
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom){
                Image(product.image)
                //change the size of this image
                    .resizable()
                    .cornerRadius(20)
                    .frame(width:180)
                //we want to unstretch image
                    .scaledToFit()
                
       //vstack allows you to stack views vertically from top to bottom
                VStack(alignment: .leading){
                    Text(product.name)
                        .bold().foregroundColor(Color(hue: 0.871, saturation: 0.952, brightness: 0.93))
                    Text("\(product.cost)€").foregroundColor(Color(hue: 0.871, saturation: 0.952, brightness: 0.93)).font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180, height:300)
        .shadow(radius:3)
            
            Button{
                cartFunctionality.addToCart(product: product)
            } label:{
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(20)
                    .padding()
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    //fix the preview
    static var previews: some View {
        ProductCard(product: productList[0])
            .environmentObject(CartFunctionality())
    }
}
