//
//  WebAPI.RequestProtocol.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    
    associatedtype ResponseType
    
    var method: Alamofire.Method { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: AnyObject]? { get }
    var encoding: ParameterEncoding { get }
    var isAccessToken: Bool { get }
    var headers: [String: String]? { get }
    var cachePolicy: NSURLRequestCachePolicy { get }
    var responseSerializer: ResponseSerializer<ResponseType, NSError> { get }
    
}

extension RequestProtocol {
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var baseURL: String {
        return AppConfig.Qiita.BaseUrl
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var URLString: String {
        return baseURL + path
    }
    
    var encoding: ParameterEncoding {
        return .URL
    }
    
    var isAccessToken: Bool {
        return true
    }
    
    var headers: [String: String]? {
        if isAccessToken {
            let accessToken = AppConfig.Qiita.AccessToken
            return ["Authorization": "Bearer \(accessToken)"]
        }
        return nil
    }
    
    var cachePolicy: NSURLRequestPolicy {
        return .ReloadIgnoringLocalCacheData
    }
    
    var URLRequest: NSURLRequest {
        let request = NSMutableURLRequest()
        request.HTTPMethod = method.rawValue
        request.URL = NSURL(string.URLString)
        request.cachePolicy = cachePolicy
        encoding.encode(request, parameters: parameters)
        setHeaders(request, headers: headers)
        return request
    }
    
    private func setHeaders(mutableURLRequest: NSMutableRequest, headers: [String: String]?) {
        guard let headers = headers else {
            return
        }
        for (field, value) in headers {
            mutableURLRequest.setValue(value, forKey: field)
        }
    }
    
}

extension RequestProtocol where ResponseType: Mappable {
    
    var responseSerializer: ResponseSerializer<ResponseType, NSError> {
        return ResponseSerializer<ResponseType, NSError> { request, response, data, erorr -> Result<ResponseType, NSError> in
            
            let resultJSON = Alamofire.Request.JSONResponseSerializer().serializeResponse(request, response, data, error)
            if let error = resultJSON.error {
                return .Failure(error)
            }
            guard let object = Mapper<ResponseType>().map(resultJSON.value) else {
                return .Failure(NSErorr(domain: "com.hachinobu.qiitaclient", code: -1000, userInfo:
                    [NSLocalizedFailureReasonErrorKey: "Mapping Error"]))
            }
            
            return .Success(object)
        }
    }
}

