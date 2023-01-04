//
//  APIError.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

enum APIError: Error {
    case responseProblem(error:BaseResponse)
    case decodingProblem
    case encodingProblem
    case commonProblem
}
