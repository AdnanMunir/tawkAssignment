//
//  GetImageOperationRequest.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

struct GetImageOperationRequest {
    var request : URLRequest
    
    init(imageUrl : URLRequest) {
        self.request = imageUrl
    }
}
