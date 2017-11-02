//
//  FriendsViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// iOS 11에서의 Large Title 설정
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self,
                                                 action: #selector(self.loadFriends),
                                                 for: .valueChanged)
        
        self.tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        loadFriends()
    }
    
    // MARK: Custom Methods
    @objc func loadFriends() {
        let urlString = "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id"
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    return
                }
                DispatchQueue.main.async {
                    self.setFriends(json: json)
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }.resume()
    }
    
    func setFriends(json: [String: Any]) {
        
        guard let friendList = json["results"] as? [[String: Any]] else { return }
        print(friendList)
        
        friends = friendList.flatMap {
            if let name = $0["name"] as? [String: String],
                let title = name["title"],
                let firstName = name["first"],
                let lastName = name["last"],
                let email = $0["email"] as? String,
                let phone = $0["cell"] as? String,
                let picture = $0["picture"] as? [String: String],
                let thumbnailURL = picture["thumbnail"],
                let mediumURL = picture["medium"],
                let largeURL = picture["large"],
                let nation = $0["nat"]as? String {
                return Friend(title: title,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              phone: phone,
                              thumbnailURL: thumbnailURL,
                              mediumURL: mediumURL,
                              largeURL: largeURL,
                              nation: nation,
                              bookmark: false)
            }
            return nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailViewController
            detailVC.index = indexPath.row
        }
    }
}

// MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        let friend = friends[indexPath.row]
        
        cell.profileImageView.setImageFromUrlString(urlString: friend.thumbnailURL)
        cell.nameLabel.text = friend.title.firstUppercased + ". " +
                                friend.firstName.firstUppercased + " " +
                                friend.lastName.firstUppercased
        cell.emailLabel.text = friend.email
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FriendsToDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
