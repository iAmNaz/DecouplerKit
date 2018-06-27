//
//  EventCoordinator.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 09/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import PromiseKit

/// A protocol implemented by the ResponderRegistry calss
public protocol Registry: Interface {
    /// Call this method to register your controllers or module representatives
    /// - parameter inputHandler: Input handlers are Interface conformant objects that can fulfill or manage a request.
    func register(inputHandler: NSObject)
}

/// The registrty is a container for controllers or request fullfillers.
/// There can be one or more registries that are either initialized at the start of the application or at a later time.
public class ResponderRegistry: NSObject, Registry {
    
    var subscribers = NSMapTable<NSString, AnyObject>(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
    public static let shared = ResponderRegistry()
    
    public func register(inputHandler: NSObject) {
        subscribers.setObject(inputHandler as AnyObject, forKey: inputHandler.nameOfClass as NSString)
    }
    
    /// When the transmit method is called the registry is tasked to retrieve using the request's task key and call the handler's transmit method
    /// - parameter request: The incoming request object
    public func tx(request: Request) -> Promise<MessageContainer> {
        guard let obj = getRegisteredEntity(withKey: request.process.key) else {
            return Promise { seal in
                seal.reject(RegistryError.set(description: "\(request.process.key) not registered!"))
            }
        }
        let handler = obj
        return handler.tx(request: request)
    }
    
    /// There could be instances where checking of object membership is needed to be confirmed.
    /// Use this method and pass the processable description to get a boolean result.
    /// - parameter process: The Processable parameter
    /// - Returns:
    /// Boolean if the object is a member
    public func isRegistered(withProcess process: Processable) -> Bool {
        return getRegisteredEntity(withKey: process.key) != nil
    }
    
    fileprivate func getRegisteredEntity(withKey key: String) -> Interface?{
        guard let obj = subscribers.object(forKey: key as NSString) else {
            return nil
        }
        return obj as? Interface
    }
}
