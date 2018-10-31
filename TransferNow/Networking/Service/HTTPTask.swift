//
//  HTTPTask.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

/// Responsible for configuring the parameters/arguments for endpoint.
///
/// - request: plain request
/// - requestParametersbodyParameters:Params?:
/// - : Used when we want to pass parameters, Params: page and api_Key, encoding type
/// - requestParametersAndHeadersbodyParameters:Params?:
/// - : Used when we want to pass parameters, Params: page, api_Key, encoding type and headers

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Params?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Params?)
    case requestParametersAndHeaders(bodyParameters: Params?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Params?,
        additionHeaders: HTTPHeaders?)
}
