//
//  InvertedUserModel.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import Foundation

class InvertedUserModel: UserCellModel {
    var type: UserCellType {.inverted}
    var user : User
    
    init(user : User) {
        self.user = user
    }
}
