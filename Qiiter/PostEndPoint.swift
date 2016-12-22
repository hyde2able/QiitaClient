//
//  PostsEndPoint.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension QiitaAPI {
    
    class AllPostList: RequestProtocol {
        
        typealias ResponseType = PostList
        var path: String = "/api/v2/items"
        var parameters: [String: AnyObject]?
        
        init(parameters: [String: AnyObject]?) {
            self.parameters = parameters
        }
        
        var responseSerializer: ResponseSerializer<ResponseType, NSError> {
            return ResponseSerializer<ResponseType, NSError> { request, response, data, error -> Result<ResponseType, NSError> in
                
                let resultJSON = Alamofire.Request.JSONResponseSerializer().serializeResponse(request, response, data, error)
                if let error = resultJSON.error {
                    return .Failure(error)
                }
                
                guard let object = Mapper<Post>().mapArray(resultJSON.value) else {
                    reutrn .Failure(NSError(domein: "com.hachinobu.qiitaclient", code: -1000, userInfo:
                        [NSLocalizedFailureReasonErrorKey: "Mapping Error"]))
                }
                
                let postList = PostList(posts: object)
                return .Success(postList)
            }
        }
    }
        
    class PostDetail: RequestProtocol {
        
        typealias ResponseType = Post
        var path: String = "/api/v2/items/"
        
        init(itemId: String) {
            path += itemId
        }
    }
}
