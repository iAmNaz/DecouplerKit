//
//  FormController.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 07/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import DecouplerKit
import PromiseKit

class ExerciseController: NSObject, Interface {
    var dateFormatter: DateFormatter!
    var dataStoreController: PersistentStore!
    
    func tx(request: Request) -> Promise<MessageContainer> {
        let task = request.process as! Task
        
        switch task {
        case .Exercise(.list):
            return list(proc: task)
        case .Exercise(.add):
            return add(request: request)
        case .Exercise(.delete):
            return delete(request: request)
        case .Exercise(.edit):
            return edit(request: request)
        default:
            return Promise { seal in
                seal.reject(AppError.generic(.undefined(message: "ExerciseController is unable to handle the task")))
            }
        }
    }
    
    func add(request: Request) -> Promise<MessageContainer> {
        let composerData = request.body() as ExerciseSessionViewModel
        let session = sessionVMtoData(vm: composerData)
        dataStoreController.add(session: session)
        
        return Promise { seal in
            seal.fulfill(Response(proc: request.process))
        }
    }
    
    func edit(request: Request) -> Promise<MessageContainer> {
        let composerData = request.body() as ExerciseSessionViewModel
        let session = sessionVMtoData(vm: composerData)
            dataStoreController.edit(session: session)
        
        return Promise { seal in
            seal.fulfill(Response(proc: request.process))
        }
    }
    
    func delete(request: Request) -> Promise<MessageContainer> {
        let composerData = request.body() as ExerciseSessionViewModel
        let session = sessionVMtoData(vm: composerData)
    
        guard let sessionToDelete = dataStoreController.delete(session: session) else {
            return Promise { seal in
                seal.reject(AppError.sessionManagement(.notFound))
            }
        }
        
        let response = Response(proc: request.process, body: sessionToDelete)
        return Promise { seal in
            seal.resolve(response, nil)
        }
    }
    
    func list(proc: Processable) -> Promise<MessageContainer> {
        var allVMs = [ExerciseSessionViewModel]()
        for session in dataStoreController.list() {
            let vm = dataToSessionVM(data: session)
            allVMs.append(vm)
        }
        let response = Response(proc: proc, body: allVMs)
        return Promise { seal in
            seal.resolve(response, nil)
        }
    }
    
    fileprivate func dataToSessionVM(data: ExcerciseSession)-> ExerciseSessionViewModel {
        let vm = ExerciseSessionViewModel(dateFormatter: dateFormatter, name: data.name, date: data.date, duration: data.duration)
        return vm
    }
    
    fileprivate func sessionVMtoData(vm: ExerciseSessionViewModel) -> ExcerciseSession {
        let session = ExcerciseSession(name: vm.name!, duration: vm.duration!, date: vm.date!)
        return session
    }
}
