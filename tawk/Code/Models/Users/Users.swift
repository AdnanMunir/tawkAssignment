//
//  Users.swift
//  tawk
//
//  Created by Adnan Munir on 29/07/2021.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {
    @NSManaged public var login: String?
    @NSManaged public var id: Int64
    @NSManaged public var noteId: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var gravatarId: String?
    @NSManaged public var url: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var followersUrl: String?
    @NSManaged public var followingUrl: String?
    @NSManaged public var gistsUrl: String?
    @NSManaged public var starredUrl: String?
    @NSManaged public var subscriptionsUrl: String?
    @NSManaged public var organizationsUrl: String?
    @NSManaged public var reposUrl: String?
    @NSManaged public var eventsUrl: String?
    @NSManaged public var receivedEventsUrl: String?
    @NSManaged public var type: String?
    @NSManaged public var siteAdmin: Bool
    @NSManaged public var name: String?
    @NSManaged public var company: String?
    @NSManaged public var blog: String?
    @NSManaged public var location: String?
    @NSManaged public var email: String?
    @NSManaged public var hireable: String?
    @NSManaged public var bio: String?
    @NSManaged public var twitterUsername: String?
    @NSManaged public var publicRepos: String?
    @NSManaged public var publicGists: String?
    @NSManaged public var followers: String?
    @NSManaged public var following: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var note: String?
    
    enum CodingKeys : String,CodingKey {
        case login
        case id
        case noteId = "note_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
        case note
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case twitterUsernam = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
        case updatedAt = "updated_at"        
    }

    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }
        
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
        self.noteId = try container.decodeIfPresent(String.self, forKey: .noteId)
        self.gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.followersUrl = try container.decodeIfPresent(String.self, forKey: .followersUrl)
        self.followingUrl = try container.decodeIfPresent(String.self, forKey: .followingUrl)
        self.gistsUrl = try container.decodeIfPresent(String.self, forKey: .gistsUrl)
        self.starredUrl = try container.decodeIfPresent(String.self, forKey: .starredUrl)
        self.subscriptionsUrl = try container.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        self.organizationsUrl = try container.decodeIfPresent(String.self, forKey: .organizationsUrl)
        self.reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl)
        self.eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl)
        self.receivedEventsUrl = try container.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
        }
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
//{
//    "login": "mojombo",
//    "id": 1,
//    "node_id": "MDQ6VXNlcjE=",
//    "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/mojombo",
//    "html_url": "https://github.com/mojombo",
//    "followers_url": "https://api.github.com/users/mojombo/followers",
//    "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
//    "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
//    "organizations_url": "https://api.github.com/users/mojombo/orgs",
//    "repos_url": "https://api.github.com/users/mojombo/repos",
//    "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/mojombo/received_events",
//    "type": "User",
//    "site_admin": false
//  }
