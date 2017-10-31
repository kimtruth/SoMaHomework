//
//  BestFriendsViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

class BestFriendsViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        
        self.tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadBestFriends()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailViewController
            detailVC.index = indexPath.row
            detailVC.showBestFriends = true
        }
    }
}

// MARK: - UITableViewDataSource

extension BestFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        let friend = bestFriends[indexPath.row]
        
        cell.profileImageView.setImageFromUrlString(url: friend.thumbnailURL)
        cell.nameLabel.text = friend.title.firstUppercased + ". " +
            friend.firstName.firstUppercased + " " +
            friend.lastName.firstUppercased
        cell.emailLabel.text = friend.email
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension BestFriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "BestFriendsToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
