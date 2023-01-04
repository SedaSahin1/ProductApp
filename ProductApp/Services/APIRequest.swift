//
//  APIRequest.swift
//  ProductApp
//
//  Created by Seda Şahin on 3.01.2023.
//

import Foundation

struct APIRequest {
    
    
    private func send<T:BaseResponse>(_ message: BaseRequest?, endpoint:String, method:String, queryItems:[String:String]?, path:[String:String]?, completion: ((Result<T, APIError>) -> Void)?){
        
        
        do{
            var ep = endpoint
            
            if let p = path{
                for item in p{
                    ep = endpoint.replacingOccurrences(of: "{\(item.key)}", with: item.value)
                }
            }
            
            var component = URLComponents()
            component.host = "mocki.io" // baseurl
            component.path = ep
            component.scheme = "https"
            
            if let qi = queryItems{
                component.queryItems = []
                
                for item in qi{
                    component.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
                }
            }
            
            if let url =  URL(string: component.string ?? ""){
                var urlRequest = URLRequest(url:url)
                
                urlRequest.httpMethod = method
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

                
                if let m = message{
                    urlRequest.httpBody = try JSONEncoder().encode(m)
                }
                
                print("ENDPONT : \(url)")
                if let body = urlRequest.httpBody{
                    print("BODY : \(String(decoding: body, as: UTF8.self))")
                }
                
                let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                    if let d = data{
                        print("DATA : \(String(decoding: d, as: UTF8.self))")
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let _ = data else{
                        
                        completion?(.failure(.commonProblem))
                        
                        return
                    }
                    
                    print("STATUS : \(httpResponse.statusCode)")
                    
                    do{
                        if let d = data{
                            let messageData = try JSONDecoder().decode(T.self, from: d)
                            
                            completion?(.success(messageData))
                        }else{
                            completion?(.failure(.decodingProblem))
                        }
                        
                    }catch{
                        completion?(.failure(.decodingProblem))
                    }
                }
                dataTask.resume()
            }else{
                completion?(.failure(.commonProblem))
            }
        }catch{
            completion?(.failure(.encodingProblem))
        }
        
    }
    
    func get<T:BaseResponse>(endpoint:String, completion: ((Result<T, APIError>) -> Void)?, queryItems:[String:String]? = nil, path:[String:String]? = nil){
        send(nil, endpoint: endpoint, method: "GET", queryItems: queryItems, path: path, completion: completion)
    }
    
    func post<T:BaseResponse>(endpoint:String, completion: ((Result<T, APIError>) -> Void)?, message:BaseRequest? = nil, path:[String:String]? = nil, queryItems:[String:String]? = nil){
        send(message, endpoint: endpoint, method: "POST", queryItems: nil, path: path, completion: completion)
    }
    
}

