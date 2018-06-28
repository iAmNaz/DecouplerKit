//
//  ExerciseSessionViewModel.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

struct ExerciseSessionViewModel: Equatable {
    var dateFormatter: DateFormatter
    var uniqueId: String
    var name: String?
    var date: Date?
    var duration: Date?
    
    func formattedDate() -> String {
        return dateFormatter.string(from: date!)
    }
    
    func formattedDuration() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: duration!)
        if let hr = components.hour, let min = components.minute {
            return "\(hr) hrs \(min) mins"
        }
        return ""
    }
    
    static func == (lhs: ExerciseSessionViewModel, rhs: ExerciseSessionViewModel) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
}
