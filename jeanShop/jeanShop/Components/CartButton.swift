//
//  CartButton.swift
//  jeanShop
//
//  Created by Fizza Usman on 11/3/22.
//

import SwiftUI

struct CartButton: View {
    var noOfItems: Int
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .padding(.top, 5)
            
            if noOfItems > 0 {
                Text("\(noOfItems)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height:15)
                    .background(Color(hue: 0.871, saturation: 0.952, brightness: 0.93))
                    .cornerRadius(50)
                
                
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(noOfItems: 1)
    }
}
