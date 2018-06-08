//
//  ExerciseSession.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

struct ExcerciseSession: Equatable {
    var name: String
    var duration: Date
    var date: Date
    
    static func == (lhs: ExcerciseSession, rhs: ExcerciseSession) -> Bool {
        if lhs.name == rhs.name && lhs.duration == rhs.duration && lhs.date == rhs.date {
            return true
        }
        return false
    }
}
