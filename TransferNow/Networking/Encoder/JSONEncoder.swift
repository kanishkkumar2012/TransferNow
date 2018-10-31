//
//  JSONEncoder.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

public struct JSONEncoder: ParamEncoder {
    /// Allows to encode the params to JSON Format then add the request Headers respectively.
    ///
    /// - Parameters:
    ///   - urlRequest: url of the request
    ///   - parameters: parameters/arguments
    /// - Throws: exception/error response that ecodind failed.
    public func encode(urlRequest: inout URLRequest, with parameters: Params) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.parameterEncodingFailed
        }
    }
}
