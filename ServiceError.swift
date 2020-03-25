//
//  ServiceError.swift
//  social_project
//
//  Created by Saeed Ali on 12/13/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation
enum ServiceError: Error {
    case noInternetConnection
    case custom(String)
    case other
}

extension ServiceError: LocalizedError{
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
        }
    }
}

extension ServiceError {
    init(json: JSON ) {
        if let message = json["msg"] as? String{
            self = .custom(message)
        }else
        {
            self = .other   
        }
    }
}
