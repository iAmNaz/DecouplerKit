//
//  EventCoordinator.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 09/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
@_exported import PromiseKit

/// A protocol implemented by the ResponderRegistry calss
public protocol Registry: Interface {
    /// Call this method to register your controllers or module representatives
    /// - parameter inputHandler: Input handlers are Interface conformant objects that can fulfill or manage a request.
    func register(inputHandler: NSObject)
}

/// The registrty is a container for controllers or request fullfillers.
/// There can be one or more registries that are either initialized at the start of the application or at a later time.
open class ResponderRegistry: NSObject, Registry {
    
    var subscribers = NSMapTable<NSString, AnyObject>(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
    
    // Use this to register an object
    open func register(inputHandler: NSObject) {
        let key = inputHandler.nameOfClass as NSString
        if inputHandler is Interface {
            subscribers.setObject(inputHandler as AnyObject, forKey: key)
            return
        }
        fatalError("Handler should implement the Interface protocol. Check if you added the interface in your class i.e. Class: Interface {}")
    }
    
    /// For classes that simply inherits from NSObject (Objective C) the class name is resolved correctly.
    /// In Swift the string name is not the same as the actual class and therefore different from
    /// the key you migh have used. To avoid that uncertainty a key parameter was added to be sure
    /// your object is registered with a key you expect that would retrieve the object.
    /// - parameter key: The string key used to register and retrieve the registered object
    /// instance
    open func register(inputHandler: NSObject, withKey key: String) {
        if inputHandler is Interface {
            subscribers.setObject(inputHandler as AnyObject, forKey: key as NSString)
            return
        }
        fatalError("Handler should implement the Interface protocol. Check if you added the interface in your class i.e. Class: Interface {}")
    }
    
    /// When the transmit method is called the registry is tasked to retrieve using the request's task key and call the handler's transmit method
    /// - parameter request: The incoming request object
    @discardableResult
    open func tx(request: Request) -> Promise<MessageContainer> {
        guard let obj = getRegisteredEntity(withKey: request.process.key) else {
            fatalError("Class not registered!")
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
