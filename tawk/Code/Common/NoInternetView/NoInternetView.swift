//
//  NoInternetView.swift
//  tawk
//
//  Created by Adnan Munir on 12/08/2021.
//

import UIKit

class NoInternetView: UIView {
    @IBOutlet var contentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed(NoInternetView.string, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
    }

}
