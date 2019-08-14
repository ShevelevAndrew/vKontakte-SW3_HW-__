//
//  SearchGroupViewController.swift
//  vKontakte
//
//  Created by Andrew on 19/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class SearchGroupViewController: UITableViewController  {

    var groupUser: [GroupModel] = [
        GroupModel(name: "Космос", image: UIImage(named: "group1")!),
        GroupModel(name: "Океан", image: UIImage(named: "group2")!),
        GroupModel(name: "Растения", image: UIImage(named: "group2")!),
        GroupModel(name: "Облака", image: UIImage(named: "group1")!),
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "UnwindToMyFriend" else { return }
        
        if let controller = segue.source as? SearchGroupViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow {
            let group = controller.groupUser[indexPath.row]
            
            guard !groupUser.contains(where: { $0.name == group.name }) else { return }
            
            groupUser.append(group)
            let newIndexPath = IndexPath(item: groupUser.count - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupUser.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroopCell.reuseIdentifier, for: indexPath) as?
//            GroopCell else { return UITableViewCell() }
//
//        cell.groopNameLabel.text = groupUser[indexPath.row].name
//        cell.groopImageView.image = groupUser[indexPath.row].image
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId, for: indexPath) as? CustomTableViewCell
            else { return UITableViewCell() }
        
        cell.nameLabel.text = groupUser[indexPath.row].name
        cell.friendImageView.image = groupUser[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UnwindToMyFriend", sender: nil)
    }
  
    // MARK: - Navigation

}

