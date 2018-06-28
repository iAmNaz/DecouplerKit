//
//  ExerciseSession.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

struct ExcerciseSession: Equatable {
    var uniqueId: String
    var name: String
    var duration: Date
    var date: Date
    
    static func == (lhs: ExcerciseSession, rhs: ExcerciseSession) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
}
