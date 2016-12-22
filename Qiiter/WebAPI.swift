//
//  WebAPI.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class QiitaAPI {
    class func call<T: RequestProtocol>(request: T, completion: Result<T.ResponseType, NSError> -> Void) {
        Alamofire.request(request.method, request.URLString, parameters: request.parameters, encoding: request.encoding,
            headers: request.headers)
            .progress { progress -> Void in
                // show Indicator
            }
            .validate()
            .response(queue: nil, responseSerializer: request.responseSerializer) { response -> Void in
                // hide Indicator
                if let sucessValue = response.result.value, response.result.isSuccess {
                    completion(.Success(successValue))
                    return
                }
                completion(.Failure(response.result.error!))
            }
    }
}

