//
//  Enumerations.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 06/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import DecouplerKit

enum Task: Processable, Equatable {
    var key: String {
        get {
            switch self {
            case .WorkOut( _):
                return "ExerciseController"
            case .Form( _):
                return "FormController"
            }
        }
    }
    
    enum WorkoutController {
        case list
        case add
        case edit
        case delete
    }
    
    case WorkOut(WorkoutController)
    case Form(FormController)
    
    enum FormController {
        enum Forms {
            case AddSession
        }
        case Validate(Forms)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        switch (lhs, rhs) {
        case (let .WorkOut(task1), let .WorkOut(task2)):
            return task1 == task2
        case (let .Form(.Validate(task1)), let .Form(.Validate(task2))):
            return task1 == task2
        default:
            return false
        }
    }
    
}

