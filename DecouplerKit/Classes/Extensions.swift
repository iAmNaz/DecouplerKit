//
//  Extensions.swift
//  DecouplerKit
//
//  Created by Nazario Mariano on 03/06/2018.
//

import UIKit

public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy:".").last!
    }
}
