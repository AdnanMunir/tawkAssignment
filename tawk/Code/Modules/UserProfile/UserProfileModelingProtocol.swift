//
//  UserProfileModelingProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

protocol UserProfileModeling {
    func saveUserNote(note: String)
    func viewDidLoad()
    func getUserName() -> String
    func getUserNote() -> UserNoteDetailsProtocol
    func getUserDetails() -> UserProfileDetailsProtocol
    /**
     Callback to reload view after some decision
     */
    typealias reloadViewAlias = () -> ()
    var reloadView : reloadViewAlias?{get set}
    
    
    typealias loadHeaderViewAlias = (String) -> ()
    var loadHeaderView : loadHeaderViewAlias?{get set}

}
