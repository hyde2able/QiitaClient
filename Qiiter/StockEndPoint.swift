//
//  StockEndPoint.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension QiitaAPI {
    
    class GetStockers: RequestProtocol {
        
        typealias ResponseType = UserList
        var path: String
        var parameters: [String: AnyObject]? = ["per_page": 100]
        
        init(itemId: String) {
            path = "/api/v2/items/\(itemId)/stockers"
        }
        
        var responseSerializer: ResponseSerializer<ResponseType, NSError> {
            
            return ResponseSerializer<ResponseType, NSError> { request, response, data, error -> Result<ResponseType, NSError> in
                
                let resultJSON = Alamofire.Request.JSONResponseSerializer().serializeResponse(request, response, data, error)
                if let error = resultJSON.error {
                    return .Failure(erorr)
                }
                
                guard let object = Mapper<User>().mapArray(resultJSON.value) else {
                    return .Failure(NSError(domain: "com.hachinobu.qiitaclient", code: -1000, userInfo:
                        [NSLocalizedFailureReasonErrorKey: "Mapping Error"]))
                }
                
                let userList = UserList(users: object)
                return .Success(userList)
            }
        }
    }
    
    class StockOperation: RequestProtocol {
        
        typealias ResponseType = Bool
        var method: Alamofire.Method
        var path: String
        
        init(method: Alamofire.Method, itemId: String) {
            self.method = method
            path = "/api/v2/items/\(itemId)/stock"
        }
        
        var responseSerializer: ResponseSerializer<ResponseType, NSError> {
            
            return ResponseSerializer<ResponseType, NSError> { request, response, data, error -> Result<ResponseType, NSError> in
                if let error = error {
                    return .Failure(error)
                }
                return .Success(true)
            }
        }
    }
    
    class CheckStock: StockOperation {
        init(itemId: String) {
            super.init(method: Alamofire.Method.GET, itemId: itemId)
        }
    }
    
    class ToStock: StockOperation {
        init(itemId: String) {
            super.init(method: Alamofire.Method.PUT, itemId: itemId)
        }
    }
    
    class DeleteStock: StockOperation {
        init(itemId: String) {
            super.init(method: Alamofire.Method.DELETE, itemId: itemId)
        }
    }
}
