//
//  UserProfileDetailsProtocol.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

protocol UserProfileDetailsProtocol {
    var userName:String {get}
    var userCompany : String {get }
    var userBlog : String {get }
    var userFollowers : String {get }
    var userFollowing : String {get}
}

extension UserProfile : UserProfileDetailsProtocol {
    var userName: String {
        return name ?? "Not Available"
    }
    
    var userCompany: String {
        return company ?? "Not Available"
    }
    
    var userBlog: String {
        return blog ?? "Not Available"
    }
    
    var userFollowers: String {
        return String(followers)
    }
    
    var userFollowing: String {
        return String(following)
    }
}
