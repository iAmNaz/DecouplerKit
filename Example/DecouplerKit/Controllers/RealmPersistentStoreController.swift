//
//  PersistenceController.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import RealmSwift

class Exercise: Object {
    @objc dynamic var name: String!
    @objc dynamic var date: Date!
    @objc dynamic var duration: Date!
    
    func toExerciseSession() -> ExcerciseSession {
        return ExcerciseSession(name: name, duration: duration, date: date)
    }
}

class RealmPersistentStoreController: NSObject, PersistentStore {
    fileprivate let realm = try! Realm()
    
    func add(session: ExcerciseSession) {
        let exercise = Exercise()
        exercise.date = session.date
        exercise.name = session.name
        exercise.duration = session.duration
        // Persist your data easily
        try! realm.write {
            realm.add(exercise)
        }
    }
    
    func list() -> [ExcerciseSession] {
        let exercises = realm.objects(Exercise.self).sorted(byKeyPath: "date")
        var sessions = [ExcerciseSession]()
        for ex in exercises {
            sessions.append(ex.toExerciseSession())
        }
        return sessions
    }
    
    func delete(session: ExcerciseSession) -> ExcerciseSession? {
        guard let exercise = findObject(session: session) else {
            return nil
        }

        try! realm.write {
            realm.delete(exercise)
        }
        return session
    }
    
    func edit(session: ExcerciseSession) {
        guard let exercise = findObject(session: session) else {
            return
        }

        try! realm.write {
            exercise.name = session.name
            exercise.date = session.date
            exercise.duration = session.duration
            realm.add(exercise)
        }
    }
    
    fileprivate func findObject(session: ExcerciseSession) -> Exercise? {
        let predicate = NSPredicate(format: "date = %@" , session.date as CVarArg)
        let exercises = realm.objects(Exercise.self).filter(predicate)
        if !exercises.isEmpty {
            return exercises.first!
        }
        return nil
        
    }
}
