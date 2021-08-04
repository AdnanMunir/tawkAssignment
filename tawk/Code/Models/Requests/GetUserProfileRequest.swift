//
//  GetUserProfileRequest.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

struct GetUserProfileRequest {
    var userId : Int64
    var userName : String
    
    init(userId : Int64 = 0, userName : String = "" ) {
        self.userId = userId
        self.userName = userName
    }
}
