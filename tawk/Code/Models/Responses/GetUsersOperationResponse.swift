//
//  GetUsersOperationResponse.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

enum OperationState {
  case new
  case success([User])
  case failure(NetworkError)
}

class GetUsersOperationResponse {
    var state = OperationState.new
}
