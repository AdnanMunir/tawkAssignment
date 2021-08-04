//
//  GetUserProfileOperationResponse.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

enum UserProfileOperationState {
  case new
  case success(UserProfile)
  case failure(NetworkError)
}

class GetUserProfileOperationResponse {
    var state = UserProfileOperationState.new
}
