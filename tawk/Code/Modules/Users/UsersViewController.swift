//
//  UsersViewController.swift
//  tawk
//
//  Created by Adnan Munir on 27/07/2021.
//

import UIKit

final class UsersViewController: UITableViewController {
   
    @IBOutlet weak var tableViewUsers: UITableView!
    
    var searchController: UISearchController!
    
    var usersVM : UsersModeling! {
        didSet {
            self.usersVM.reloadView = {[unowned self] in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupSearchController()
        usersVM = UsersViewModel(usersService: UsersService())
        usersVM.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.reloadData()
    }
    
    /**
     Call this function to Configure Search Controller for displaying search results according to Username / Notes Text
     */
    private func setupSearchController() {
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for Users"
        navigationItem.titleView = searchController?.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.delegate = self
        definesPresentationContext = true
    }
    
}

//MARK: - Search Bar Delegate
extension UsersViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        usersVM.changeSearchStatus(status: true)
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        usersVM.changeSearchStatus(status: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        usersVM.changeSearchStatus(status: false)
    }
}

extension UsersViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text  else { return }
        usersVM.searchUsers(with: searchBarText)
    }
}

extension UsersViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersVM.getRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row + 1) == usersVM.getRows() && !usersVM.isSearchOn   {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreUsersTableViewCell.string, for: indexPath) as! LoadMoreUsersTableViewCell
            usersVM.loadMoreUsers()
            return cell
        }
        
        let cellModel = usersVM.getUserModel(at: indexPath.row)
        let cellIdentifier = cellModel.type.rawValue
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell

        customCell.configure(withModel: cellModel)

        return customCell as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = usersVM.getUser(at: indexPath.row)
        let userProfileVC = UserProfileViewController.instantiate(withStoryBoard: .Main)
        userProfileVC.userProfileVM = UserProfileViewModel(user: user, profileService: UserProfileService())
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
}
