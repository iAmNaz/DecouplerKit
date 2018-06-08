//
//  RegistrationResponseViewModel.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 09/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

public struct Response: MessageContainer {
    public var process: Processable!
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
