//
//  NSObject+Extension.swift
//  tawk
//
//  Created by Adnan Munir on 31/07/2021.
//

import Foundation

extension NSObject {
   class var string : String {
        get {
            return String(describing: self) // gives name of the class
        } set (key) {
            
        }
    }
    
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}
