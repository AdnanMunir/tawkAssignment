//
//  UserProfileProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

protocol UserProfileProtocol {
    func getUserProfile(request : GetUserProfileRequest,completion: @escaping(Result<UserProfile, NetworkError>) -> Void)
    
    func saveUserNote(request : SaveUserNoteRequest,completion: @escaping(Result<Bool, NetworkError>) -> Void)
}
