//
//  DetailModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 4.01.2023.
//

import Foundation

final class DetailModel: Decodable{
    
    var mkName : String?
    var productName: String?
    var badge: String?
    var rating: Double?
    var imageUrl: String?
    var storageOptions: [String]?
    var countOfPrices: Double?
    var price: Double?
    var freeShipping: Bool?
    var lastUpdate: String?
    
}
