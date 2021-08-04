//
//  NormalUserMode.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import Foundation

class NormalUserModel: UserCellModel {
    var type: UserCellType {.normal}
    var user : User
    
    init(user : User) {
        self.user = user
    }
}

