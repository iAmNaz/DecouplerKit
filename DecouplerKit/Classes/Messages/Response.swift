//
//  RegistrationResponseViewModel.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 09/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

/// Response objects represents the product of a fulfilled request
/// A reponse may return a payload as a view model or data model
public struct Response: MessageContainer {
    public var process: Processable!
    
    /// A copy of the original request that resulted to this response
    var request: MessageContainer!
    
    private var payload: AnyObject!
    
    public init(proc: Processable) {
        self.process = proc
    }
    
    public init<T>(proc: Processable, body: T) {
        self.process = proc
        self.setBody(object: body)
    }
    
    public init(request: MessageContainer) {
        self.request = request
    }
    
    //Customize this to avoid rewriting "as AnyObject"
    mutating public func setBody<T>(object : T) {
        self.payload = object as AnyObject
    }
    
    public func body<T>() -> T {
        return self.payload as! T
    }
}
