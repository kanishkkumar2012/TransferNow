//
//  ParamsEncoding.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

public typealias Params = [String:Any]

/// This Protocol will be implemented by URLEncoder & JSONEncoder
/// Perfoms one task i-e to encode the paramters/arguments.
/// It can also throw an error response like netowrkError, so we need to handle it.
public protocol ParamEncoder {
    func encode(urlRequest: inout URLRequest, with params: Params) throws
}

/// Encode the paramters/arguments
///
/// - urlEncoder: encode the URL
/// - jsonEncoder: encode the JSON
/// - urlAndJsonEncoder: encode the URL & JSON
public enum ParameterEncoding {
    
    case urlEncoder
    case jsonEncoder
    case urlAndJsonEncoder
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParams: Params?,
                       urlParams: Params?) throws {
        do {
            switch self {
            case .urlEncoder:
                guard let urlParams = urlParams else { return }
                try URLEncoder().encode(urlRequest: &urlRequest, with: urlParams)
            case .jsonEncoder:
                guard let bodyParams = bodyParams else { return }
                try JSONEncoder().encode(urlRequest: &urlRequest, with: bodyParams)
            case .urlAndJsonEncoder:
                guard let bodyParams = bodyParams,
                    let urlParams = urlParams else { return }
                try JSONEncoder().encode(urlRequest: &urlRequest, with: bodyParams)
                try URLEncoder().encode(urlRequest: &urlRequest, with: urlParams)
            }
        }catch {
            throw error
        }
    }
}

/// Error Handler
///
/// - parametersNil: error type stating reason paramter is nil
/// - parameterEncodingFailed: error type stating reason encoding failed
/// - missingURL: error type stating URL is nil or not found
public enum NetworkError : String, Error {
    case parametersNil = "Params are nil."
    case parameterEncodingFailed = "Encoding failed."
    case missingURL = "URL not found."
}
