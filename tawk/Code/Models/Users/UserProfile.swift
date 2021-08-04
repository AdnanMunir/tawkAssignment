//
//  UserProfile.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation
import CoreData

@objc(UserProfile)
public class UserProfile: NSManagedObject, Decodable {
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
    @NSManaged public var publicRepos: Int64
    @NSManaged public var publicGists: Int64
    @NSManaged public var followers: Int64
    @NSManaged public var following: Int64
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?
    
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
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.hireable = try container.decodeIfPresent(String.self, forKey: .hireable)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsernam)
        self.publicRepos = try container.decodeIfPresent(Int64.self, forKey: .publicRepos) ?? 0
        self.publicGists = try container.decodeIfPresent(Int64.self, forKey: .publicGists) ?? 0
        self.followers = try container.decodeIfPresent(Int64.self, forKey: .followers) ?? 0
        self.following = try container.decodeIfPresent(Int64.self, forKey: .following) ?? 0
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        }
}

//{
//  "login": "tawk",
//  "id": 9743939,
//  "node_id": "MDEyOk9yZ2FuaXphdGlvbjk3NDM5Mzk=",
//  "avatar_url": "https://avatars.githubusercontent.com/u/9743939?v=4",
//  "gravatar_id": "",
//  "url": "https://api.github.com/users/tawk",
//  "html_url": "https://github.com/tawk",
//  "followers_url": "https://api.github.com/users/tawk/followers",
//  "following_url": "https://api.github.com/users/tawk/following{/other_user}",
//  "gists_url": "https://api.github.com/users/tawk/gists{/gist_id}",
//  "starred_url": "https://api.github.com/users/tawk/starred{/owner}{/repo}",
//  "subscriptions_url": "https://api.github.com/users/tawk/subscriptions",
//  "organizations_url": "https://api.github.com/users/tawk/orgs",
//  "repos_url": "https://api.github.com/users/tawk/repos",
//  "events_url": "https://api.github.com/users/tawk/events{/privacy}",
//  "received_events_url": "https://api.github.com/users/tawk/received_events",
//  "type": "Organization",
//  "site_admin": false,
//  "name": null,
//  "company": null,
//  "blog": "",
//  "location": null,
//  "email": null,
//  "hireable": null,
//  "bio": null,
//  "twitter_username": null,
//  "public_repos": 29,
//  "public_gists": 0,
//  "followers": 0,
//  "following": 0,
//  "created_at": "2014-11-14T12:23:56Z",
//  "updated_at": "2016-06-02T16:06:17Z"
//}

