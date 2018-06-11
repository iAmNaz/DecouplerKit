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

class FormController: NSObject, Interface {
    func tx(request: Request) -> Promise<MessageContainer> {
        let task = request.process as! Task
        
        switch task {
        case .Form(.Validate(.AddSession)):
            return validate(request:request)
        default:
            return Promise { seal in
                seal.reject(AppError.generic(.undefined(message: "FormController is unable to handle the task")))
            }
        }
    }
    
    func validate(request: Request) -> Promise<MessageContainer> {
        let session = request.body() as ExerciseSessionViewModel
        
        guard let name = session.name else {
            return Promise { seal in
                seal.reject(AppError.form(.invalid(.name, .empty(message: "Name is empty"))))
            }
        }
        
        if name.isEmpty {
                 return Promise { seal in
                    seal.reject(AppError.form(.invalid(.name, .empty(message: "Name is empty"))))
                }
            }
            
            if session.date == nil {
                 return Promise { seal in
                    seal.reject(AppError.form(.invalid(.date, .empty(message: "Date is empty"))))
                }
            }
            
            if session.duration == nil {
                 return Promise { seal in
                    seal.reject(AppError.form(.invalid(.duration, .empty(message: "Duration is empty"))))
                }
            }
        
         return Promise { seal in
            seal.resolve(Response(proc: request.process), nil)
        }
    }
}
