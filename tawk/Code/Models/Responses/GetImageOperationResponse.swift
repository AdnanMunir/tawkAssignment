//
//  GetImageOperationResponse.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation


enum ImageOperationState {
  case new
  case success(Data,URLResponse, URLRequest)
  case failure(NetworkError)
}

//TODO: implement protocols
class GetImageOperationResponse {
    var state = ImageOperationState.new
}
