//
//  ProductListingViewModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

class ProductListingViewModel: ViewModel {
    var productData: ProductModel?
    var nextUrl: String?
    var products: [ProductItemModel]? = []
    var horizontalProducts: [HorizontalProductModel]? = []
}

extension ProductListingViewModel {
    
    func getProducts(endpoint: String) {
        APIRequest().get(endpoint: "/v1/\(endpoint)", completion: productsResponse)
    }
    
    func productsResponse(result :Result<ProductListModel,APIError>){
        if let response = serverResponse(result: result){
            nextUrl = response.result?.nextUrl
            products?.append(contentsOf: (response.result?.products)!)
            if response.result?.horizontalProducts != nil {
                horizontalProducts?.append(contentsOf: (response.result?.horizontalProducts)!)
            }
            productData = response.result
           updateUI?()
        }
    }
}
