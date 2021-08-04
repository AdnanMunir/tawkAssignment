//
//  CustomImageView.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import UIKit

class CustomImageView: UIImageView {

    var downloadOperation : GetImageOperation!
    
    var avatarURL  : String! = nil
    
    func downloadImage(url : String, invertImage : Bool = false, placeHolderImage : String) {
        image = UIImage(named: placeHolderImage)
        guard let imageURL = URL(string:url) else {
            return
        }
        
        if downloadOperation != nil {
            downloadOperation.cancel()
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL, timeoutInterval: 30)

        if let data = cache.cachedResponse(for: request)?.data, let newImage = UIImage(data: data) {
            self.transition(toImage: newImage, invertColor: invertImage)
        } else {
            let operationRequest = GetImageOperationRequest(imageUrl: request)
            let response = GetImageOperationResponse()
            
            downloadOperation = GetImageOperation(getImageRequest: operationRequest, getImageResponse: response)
            
            downloadOperation.completionBlock = { [weak self] in
                switch response.state {
                case .success(let data,let response,let imgRequest):
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: imgRequest)

                    DispatchQueue.main.async {
                        let downloadedImage = UIImage(data: data)
                        self?.transition(toImage: downloadedImage, invertColor: invertImage)
                    }
                    break
                case .failure(_):
                    break
                default:
                    break
                }
            }
            
            OperationsManager.sharedInstance.dataQueue.addOperation(downloadOperation)
        }
    }
    
    private func transition(toImage image:UIImage?, invertColor:Bool) {
        if invertColor {
            invertImage(img: image)
        } else {
            UIView.transition(with: self, duration: 0.3,
                              options: [.transitionCrossDissolve],
                              animations: {
                                self.image = image
                              }, completion: nil)
        }
            
    }
    
    private func invertImage(img : UIImage?) {
        let beginImage = CIImage(image: img!)
            if let filter = CIFilter(name: "CIColorInvert") {
                filter.setValue(beginImage, forKey: kCIInputImageKey)
                let newImage = UIImage(ciImage: filter.outputImage!)
                image = newImage
            }
        }
    
}
