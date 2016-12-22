//
//  Tag.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import ObjectMapper

struct Tag: Mappable {
    
    var name: String?
    var versions: String?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- name["name"]
        versions <- map["versions"]
    }
}
