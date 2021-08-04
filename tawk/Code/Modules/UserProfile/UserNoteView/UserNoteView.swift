//
//  UserNoteView.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import UIKit


protocol UserNoteViewDelegate : class {
    /**
     Delegate method indicating that focus on map location where this note is pinned
     */
    func saveNote(note : String)
}

class UserNoteView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textViewNote: UITextView!
    
    weak var delegate :UserNoteViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed(UserNoteView.string, owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.cornerRadius = 5
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        textViewNote.layer.borderWidth = 1.0
        textViewNote.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureView(with details : UserNoteDetailsProtocol) {
        textViewNote.text = details.userNote
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        delegate?.saveNote(note: textViewNote.text)
    }
    
}
