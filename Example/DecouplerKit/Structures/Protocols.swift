//
//  Protocols.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 08/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

protocol PersistentStore {
    func add(session: ExcerciseSession)
    func list() -> [ExcerciseSession]
    func delete(session: ExcerciseSession) -> ExcerciseSession?
    func edit(session: ExcerciseSession)
}
