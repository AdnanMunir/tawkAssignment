//
//  NoteTableViewCell.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import UIKit

class NoteTableViewCell: UITableViewCell,UserCell {
    var model : NoteUserModel!
    @IBOutlet weak var imageViewUser: CustomImageView!
    @IBOutlet weak var imageViewNotes: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    func configure(withModel model: UserCellModel) {
        guard let model = model as? NoteUserModel else { return }
        self.model = model
        
        labelUserName.text = model.user.login
        labelDetails.text = "details"
        
        imageViewUser.downloadImage(url: model.user.avatarUrl ?? "", placeHolderImage: "user_icon")
    }
}
