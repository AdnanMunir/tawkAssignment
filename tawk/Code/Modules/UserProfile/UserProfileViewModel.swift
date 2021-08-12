//
//  UserProfileViewModel.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

class UserProfileViewModel: UserProfileModeling {
    
    var loadHeaderView : UserProfileModeling.loadHeaderViewAlias?
    var reloadView: UserProfileModeling.reloadViewAlias?
    let user : User
    let profileService : UserProfileProtocol
    var userProfile : UserProfile!
    
    init(user : User, profileService : UserProfileProtocol ) {
        self.user = user
        self.profileService = profileService
    }
    
    func viewDidLoad() {
        loadHeaderView?(user.avatarUrl ?? "")
        getUserProfile()
    }
    
    func getUserDetails() -> UserProfileDetailsProtocol {
        return userProfile
    }
    
    func getUserNote() -> UserNoteDetailsProtocol {
        return user
    }
    
    func saveUserNote(note: String) {
        let request = SaveUserNoteRequest(userId: user.objectID, userNote: note)
        profileService.saveUserNote(request: request) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    
    private func getUserProfile() {
        guard let login = user.login else {
            return
        }
        let request = GetUserProfileRequest(userId: user.id, userName: login)
        profileService.getUserProfile(request: request) {[weak self] (result) in
            switch result {
            case .success(let userProfile):
                self?.userProfile = userProfile
                self?.reloadView?()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getUserName() -> String {
        return user.login ?? ""
    }
    
    
}
