//
//  PersistenceController.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

// In memory persistence
// Edit not implemented
class FakePersistentStoreController: NSObject, PersistentStore {
    fileprivate var sessions = [ExcerciseSession]()
    
    func edit(session: ExcerciseSession) {
        
    }
    
    func add(session: ExcerciseSession) {
        sessions.append(session)
    }
    
    func list() -> [ExcerciseSession] {
        return sessions
    }
    
    func delete(session: ExcerciseSession) -> ExcerciseSession? {
        var deleted: ExcerciseSession?
        
        for (index, item) in sessions.enumerated() {
            print("Found \(item) at position \(index)")
            if item == session {
                sessions.remove(at: index)
                deleted = session
            }
        }
        
        return deleted
    }
}
