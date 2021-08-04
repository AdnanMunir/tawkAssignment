//
//  UserProfileHeaderView.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import UIKit

class UserProfileHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageViewHeader: CustomImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(UserProfileHeaderView.string, owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.cornerRadius = 5
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func configureView(with imageUrl : String) {
        imageViewHeader.downloadImage(url: imageUrl, placeHolderImage: "user_icon")
    }
}
