//
//  EventCoordinator.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 09/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import PromiseKit

public protocol Registry: Interface {
    func register(inputHandler: NSObject)
}

public class ResponderRegistry: NSObject, Registry {
    
    var subscribers = NSMapTable<NSString, AnyObject>(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
    public static let shared = ResponderRegistry()
    
    public func register(inputHandler: NSObject) {
        subscribers.setObject(inputHandler as AnyObject, forKey: inputHandler.nameOfClass as NSString)
    }
    
    public func tx(request: Request) -> Promise<MessageContainer> {
        guard let obj = subscribers.object(forKey: request.process.key as NSString) else {
            return Promise { seal in
                seal.reject(RegistryError.set(description: "\(request.process.key) not registered!"))
            }
        }
        let handler = obj as! Interface
        return handler.tx(request: request)
    }
}
