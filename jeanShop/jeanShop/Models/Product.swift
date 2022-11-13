//
//  Product.swift
//  jeanShop
//
//  Created by Fizza Usman on 10/24/22.
//

import Foundation

//create a struct, identifiable means that it can be identified uniquely
//this model will tell program what variables each jean we create must have


struct Product: Identifiable {
    //UUID will uniquely identify this item
    var id = UUID()
    var name: String // you need to have name for each product
    var image: String
    var cost: Int

}

//add some dummy data
//we will use 6 jeans added in assets folder, for each we will create product instance

//this will be an array of product, id is determined by swift
var productList = [Product(name: "Sequin Jeans", image: "jeans1", cost: 50),
                   Product(name: "Black Ripped Jeans", image: "jeans2", cost: 100),
                   Product(name: "Blue Ripped Jeans", image: "jeans3", cost: 80),
                   Product(name: "Skirt Jeans", image: "jeans4", cost: 95),
                   Product(name: "Blue Patched Ripped Jeans", image: "jeans5", cost: 130),
                   Product(name: "Slit Jeans", image: "jeans6", cost: 20)]


