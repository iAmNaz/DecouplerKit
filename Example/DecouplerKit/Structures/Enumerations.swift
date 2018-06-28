//
//  Enumerations.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 06/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import DecouplerKit

let keyExerciseController = "ExerciseController"
let keyFormController = "FormController"

enum Task: Processable, Equatable {
    var key: String {
        get {
            switch self {
            case .Exercise( _):
                return keyExerciseController
            case .Form( _):
                return keyFormController
            }
        }
    }
    
    case Exercise(ExerciseController)
    case Form(FormController)
    
    enum ExerciseController {
        case list
        case add
        case edit
        case delete
    }
    
    enum FormController {
        case Validate(Forms)
        enum Forms {
            case AddSession
            case DeleteSession
        }
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        switch (lhs, rhs) {
        case (let .Exercise(task1), let .Exercise(task2)):
            return task1 == task2
        case (let .Form(.Validate(task1)), let .Form(.Validate(task2))):
            return task1 == task2
        case (.Form(_), .Exercise(_)):
            return false
        case (.Exercise(_), .Form(_)):
            return false
        }
    }
    
}

