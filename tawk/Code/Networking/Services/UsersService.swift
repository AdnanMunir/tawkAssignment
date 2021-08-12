//
//  UsersService.swift
//  tawk
//
//  Created by Adnan Munir on 30/07/2021.
//

import Foundation
import CoreData

struct UsersService : UsersProtocol {
    
    func searchUsers(request: SearchUsersRequest, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        searchUsersFromLocalStorage(request: request, completion: completion)
    }
    
    func getUsers(request: GetUsersRequest, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        getUsersFromLocalStorage(request: request) { (result) in
            switch result {
                case .success(let users):
                    if users.count > 0 {
                        return completion(.success(users))
                    }
                    getUsersFromApi(request: request, completion: completion)
                    break
                case .failure(let failure):
                    completion(.failure(failure))
                    break
            }
        }
    }
    
    private func searchUsersFromLocalStorage(request: SearchUsersRequest, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login CONTAINS[cd] %@ or login == %@ or note CONTAINS[cd] %@ or note == %@"  ,request.searchText,request.searchText,request.searchText,request.searchText)
        fetchRequest.fetchLimit = 20
        
        do {
            let users = try CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest) as? [User]

            completion(.success(users ?? []))
            
            } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func getUsersFromLocalStorage(request: GetUsersRequest, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id > %i" ,request.userId)
        fetchRequest.fetchLimit = Int(request.limit)
        fetchRequest.returnsDistinctResults = true
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSortDescriptor]
        
        do {
            let users = try CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest) as? [User]
            completion(.success(users ?? []))
            
            } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func getUsersFromApi(request: GetUsersRequest, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        var components = URLComponents(string: C.BASE_URL.PATH)
        components?.queryItems = [URLQueryItem(name: "since", value: String(request.userId))]
        
        guard let url = components?.url else {
            completion(Result.failure(.APIError))
            return
        }
        
        var getUsersRequest = URLRequest(url: url)
        getUsersRequest.httpMethod = "GET"

        let request = GetUsersOperationRequest(urlRequest: getUsersRequest)
        let response = GetUsersOperationResponse()
        let operation = GetUsersOperation(getUsersRequest: request, getUsersResponse: response)
        
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
