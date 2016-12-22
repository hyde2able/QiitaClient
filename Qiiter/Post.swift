//
//  Post.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    
    var id: String?
    var isPrivate: Bool?
    var title: String?
    var body: String?
    var renderdBody: String?
    var url: String?
    var tags: [Tag]?
    var user: User?
    var coEditing: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        isPrivate <- map["private"]
        title <- map["title"]
        body <- map["body"]
        renderedBody <- map["rendered_body"]
        url <- map["url"]
        tags <- map["tags"]
        user <- map["user"]
        coEditing <- map["coediting"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}
