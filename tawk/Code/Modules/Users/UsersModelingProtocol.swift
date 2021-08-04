//
//  UsersModelingProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 27/07/2021.
//

import Foundation

protocol UsersModeling {
    func viewDidLoad()
    func getRows() -> Int
    func getUser(at index:Int) -> User
    func getUserModel(at index:Int) -> UserCellModel
    func loadMoreUsers()
    func searchUsers(with text : String)
    func changeSearchStatus(status  : Bool)
    var isSearchOn : Bool {get set}
    
    

//    func suspendAllOperations()
//    func resumeAllOperations()
    /**
     Callback to reload view after some decision
     */
    typealias reloadViewAias = () -> ()
    var reloadView : reloadViewAias?{get set}
}
