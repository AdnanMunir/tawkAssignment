//
//  SearchUsersRequest.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import Foundation

struct SearchUsersRequest {
    var searchText : String
    
    init(searchText : String = "" ) {
        self.searchText = searchText
    }
}
