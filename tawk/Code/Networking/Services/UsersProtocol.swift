//
//  UsersProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 30/07/2021.
//

import Foundation

protocol UsersProtocol {
    func getUsers(request : GetUsersRequest,completion: @escaping(Result<[User], NetworkError>) -> Void)
    func searchUsers(request : SearchUsersRequest,completion: @escaping(Result<[User], NetworkError>) -> Void)
}
