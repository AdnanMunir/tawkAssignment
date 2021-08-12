//
//  APIInterface.swift
//  tawk
//
//  Created by Adnan Munir on 27/07/2021.
//

import Foundation

enum NetworkError: Error {
    case APIError
}

final class APIInterface {
    static let sharedInstance = APIInterface()
    private init() { }
    
    private let allowedDiskSize = 20 * 1024 * 1024
    private let allowedMemSize = 150 * 1024 * 1024
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: allowedMemSize, diskCapacity: allowedDiskSize, diskPath: "tawkImageCache")
    }()
    
    private func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
        sessionConfiguration.allowsCellularAccess = true
        sessionConfiguration.httpShouldSetCookies = true
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }
   
    let session = URLSession.shared
    
    func execute<T:Decodable>(request : URLRequest,decodingType: T.Type,completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        let task = session.dataTask(with: request) {[weak self] data, response, error in
            if let _ = error {
                let err = error! as NSError
                
                if err.code == -1009 || err.code == -1020 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetNotAvailable"), object: nil, userInfo: nil)
                    sleep(2)
                    self?.execute(request: request, decodingType: decodingType, completion: completion)
                    return
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetAvailable"), object: nil, userInfo: nil)
            
            if error != nil {
                completion(.failure(.APIError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.userInfo[.managedObjectContext] = CoreDataManager.sharedManager.backgroundContext
                
                let users = try decoder.decode(T.self, from: data!)
                CoreDataManager.sharedManager.saveBackgroundContext()
                completion(.success(users))
            }
            catch {
                print("Error during json serilization: - ", error.localizedDescription)
                completion(.failure(.APIError))
            }
        }
        
        task.resume()
    }
    
    
    func imageData(from request : URLRequest, completion: @escaping (Result<(Data?,URLResponse?), Error>) -> ()) {
        
        let session = createAndRetrieveURLSession()
        
        session.dataTask(with: request) {[weak self] data, response, error in
            
            if let _ = error {
                let err = error! as NSError
                
                if err.code == -1009 || err.code == -1020 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetNotAvailable"), object: nil, userInfo: nil)
                    sleep(2)
                    self?.imageData(from: request, completion: completion)
                    return
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetAvailable"), object: nil, userInfo: nil)
            if error == nil {
                completion(.success((data,response)))
                
            }
            else{
                completion(.failure(error!))
            }
        }.resume()
        
    }
}
