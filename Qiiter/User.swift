//
//  UserModel.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var permanentId: String?
    var id: String?
    var name: String?
    var location: String?
    var profileImageUrl: String?
    var twitterScreenName: String?
    var facebookId: String?
    var linkdInId: String?
    var githubAccountName: String?
    var itemsCount: Int?
    var followeesCount: Int?
    var followersCount: Int?
    var orgnization: String?
    var websiteUrl: String?
    var description: String?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        permanentId <- map["permanent_id"]
        id <- map["id"]
        name <- map["name"]
        location <- map["location"]
        profileImageUrl <- map["profile_image_url"]
        twitterScreenName <- map["twitter_screen_name"]
        facebookId <- map["facebook_id"]
        linkedInId <- map["linkedin_id"]
        githubAccountName <- map["github_login_name"]
        itemsCount <- map["items_count"]
        followeesCount <- map["followees_count"]
        followersCount <- map["followers_count"]
        organization <- map["organization"]
        websiteUrl <- map["website_url"]
        description <- map["description"]
    }
}
