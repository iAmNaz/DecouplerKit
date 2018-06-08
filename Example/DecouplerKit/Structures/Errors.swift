//
//  Errors.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 06/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

enum AppError: Error {
    enum FieldError {
        case input(message: String)
        case empty(message: String)
        case format(message: String)
        
        var message: String? {
            switch self {
            case .input(let message):
                return message
            case .empty(let message):
                return message
            case .format(let message):
                return message
            }
        }
    }
    
    enum SessionManagementError {
        case deleteFailed
        case notFound
    }
    
    case sessionManagement(SessionManagementError)
    
    case form(FormValidationError)
    enum FormValidationError {
        enum Fields {
            case name
            case duration
            case date
        }
        
        case invalid(Fields, FieldError)
        case multiple(errors: [AppError])
    }
    
    case generic(GenericError)
    enum GenericError {
        case undefined(message: String)
    }
}

extension AppError: LocalizedError {
    var errors: [AppError]? {
        switch self {
        case .form(.multiple(let errors)):
            return errors
        default:
            return nil
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .generic(.undefined(let message)):
            return message
        default:
            return "Error unknown"
        }
    }
}
