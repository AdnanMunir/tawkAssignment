//
//  Storyboard+Extension.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation
import UIKit

enum Storyboard:String {
    case Main
}

protocol Storyboardable: AnyObject { }


extension Storyboardable where Self: UIViewController {
    
    
    /**
     Initializes the Controller from storyboard
     */
    static func instantiate(withStoryBoard storyBoard:Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: Self.string) as? Self else {
            fatalError("Could not instantiate storyboard with name: \(storyBoard.rawValue)")
        }
        return vc
    }
}

extension UIViewController: Storyboardable { }
