//
//  AppError.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation

enum AppError: Error {
    case connection
    case response
    case unauthorized
    case unknown
    case urlScheme
    case social
}
