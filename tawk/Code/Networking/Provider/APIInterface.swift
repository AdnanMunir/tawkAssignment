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
    
    private let allowedDiskSize = 100 * 1024 * 1024
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "tawkImageCache")
    }()
    
    private func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }
   
    let session = URLSession.shared
    
    func execute<T:Decodable>(request : URLRequest,decodingType: T.Type,completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.APIError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.userInfo[.managedObjectContext] = CoreDataManager.sharedManager.persistentContainer.viewContext
                
                let users = try decoder.decode(T.self, from: data!)
                CoreDataManager.sharedManager.saveContext()
                completion(.success(users))
            }
            catch {
                print("Error during json serilization: - ", error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    func imageData(from request : URLRequest, completion: @escaping (Result<(Data?,URLResponse?), Error>) -> ()) {
        
        let session = createAndRetrieveURLSession()
        
        session.dataTask(with: request) { data, response, error in
            if error == nil {
                completion(.success((data,response)))
                
            }
            else{
                completion(.failure(error!))
            }
        }.resume()
        
    }
}
