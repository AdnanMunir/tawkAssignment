//
//  UsersViewModel.swift
//  tawk
//
//  Created by Adnan Munir on 27/07/2021.
//

import Foundation

final class UsersViewModel : UsersModeling {
   
    var reloadView: UsersModeling.reloadViewAias?
    private let usersService : UsersProtocol
    private var lastUserId : Int64 = 0
    private var users : [User] = []
    private var searchUsers : [User] = []
    public var isSearchOn = false
    
    init(usersService : UsersProtocol) {
        self.usersService = usersService
        isSearchOn = false
    }
    
    func viewDidLoad() {
        getUsers()
    }
    
    func getRows() -> Int {
        if lastUserId == 0 {
            return users.count
        }
        return isSearchOn ? searchUsers.count : users.count + 1
    }
    
    func getUser(at index: Int) -> User {
        return isSearchOn ? searchUsers[index] : users[index]
    }
    
    func loadMoreUsers() {
        getUsers()
    }
    
    func changeSearchStatus(status: Bool) {
        if !isSearchOn {
            searchUsers = []
        }
        isSearchOn = status
    }
    
    func getUserModel(at index: Int) -> UserCellModel {
        let user =  isSearchOn ? searchUsers[index] : users[index]
        
        if let note = user.note, note.count > 0 {
            return NoteUserModel(user: user)
        }
        
        if ((index + 1) % 4 == 0) && (index != 0) {
            return InvertedUserModel(user: user)
        }
        
        return NormalUserModel(user: user)
        
    }
    
    
    func searchUsers(with text: String) {
        let request = SearchUsersRequest(searchText: text)
        usersService.searchUsers(request: request) {[weak self] (result) in
            switch result {
            case .success(let users):
                if users.count > 0 {
                    self?.searchUsers = users
//                    self?.reloadView?()
                }
                self?.reloadView?()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    private func getUsers() {
        let request = GetUsersRequest(userId: lastUserId)
        usersService.getUsers(request: request) {[weak self] (result) in
            switch result {
            case .success(let users):
                if users.count > 0 {
                    self?.users.append(contentsOf: users)
                    if let lastUser = users.last {
                        self?.lastUserId = lastUser.id
                    }
                    self?.reloadView?()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
