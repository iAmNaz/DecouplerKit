//
//  Errors.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 30/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

public enum RegistryError: Error {
    case set(description: String)
}

extension RegistryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .set(let description):
            return description
        }
    }
}

