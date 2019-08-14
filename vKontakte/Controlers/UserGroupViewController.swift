//
//  UserGroupViewController.swift
//  vKontakte
//
//  Created by Andrew on 19/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class UserGroupViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var groupDictionary = [String:[GroupModel]]()
    var groupSectionTitle = [String]()
    
    var filteredArrays = [GroupModel]()
    // var filteredArray = [String:[FriendsModel]]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var groupUser: [GroupModel] = [
        GroupModel(name: "Свистуны", image: UIImage(named: "group1")!),
        GroupModel(name: "Пивыны", image: UIImage(named: "group2")!),
        GroupModel(name: "Вязальщики", image: UIImage(named: "group2")!),
        GroupModel(name: "Рыболовы", image: UIImage(named: "group1")!),
        GroupModel(name: "Пивыны хором", image: UIImage(named: "group2")!),
        GroupModel(name: "Вязальщики спицами", image: UIImage(named: "group2")!),
        GroupModel(name: "Рыболовы в океане", image: UIImage(named: "group1")!),
        GroupModel(name: "Пивыны в одиночку", image: UIImage(named: "group2")!),
        GroupModel(name: "Вязальщики крючком", image: UIImage(named: "group2")!),
        GroupModel(name: "Рыболовы в реке", image: UIImage(named: "group1")!),
    ]
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterContentForSearchText(searchText: "")
        searchBarSet()
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseId)
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        refreshControl?.tintColor = UIColor.clear
        tableView.addSubview(refreshControl!)
        loadCustomRefreshContents()
        refreshControl?.addTarget(self, action: #selector(doSomething), for: .valueChanged)
    }
    
//    @objc func doSomething(refreshControl: UIRefreshControl) {
//        print("Hello World!")
//
//        // somewhere in your code you might need to call:
//        refreshControl.endRefreshing()
//    }

    func filterContentForSearchText(searchText: String) {
        if (searchController.isActive && searchController.searchBar.text != "") {
            filteredArrays = groupUser.filter { group in
                return (group.name.lowercased().contains(searchText.lowercased()))
            }
        }else {
            filteredArrays = groupUser.sorted(by: {$0.name < $1.name})
        }
        
        groupDictionary = [:]
        for group in filteredArrays {
            let groupKey = String(group.name.prefix(1))
            if var groupValues = groupDictionary[groupKey] {
                groupValues.append(group)
                groupDictionary[groupKey] = groupValues
            } else {
                groupDictionary[groupKey] = [group]
            }
        }
        groupSectionTitle = [String](groupDictionary.keys)
        groupSectionTitle = groupSectionTitle.sorted(by: {$0 < $1})
        
        tableView.reloadData()
    }
    
    func searchBarSet() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 53.0/255.0, green: 155.0/255.0, blue: 220.0/255.0, alpha: 0.9)
        searchController.searchBar.placeholder = "Search group"
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
       // return groupUser.count
        
        if (searchController.isActive && searchController.searchBar.text != "") {
            if section == 0 {
                let groupKey = groupSectionTitle[section]
                if let groupValues = groupDictionary[groupKey] {
                    return groupValues.count
                }
            }
            
        }else {
            let groupKey = groupSectionTitle[section]
            if let groupValues = groupDictionary[groupKey] {
                return groupValues.count
            }
        }
        
        let groupKey = groupSectionTitle[section]
        if let groupValues = groupDictionary[groupKey] {
            return groupValues.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroopCell.reuseIdentifier, for: indexPath) as?
//            GroopCell else { return UITableViewCell() }
//
//        cell.groopNameLabel.text = groupUser[indexPath.row].name
//        cell.groopImageView.image = groupUser[indexPath.row].image
//
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        if !(searchController.isActive && searchController.searchBar.text != "") {
            
            let groupKey = groupSectionTitle[indexPath.section]
            if let groupValues = groupDictionary[groupKey] {
                cell.nameLabel.text = groupValues[indexPath.row].name
                cell.friendImageView.image = groupValues[indexPath.row].image
            }
        } else {
            let friendKey = groupSectionTitle[indexPath.section]
            if let groupValues = groupDictionary[friendKey] {
                cell.nameLabel.text = groupValues[indexPath.row].name
                cell.friendImageView.image = groupValues[indexPath.row].image
            }
        }
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSectionTitle.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupSectionTitle
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupSectionTitle[section]
    }
    
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupUser.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: 53.0/255.0, green: 155.0/255.0, blue: 220.0/255.0, alpha: 0.9)
        headerView.layer.cornerRadius = 5
        headerView.clipsToBounds = true
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-30)
        
        let groupKey = groupSectionTitle[section]
        label.text = groupKey
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

    // MARK: - Navigation

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let controller = segue.source as? SearchGroupViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow{
            let group = controller.groupUser[indexPath.row]
            
            guard !groupUser.contains(where: { $0.name == group.name } ) else { return }
            
            groupUser.append(group)
            filterContentForSearchText(searchText: searchController.searchBar.text!)
           // let newIndexPath = IndexPath(item: groupUser.count - 1, section:  0)
          //  tableView.insertRows(at: [newIndexPath], with: .none)
        }
    }
    
    // MARK: Custom function implementation
    // https://www.appcoda.com/custom-pull-to-refresh/
   override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if refreshControl!.isRefreshing {
            if !isAnimating {
                doSomething()
                animateRefreshStep1()
            }
        }
    }
    
    
    func loadCustomRefreshContents() {
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents![0] as? UIView
        customView.frame = refreshControl!.bounds
        
        for i in 0..<customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl?.addSubview(customView)
    }
    
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi/4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
        }, completion: { (finished) -> Void in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform.identity
                self.labelsArray[self.currentLabelIndex].textColor = UIColor.black
                
            }, completion: { (finished) -> Void in
                self.currentLabelIndex += 1
                
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                }
                else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.labelsArray[0].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[1].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[2].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[3].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[4].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[5].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.labelsArray[6].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                self.labelsArray[0].transform = CGAffineTransform.identity
                self.labelsArray[1].transform = CGAffineTransform.identity
                self.labelsArray[2].transform = CGAffineTransform.identity
                self.labelsArray[3].transform = CGAffineTransform.identity
                self.labelsArray[4].transform = CGAffineTransform.identity
                self.labelsArray[5].transform = CGAffineTransform.identity
                self.labelsArray[6].transform = CGAffineTransform.identity
                
            }, completion: { (finished) -> Void in
                if self.refreshControl!.isRefreshing {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                }
                else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    for i in 0..<self.labelsArray.count {
                        self.labelsArray[i].textColor = UIColor.black
                        self.labelsArray[i].transform = CGAffineTransform.identity
                    }
                }
            })
        })
    }
    
    
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magenta, UIColor.brown, UIColor.yellow, UIColor.red, UIColor.green, UIColor.blue, UIColor.orange]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
    
    
   @objc func doSomething() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(endOfWork),
                                     userInfo: nil,
                                     repeats: true)
        }
    }
    
    
    @objc func endOfWork() {
        refreshControl!.endRefreshing()
        
        //timer?.invalidate()
        //timer = nil
    }

}
