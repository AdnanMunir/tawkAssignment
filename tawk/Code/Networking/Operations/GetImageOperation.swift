//
//  GetImagesOperation.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

class GetImageOperation: AsynchronousOperation {
    
    var getImageRequest : GetImageOperationRequest
    var getImageResponse : GetImageOperationResponse
    
    init(getImageRequest : GetImageOperationRequest, getImageResponse : GetImageOperationResponse) {
        self.getImageRequest = getImageRequest
        self.getImageResponse = getImageResponse
    }
    
    override func main() {
        
        super.main()
        if isCancelled {
              return
        }
        
        guard let _ = getImageRequest.request.url else {
            return
        }
        
        APIInterface.sharedInstance.imageData(from: getImageRequest.request) {[weak self] (result) in
            switch result {
            case .success((let data, let response)):
                if let data = data,let response = response {
                    self?.getImageResponse.state = .success(data, response,(self?.getImageRequest.request)!)
                    self?.state = .finished
                }
                break
            case .failure(_):
                self?.getImageResponse.state = .failure(.APIError)
                self?.state = .finished
                break
            }
        }
        
        
    }
}
