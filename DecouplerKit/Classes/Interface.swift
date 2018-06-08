//
//  Interface.swift
//  DecouplerKit
//
//  Created by Nazario Mariano on 03/06/2018.
//

import UIKit
import PromiseKit

public protocol Interface {
    func tx(request: Request) -> Promise<MessageContainer>
}
