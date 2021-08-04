//
//  NormalTableViewCell.swift
//  tawk
//
//  Created by Adnan Munir on 03/08/2021.
//

import UIKit

class NormalTableViewCell: UITableViewCell,UserCell {
    var model : NormalUserModel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewUser: CustomImageView!
    @IBOutlet weak var labelDetails: UILabel!
    
    func configure(withModel model: UserCellModel) {
        guard let model = model as? NormalUserModel else { return }
        self.model = model
        
        labelUserName.text = model.user.login
        labelDetails.text = "details"
        
        imageViewUser.downloadImage(url: model.user.avatarUrl ?? "", placeHolderImage: "user_icon")
    }

}
