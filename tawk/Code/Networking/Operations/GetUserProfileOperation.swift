//
//  GetUserProfileOperation.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

class GetUserProfileOperation: AsynchronousOperation {
    var getUserProfileRequest : GetUserProfileOperationRequest
    var getUserProfileResponse : GetUserProfileOperationResponse
    
    init(getUserProfileRequest : GetUserProfileOperationRequest, getUserProfileResponse : GetUserProfileOperationResponse) {
        self.getUserProfileRequest = getUserProfileRequest
        self.getUserProfileResponse = getUserProfileResponse
    }
    
    override func main() {
        super.main()
        if isCancelled {
              return
        }
        
        
        APIInterface.sharedInstance.execute(request: getUserProfileRequest.urlRequest, decodingType: UserProfile.self) {[weak self] (result) in
            switch result {
            case .success(let user):
                self?.getUserProfileResponse.state = .success(user)
                self?.state = .finished
                break
            case .failure(let error):
                self?.getUserProfileResponse.state = .failure(error)
                self?.state = .finished
                break
            }
        }
    }
}
