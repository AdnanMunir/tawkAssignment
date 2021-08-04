//
//  GetUsersOperationRequest.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

struct GetUsersOperationRequest {
    var urlRequest : URLRequest
    
    
    init(urlRequest : URLRequest ) {
        self.urlRequest = urlRequest
    }
}
