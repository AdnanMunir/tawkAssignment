//
//  UserProfileService.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation
import CoreData

struct UserProfileService : UserProfileProtocol {
    
    func saveUserNote(request: SaveUserNoteRequest, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id == %i" ,request.userId)
        
        do {
            let user = CoreDataManager.sharedManager.backgroundContext.object(with: request.userId) as? User
//            let users = try CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest) as? [User]
            if let user = user  {
                user.note = request.userNote
                
                CoreDataManager.sharedManager.saveBackgroundContext()
                completion(.success(true))
            }
            completion(.success(false))
            
            }
    }
    

    func getUserProfile(request: GetUserProfileRequest, completion: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        getUserProfileFromLocalStorage(request: request) { (result) in
            switch result {
            case .success(let user):
                if let user = user {
                    return completion(.success(user))
                }
                getUserProfileFromApi(request: request, completion: completion)
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    private func getUserProfileFromLocalStorage(request: GetUserProfileRequest, completion: @escaping (Result<UserProfile?, NetworkError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        fetchRequest.predicate = NSPredicate(format: "login == %@" ,request.userName)
        
        do {
            let users = try CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest) as? [UserProfile]
            if let users = users, users.count > 0  {
                completion(.success(users.first))
                return
            }
            completion(.success(nil))
            
            } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
                completion(.failure(.APIError))
        }
    }
    
    private func getUserProfileFromApi(request: GetUserProfileRequest, completion: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        
        let profileUrl = C.BASE_URL.PATH + "/" + request.userName
        guard let url = URL(string: profileUrl) else {
            completion(Result.failure(.APIError))
            return
        }
        
        var getUsersRequest = URLRequest(url: url)
        getUsersRequest.httpMethod = "GET"

        let request = GetUserProfileOperationRequest(urlRequest: getUsersRequest)
        let response = GetUserProfileOperationResponse()
        let operation = GetUserProfileOperation(getUserProfileRequest: request, getUserProfileResponse: response)
        
        operation.completionBlock = {
            if operation.isCancelled {
              return
            }
            
            switch response.state {
            case .success(let users):
                completion(.success(users))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            default:
                break
            }
        }
        
        OperationsManager.sharedInstance.dataQueue.addOperation(operation)
        
    }
    
}
