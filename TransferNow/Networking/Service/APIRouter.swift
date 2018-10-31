//
//  APIRouter.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

public typealias APIRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// It has an APIEndPointType which returns the response to APIRouterCompletion, once completed.
protocol APIRouter: class {
    associatedtype EndPoint: APIEndPointType
    func request(_ route: EndPoint, completion: @escaping APIRouterCompletion)
    func cancel()
}

class Router<EndPoint: APIEndPointType>: APIRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping APIRouterCompletion) {
        //The singleton shared session (which has no configuration object) is for basic requests.
        //It’s not as customizable as sessions that you create, but it serves as a good starting point if you have very limited requirements.
        //You access this session by calling the shared class method. See that method’s discussion for more information about its limitations.
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            print("\n\n-------------- REQUEST --------------\n\n [\(request)]")
            
            if (APIManager.environment == .development) {
                if let path = Bundle.main.path(forResource: "transfersuccess_response", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let _ = jsonResult["results"] as? [Any] {
                            completion(data, nil, nil)
                        }
                    } catch {
                        completion(nil, nil, error)
                    }
                }
            }

            //The URLSession object calls the delegate’s urlSession(_:dataTask:didReceive:completionHandler:) method.
            //Decide whether to convert the data task into a download task, and then call the completion handler to convert, continue, or cancel the task.
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    //If your app cancels an in-progress download, the URLSession object calls the delegate’s urlSession(_:task:didCompleteWithError:) method as though an error occurred.
    //If you no longer need a session, you can invalidate it by calling
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.httptask {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Params?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Params?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParams: bodyParameters, urlParams: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
