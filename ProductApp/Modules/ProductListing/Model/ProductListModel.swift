//
//  ProductListModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

final class ProductListModel: BaseResponse{
    
    var result : ProductModel?
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(ProductModel?.self, forKey: .result)
        try super.init(from: decoder)
    }
}
