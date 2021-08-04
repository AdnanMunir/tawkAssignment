//
//  GetOperation.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

class GetUsersOperation: AsynchronousOperation {
    var getUsersRequest : GetUsersOperationRequest
    var getUsersResponse : GetUsersOperationResponse
    
    init(getUsersRequest : GetUsersOperationRequest, getUsersResponse : GetUsersOperationResponse) {
        self.getUsersRequest = getUsersRequest
        self.getUsersResponse = getUsersResponse
    }
    
    override func main() {
        super.main()
        if isCancelled {
              return
        }
        
        
        APIInterface.sharedInstance.execute(request: getUsersRequest.urlRequest, decodingType: [User].self) {[weak self] (result) in
            switch result {
            case .success(let users):
                self?.getUsersResponse.state = .success(users)
                self?.state = .finished
                break
            case .failure(let error):
                self?.getUsersResponse.state = .failure(error)
                self?.state = .finished
                break
            }
        }
    }
}
