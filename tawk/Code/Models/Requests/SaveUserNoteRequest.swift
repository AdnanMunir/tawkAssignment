//
//  SaveUserNoteRequest.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation
import CoreData

struct SaveUserNoteRequest {
    var userId : NSManagedObjectID
    var userNote : String
    
    init(userId : NSManagedObjectID , userNote : String = "" ) {
        self.userId = userId
        self.userNote = userNote
    }
}
