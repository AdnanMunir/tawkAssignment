//
//  UserNoteDetailsProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

protocol UserNoteDetailsProtocol {
    var userNote:String {get}
}

extension User: UserNoteDetailsProtocol {
    var userNote: String {
        return note ?? ""
    }
    
    
}
