//
//  ProductDetailModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 4.01.2023.
//

import Foundation

final class ProductDetailModel: BaseResponse{
    
    var result : DetailModel?
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(DetailModel?.self, forKey: .result)
        try super.init(from: decoder)
    }
}
