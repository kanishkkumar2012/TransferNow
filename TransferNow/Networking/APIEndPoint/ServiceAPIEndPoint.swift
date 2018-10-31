//
//  ServiceAPIEndPoint.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

enum APIEnvironment {
    case production
    case testbed
    case staging
    //Offline Mode
    case development
}

/// API Name, Here its a API  Add more cases as per requirnment in future, for eg: loginWithServer, fetchUserProfile etc.
///
/// - transferMoney: what amount to transfer, from account number, to account number
public enum ServiceAPIEndPoint {
    case initMoneyTransfer(amount: Int, fromAccountNumber: Int, toAccountNumber: Int)
}

// MARK: - APIEndPoint Extension
extension ServiceAPIEndPoint: APIEndPointType {
    
    /// API Endpoint URL, which specifices the Environment you are using. Change the URL based on new Env in furture.
    var environmentBaseURL : String {
        switch APIManager.environment {
        // Change URL's as per Env in Future.
        case .production: return "http://hsbc.transfernow/"
        case .testbed: return "http://hsbc.transfernow/"
        case .staging: return "http://hsbc.transfernow/"
        case .development: return "http://hsbc.transfernow/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure the URL.")}
        return url
    }
    
    /// Defines the Path for URL of API
    var path: String {
        switch self {
        case .initMoneyTransfer:
            return "hsbc/transfernow"
        }
    }
    
    /// Speficies the HTTP Method, GET in this case.
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httptask: HTTPTask {
        switch self {
        case .initMoneyTransfer(let amount, let fromAccountNumber, let toAccountNumber):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoder,
                                      urlParameters: ["amount":amount,
                                                      "fromAccountNumber": fromAccountNumber,
                                                      "toAccountNumber":toAccountNumber])
        }
    }
    
    var httpheaders: HTTPHeaders? {
        return nil
    }
}
