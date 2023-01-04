//
//  ProductItemModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

final class ProductItemModel: Decodable{
    var code : Double?
    var imageUrl: String?
    var name: String?
    var dropRatio: Double?
    var price: Double?
    var countOfPrice: Double?
    var followCount: Double?
}
