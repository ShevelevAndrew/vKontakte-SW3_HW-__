//
//  NewsViewController.swift
//  vKontakte
//
//  Created by Andrew on 10/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {

    var newsUser: [NewsModel] = [
        NewsModel(userid: 0, textStr: "text text next", image: UIImage(named: "news1")!, likeCount: 12),
        NewsModel(userid: 1, textStr: "ext text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next text text next ", image: UIImage(named: "news3")!, likeCount: 18),
        NewsModel(userid: 2, textStr: "text text next text text next", image: UIImage(named: "news2")!, likeCount: 18)
    ]
    
    var friends: [FriendsModel] = [
        FriendsModel(name: "Василий", image: UIImage(named: "user1")!, likeCount: "1"),
        FriendsModel(name: "Александр", image: UIImage(named: "user1")!, likeCount: "12"),
        FriendsModel(name: "Андрей", image: UIImage(named: "user3")!, likeCount: "10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomNewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.reuseId)
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsUser.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as?
//            NewsCell else { return UITableViewCell() }
          guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        cell.imageFriends.image = friends[newsUser[indexPath.row].userid].image //groupUser[indexPath.row].image
        cell.NameLabel.text = friends[newsUser[indexPath.row].userid].name //groupUser[indexPath.row].name
        cell.newsText.text = newsUser[indexPath.row].textStr
        
        
//        cell.imageNews.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        cell.imageNews.autoresizingMask = [.flexibleBottomMargin,.flexibleHeight , .flexibleRightMargin , .flexibleLeftMargin , .flexibleTopMargin , .flexibleWidth]
        cell.imageNews.contentMode = .scaleAspectFill //.scaleAspectFit // OR 
//        cell.imageNews.clipsToBounds = true

        cell.imageNews.image = newsUser[indexPath.row].image
        
        return cell
    }
    
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            groupUser.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        if let controller = segue.source as? SearchGroupViewController,
//            let indexPath = controller.tableView.indexPathForSelectedRow{
//            let group = controller.groupUser[indexPath.row]
//
//            guard !groupUser.contains(where: { $0.name == group.name } ) else { return }
//
//            groupUser.append(group)
//            let newIndexPath = IndexPath(item: groupUser.count - 1, section:  0)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        }
//    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }*/
    

}
