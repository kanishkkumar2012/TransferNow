//
//  HTTPMethod.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

/// HTTP Method defines the desired action to be performed.
///
/// - head: The HEAD method asks for a response identical to that of a GET request, but without the response body.
/// - get: The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.
/// - post: The POST method is used to submit an entity to the specified resource, often causing a change in state or side effects on the server
/// - put: The PUT method replaces all current representations of the target resource with the request payload.
/// - patch: The PATCH method is used to apply partial modifications to a resource.
/// - delete: The DELETE method deletes the specified resource.
/// - options: The OPTIONS method is used to describe the communication options for the target resource.

public enum HTTPMethod : String {
    case head    = "HEAD"
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case options = "OPTIONS"
}
