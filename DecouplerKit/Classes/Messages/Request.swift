//
//  Request.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 22/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

public protocol Processable {
    var key: String { get }
}

//Use primitive types as value when possible
public protocol MessageContainer {
    init(proc: Processable)
    init<T>(proc: Processable, body: T)
    var process: Processable! { get set }
    mutating func setBody<T>(object : T)
    func body<T>() -> T
}

public struct Request: MessageContainer {
    public var process: Processable!

    private var payload: AnyObject!
    
    public init(proc: Processable) {
        self.process = proc
    }
    
    public init<T>(proc: Processable, body: T) {
        self.process = proc
        self.setBody(object: body)
    }
    
    //Customize this to avoid rewriting "as AnyObject"
    mutating public func setBody<T>(object : T) {
        self.payload = object as AnyObject
    }
    
    public func body<T>() -> T {
        return self.payload as! T
    }
}
