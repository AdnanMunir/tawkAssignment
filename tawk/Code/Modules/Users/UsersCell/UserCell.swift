//
//  UserCell.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import Foundation

enum UserCellType: String {
    case normal = "NormalTableViewCell"
    case note = "NoteTableViewCell"
    case inverted = "InvertedTableViewCell"
}

protocol UserCellModel: class {
    var type: UserCellType { get }
}

protocol UserCell: class {
    func configure(withModel model: UserCellModel)
}
