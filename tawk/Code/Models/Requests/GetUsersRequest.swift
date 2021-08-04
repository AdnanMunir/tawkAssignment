//
//  GetUsersRequest.swift
//  tawk
//
//  Created by Adnan Munir on 30/07/2021.
//

import Foundation

struct GetUsersRequest {
    var userId : Int64
    var limit : Int64
    
    init(userId : Int64 = 0, limit : Int64 = 20 ) {
        self.userId = userId
        self.limit = limit
    }
}
