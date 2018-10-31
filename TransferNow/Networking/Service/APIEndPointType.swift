//
//  APIEndPointType.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

/// consists of multiple HTTP Protocls
protocol APIEndPointType {
    
    // MARK: - Properties
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httptask: HTTPTask { get }
    var httpheaders: HTTPHeaders? { get }
}
