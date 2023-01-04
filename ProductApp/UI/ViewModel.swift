//
//  ViewModel.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

public class ViewModel: NSObject {

    deinit {
        let type = Swift.type(of: self)
        print("\(type) DEALLOCATED")
    }

    var errorHandler: ((_ error: APIError) -> Void)?
    var retryHandler: ((_ customMessage: String?) -> Void)?
    var updateUI: (() -> Void)?
    
    
    func serverResponse<T>(result:Result<T, APIError>) -> T?{
        switch result {
        case .failure(let error):
            print(error)
            break;
        case .success(let response):
                return response
        }
        return nil
    }
}
