//
//  tawkTests.swift
//  tawkTests
//
//  Created by Adnan Munir on 03/08/2021.
//

import XCTest
@testable import tawk
import CoreData

struct MockGetUserService : UsersProtocol {
    
    func getUsers(request : GetUsersRequest,completion: @escaping(Result<[User], NetworkError>) -> Void) {
        var users : [User] = []
        for i in 1...10 {
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.sharedManager.persistentContainer.viewContext) as! User

            user.id = Int64(i)
            user.login = "newUser" + String(i)
            users.append(user)
        }
        completion(.success(users))
    }
    
    func searchUsers(request : SearchUsersRequest,completion: @escaping(Result<[User], NetworkError>) -> Void) {
        var users : [User] = []
        for i in 1...10 {
            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.sharedManager.persistentContainer.viewContext) as! User

            user.id = Int64(i)
            user.login = "newUser" + String(i)
            users.append(user)
        }
        completion(.success(users))
    }
}

class tawkTests: XCTestCase {

    var usersService : UsersProtocol!
    var usersVM : UsersModeling!
    
    override func setUp() {
            super.setUp()
        usersService = MockGetUserService()
        usersVM = UsersViewModel(usersService: usersService)
        
    }
    
    override func tearDown() {
        usersVM = nil
        usersService = nil
    }
    
    func testGetUsers() {
        usersVM.viewDidLoad()
        
        let user = usersVM.getUser(at: 0)
        XCTAssertEqual(user.id, 1)
        
        // + 1 count for the Load More cell
        XCTAssertEqual(usersVM.getRows() , 11)
      
    }
    
    func testSearchUsers() {
        let searchText = "newUser1"
        let searchText2 = "newUser12"
        usersVM.viewDidLoad()
        usersVM.changeSearchStatus(status: true)
        usersVM.searchUsers(with: searchText)
        let user = usersVM.getUser(at: 0)
        usersVM.searchUsers(with: searchText2)
        let user2 = usersVM.getUser(at: 0)
        XCTAssertEqual(user.login, searchText)
        XCTAssertNotEqual(user2.login, searchText2)
    }

}
