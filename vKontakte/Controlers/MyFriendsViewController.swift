//
//  MyFriendsViewController.swift
//  vKontakte
//
//  Created by Andrew on 19/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class MyFriendsViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let networkService = NetworkService()
    var friendDictionary = [String:[FriendModels]]()
    var friendSectionTitle = [String]()
    var filteredArrays = [FriendModels]()
    
    let searchController = UISearchController(searchResultsController: nil)
    let animationCell = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    let animation = CABasicAnimation(keyPath: "bounds.origin.y")

//    var friends = [FriendModels]()
    
    private lazy var friends = try? Realm().objects(FriendModels.self) //.filter("city == %@", city).sorted(byKeyPath: "id")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkService.loadFrienddd { [weak self] friends in
//            self?.friends = friends
//            self?.filterContentForSearchText(searchText: "")
//        }
        
        networkService.loadFrienddd { friends in
            try? RealmProvider.save(items: friends)
        }

        filterContentForSearchText(searchText: "")
        searchBarSet()
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseId)
        tableView.dataSource = self
        
        addAnimation()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(doSomething), for: .valueChanged)
    
    }
    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World! refresh....")
//        networkService.loadFrienddd { [weak self] friends in
//            self?.friends = friends
//            self?.filterContentForSearchText(searchText: "")
//        }
        refreshControl.endRefreshing()
    }
    
    private func addAnimation() {
        //animation.beginTime = CACurrentMediaTime() + 0.5
        animationCell.fromValue = 0.0
        animationCell.toValue = 1
        animationCell.duration = 1.5
        
        animation.fromValue = -500
        animation.toValue = 0
        animation.duration = 1.0
        self.view.layer.add(animation, forKey: nil)
    }
    
    
    func filterContentForSearchText(searchText: String) {
        if (searchController.isActive && searchController.searchBar.text != "") {
            filteredArrays = (friends?.filter { friend in
                return (friend.name.lowercased().contains(searchText.lowercased()))
                })!
        }else {
            guard let friend = friends?.sorted(by: {$0.name < $1.name}) else { return }
            filteredArrays = friend //friends!.sorted(by: {$0.name < $1.name})
        }
        
            friendDictionary = [:]
            for friend in filteredArrays {
                let friendKey = String(friend.name.prefix(1))
                if var friendValues = friendDictionary[friendKey] {
                    friendValues.append(friend)
                    friendDictionary[friendKey] = friendValues
                } else {
                    friendDictionary[friendKey] = [friend]
                }
            }
            friendSectionTitle = [String](friendDictionary.keys)
            friendSectionTitle = friendSectionTitle.sorted(by: {$0 < $1})
        
            tableView.reloadData()
    }
    
    func searchBarSet() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 53.0/255.0, green: 155.0/255.0, blue: 220.0/255.0, alpha: 0.9)
        searchController.searchBar.placeholder = "Search friend"
        searchController.searchBar.layer.cornerRadius = 5
        searchController.searchBar.clipsToBounds = true
        
        let barButtonAppearanceInSearchBar: UIBarButtonItem?
        barButtonAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearanceInSearchBar?.image = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        barButtonAppearanceInSearchBar?.tintColor = UIColor.white
        barButtonAppearanceInSearchBar?.title = nil
    
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!)
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != "") {
              if section == 0 {
                let friendKey = friendSectionTitle[section]
                if let friendValues = friendDictionary[friendKey] {
                    return friendValues.count
                }
            }
        
        }else {
            let friendKey = friendSectionTitle[section]
            if let friendValues = friendDictionary[friendKey] {
                return friendValues.count
            }
        }
        
        let friendKey = friendSectionTitle[section]
        if let friendValues = friendDictionary[friendKey] {
            return friendValues.count
        }
        return 0
    }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }

        cell.layer.add(animationCell, forKey: nil)
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true

        if !(searchController.isActive && searchController.searchBar.text != "") {

            let friendKey = friendSectionTitle[indexPath.section]
            if let friendValues = friendDictionary[friendKey] {
                cell.configure(with: friendValues[indexPath.row])
                cell.nameLabel.layer.add(animationCell, forKey: nil)
                cell.friendImageView.layer.add(animationCell, forKey: nil)
            }
        } else {
            let friendKey = friendSectionTitle[indexPath.section]
            if let friendValues = friendDictionary[friendKey] {
                cell.configure(with: friendValues[indexPath.row])
                cell.friendImageView.layer.add(animationCell, forKey: nil)
            }
        }
        return cell
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSectionTitle.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSectionTitle
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: 53.0/255.0, green: 155.0/255.0, blue: 220.0/255.0, alpha: 0.9)
        headerView.layer.cornerRadius = 5
        headerView.clipsToBounds = true
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-30)

        let friendKey = friendSectionTitle[section]
        label.text = friendKey
        headerView.addSubview(label)

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ForcastSeque", sender: nil)
    }
    
    // MARK: - Navigation
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ForcastSeque",
        let forecastController = segue.destination as? FriendsCollectionViewController,
        let indexPath = tableView.indexPathForSelectedRow {
 
        let friendKey = friendSectionTitle[indexPath.section]
        
       
        if let friendValues = friendDictionary[friendKey] {
            forecastController.friendNameForTitle = friendValues[indexPath.row].name
            forecastController.friendNameForLabel = friendValues[indexPath.row].name
         //*   forecastController.friendNameForImage = friendValues[indexPath.row].image
            forecastController.likeCount = friendValues[indexPath.row].likeCount
            forecastController.friends = [friends?[indexPath.section]] as! [FriendModels]
        }
    }
 }
}
// MARK: - Extension

