//
//  Enumerations.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 24/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}
