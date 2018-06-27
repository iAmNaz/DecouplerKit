//
//  Request.swift
//  SingularAPI
//
//  Created by Nazario Mariano on 22/05/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit


/// A protocol implemented by an enum that serves as the parcel for task types.
///
/// ### Usage Example: ###
///
///     enum Task: Processable, Equatable {
///        var key: String {
///            get {
///             switch self {
///                    case .Form( _):
///                        return "FormController"
///                }
///            }
///     }
///        enum FormController {}
///        case Form(FormController)
///     }
///
/// ### Note: ###
/// Processable is a 1 to 1 relationship between a process class and a task category
public protocol Processable {
    
    /// Every task used for the request and response input or output must implement the key property.
    /// The key property is used to retrieve instances of objects assigned to fulfill a task
    var key: String { get }
}

/// The MessageContainer protocol is implement by both Request and Response objects.
public protocol MessageContainer {
    /// An initializer where data is not needed
    /// - parameter proc: The task description
    init(proc: Processable)
    
    /// An initializer where data and task description are needed
    /// - Parameters:
    ///     - proc: The task description
    ///     - body: An object that wraps the request data
    init<T>(proc: Processable, body: T)
    
    /// Setter and getter property for the task description
    var process: Processable! { get set }
    
    /// Input data may be introduced after the container is initialized and this method allows setting the input data at a later time
    /// - Parameters:
    ///     - object: Any object of any type that wraps the data needed to be processed
    mutating func setBody<T>(object : T)
    
    /// Call this method when an operation need to retrieve the container's payload
    /// - Returns:
    /// Type T payload
    func body<T>() -> T
}

/// When an input is needed to be processed or passed to another process
/// an instance of the request is passed down to the object that fulfills the task.
///
/// A request could be consumed once and a response is passed back up the caller or
/// it could be also be the response object instead of using a Response instance.
///
/// When a request requires pre-processing such as form validation then remote service consumption
/// is a good example where requests are sometimes used as the response object. The process attribute may need to be adjusted so that the proper object the fulfills the succeeding tasks will be properly matched and retrieved.
public struct Request: MessageContainer, Equatable {
    public var process: Processable!
    private var payload: AnyObject!
    
    public init(proc: Processable) {
        self.process = proc
    }
    
    public init<T>(proc: Processable, body: T) {
        self.process = proc
        self.setBody(object: body)
    }
    
    mutating public func setBody<T>(object : T) {
        self.payload = object as AnyObject
    }
    
    public func body<T>() -> T {
        return self.payload as! T
    }
    
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.process.key == rhs.process.key
    }
}
