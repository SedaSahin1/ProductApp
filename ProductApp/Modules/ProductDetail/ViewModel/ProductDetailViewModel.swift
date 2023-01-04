//
//  ProductDetailViewModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

class ProductDetailViewModel: ViewModel {
    var detailData: DetailModel?
    var code: String = ""

}

extension ProductDetailViewModel {
    func getProductDetail() {
        
        APIRequest().get(endpoint: "/v1/1a1fb542-22d1-4919-914a-750114879775", completion: detailResponse, queryItems: ["code" : code])
    }
    
    func detailResponse(result :Result<ProductDetailModel,APIError>){
        if let response = serverResponse(result: result){
           detailData = response.result
           updateUI?()
        }
    }
}
