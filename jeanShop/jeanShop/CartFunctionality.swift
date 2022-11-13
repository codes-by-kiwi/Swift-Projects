//
//  CartFunctionality.swift
//  jeanShop
//
//  Created by Fizza Usman on 11/3/22.
//

import Foundation


//the changes in this class will be updated automatically in the UI

class CartFunctionality: ObservableObject {
//private set variables can only be set within the class
    @Published private(set) var products: [Product] = []
    @Published private(set) var totalp: Int = 0
    
    func addToCart(product: Product)
    {
        products.append(product)
        //update total price of cart
        totalp += product.cost
    }
    
    func removeFromCart(product: Product)
    {
        products = products.filter { $0.id != product.id}
        totalp -= product.cost
        
    }
    
    
}
