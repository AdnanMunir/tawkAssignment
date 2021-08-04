//
//  UserDetailsView.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import UIKit

class UserDetailsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    
    @IBOutlet weak var labelBlog: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed(UserDetailsView.string, owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.cornerRadius = 5
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func configureView(with details : UserProfileDetailsProtocol) {
        labelBlog.text = details.userBlog
        labelName.text = details.userName
        labelCompany.text = details.userCompany
        labelFollowers.text = details.userFollowers
        labelFollowing.text = details.userFollowing
        
    }
    
}
