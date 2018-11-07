//
//  APIManager.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

enum APIResponse:String {
    case success
    case authenticationError = "Authentication Needed."
    case failed = "Network request failed."
    case badRequest = "Bad request"
    case noData = "No data to decode."
    case unableToDecode = "Sorry, Unable to decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

/// API Manager, Responsible for Managing API Call's to the server, based on the Environment.
struct APIManager {
    //Change the Environment as per Needs.
    //See: APIEndPoint.swift
    static let environment : APIEnvironment = .development
    let router = Router<ServiceAPIEndPoint>()
    
    /// Allows you to transfer money from your account to another account.
    /// A URLSession returns an error if there is no network or the call to the API could not be made for some reason.
    /// - Parameters:
    ///   - amount: amount to transfer
    ///   - FromAccountNumber: from account number
    ///   - toAccountNumber: to account number
    ///   - completion: completion block for results.
    func initMoneyTransfer(amount: Int, fromAccountNumber: Int, toAccountNumber: Int, completion: @escaping ([TransferMoneyDataModel]?,_ error: String?)->()){
        
        if (APIManager.environment == .development) {
            //Offline Mode
            if let path = Bundle.main.path(forResource: "transfersuccess_response", ofType: "json") {
                do{
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([TransferMoneyDataModel].self, from: data)
                    completion(response, nil)
                } catch {
                    completion(nil, error as? String)
                }
                return
            }
        }

        router.request(.initMoneyTransfer(amount: amount, fromAccountNumber: fromAccountNumber, toAccountNumber: toAccountNumber)) { data, response, error in
            
            if error != nil {
                let networkError = NSLocalizedString("network_error", comment: "Please check your network connection.")
                completion(nil, networkError)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleAPIResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, APIResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([TransferMoneyDataModel].self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        completion(nil, APIResponse.unableToDecode.rawValue)
                    }
                case .failure(let apiFailureError):
                    completion(nil, apiFailureError)
                }
            }
        }
    }
    
    /// API Response Handler
    ///
    /// - Parameter response: HTTPURLResponse
    /// - Returns: reason for failure.
    fileprivate func handleAPIResponse(_ response: HTTPURLResponse) -> Result<String>{
        
        switch response.statusCode {
        case 200...299: return .success
        case 501: return .failure(APIResponse.badRequest.rawValue)
        case 401: return .failure(APIResponse.authenticationError.rawValue)
        default: return .failure(APIResponse.failed.rawValue)
        }
    }
}
