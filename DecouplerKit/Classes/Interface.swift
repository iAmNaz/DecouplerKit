//
//  Interface.swift
//  DecouplerKit
//
//  Created by Nazario Mariano on 03/06/2018.
//

import UIKit
import PromiseKit

/// The Interface plays a big role in ensuring a decoupled architecture and a means of passing task description and data from to the requesting object to the object that fulfills that request.
/// With the use of promises, this ensures that responses are returned to callers. The reponse could either be a success with or without a payload or an error object.
/// The Interface protocol is mostly implemented by a representative class of a module such as a controller for form validation or REST API.
/// These controllers acts as a delegate or representative of a given concept or functionality and has knowledge on which object can fulfill a specific request. Controllers or fulfillers that implements the Interface is like a telephone operator, given the task description will be able to forward the request to the right fulfiller.
public protocol Interface {
    
    /// The transmit method is called when the caller wants to transmit the request down to the request fulfiller
    /// - parameter request: The input request from the caller
    func tx(request: Request) -> Promise<MessageContainer>
}
