//
//  URLEncoder.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

public struct URLEncoder: ParamEncoder {
    /// Takes paramters as input and pass them safely after handling errors.
    ///
    /// - Parameters:
    ///   - urlRequest: url of the request
    ///   - params: parameters/arguments
    /// - Throws: exception/error response
    public func encode(urlRequest: inout URLRequest, with params: Params) throws {
        
        guard let urlForRequest = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: urlForRequest,
                                             resolvingAgainstBaseURL: false), !params.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in params {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
