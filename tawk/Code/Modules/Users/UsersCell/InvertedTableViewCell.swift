//
//  InvertedTableViewCell.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import UIKit

class InvertedTableViewCell: UITableViewCell,UserCell {
    var model : InvertedUserModel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewUser: CustomImageView!
    
    func configure(withModel model: UserCellModel) {
        guard let model = model as? InvertedUserModel else { return }
        self.model = model
        
        labelUserName.text = model.user.login
        labelDetails.text = "details"
        imageViewUser.userId = model.user.id
        imageViewUser.downloadImage(url: model.user.avatarUrl ?? "",invertImage: true, placeHolderImage: "user_icon",userId: model.user.id)
    }
}
