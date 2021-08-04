//
//  UserProfileViewController.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var headerView: UserProfileHeaderView!
    
    @IBOutlet weak var detailsView: UserDetailsView!
    
    @IBOutlet weak var noteView: UserNoteView!
    
    var userProfileVM : UserProfileModeling! {
        didSet {
            self.userProfileVM.reloadView = {[unowned self] in
                DispatchQueue.main.async {
                    self.detailsView.configureView(with: self.userProfileVM.getUserDetails())
                }
            }
            
            self.userProfileVM.loadHeaderView = {[unowned self] url in
                self.headerView.configureView(with: url)
                self.noteView.configureView(with: self.userProfileVM.getUserNote())
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        userProfileVM.viewDidLoad()
    }
    
    private func setupView() {
        hideKeyboardWhenTappedAround()
        configNavigationBar()
        noteView.delegate = self
        addNotifications()
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = userProfileVM.getUserName()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension UserProfileViewController: UserNoteViewDelegate {
    func saveNote(note: String) {
        userProfileVM.saveUserNote(note: note)
        view.endEditing(true)
    }
}
