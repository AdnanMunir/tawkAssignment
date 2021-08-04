//
//  SaveUserNoteRequest.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

struct SaveUserNoteRequest {
    var userId : Int64
    var userNote : String
    
    init(userId : Int64 = 0, userNote : String = "" ) {
        self.userId = userId
        self.userNote = userNote
    }
}
