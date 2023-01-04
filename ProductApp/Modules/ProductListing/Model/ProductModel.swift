//
//  ProductModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

final class ProductModel: Decodable{
    
    var nextUrl : String?
    var horizontalProducts: [HorizontalProductModel]?
    var products: [ProductItemModel]?
    
}
