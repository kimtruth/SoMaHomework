//
//  FriendsViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class FriendsViewController: UIViewController {
    
    var friends = [Friend]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// iOS 11에서의 Large Title 설정
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        loadFriends()
    }
    
    func loadFriends() {
        let url = "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                self.jsonToFriends(json: JSON(value))
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func jsonToFriends(json: JSON) {
        let friendList: Array<JSON> = json["results"].arrayValue
        
        self.friends = friendList.flatMap {
            if let title = $0["name"]["title"].string,
                let firstName = $0["name"]["first"].string,
                let lastName = $0["name"]["last"].string,
                let email = $0["email"].string,
                let phone = $0["cell"].string,
                let thumbnailURL = $0["picture"]["thumbnail"].string,
                let mediumURL = $0["picture"]["medium"].string,
                let largeURL = $0["picture"]["large"].string,
                let nation = $0["nat"].string {
                return Friend(title: title,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              phone: phone,
                              thumbnailURL: thumbnailURL,
                              mediumURL: mediumURL,
                              largeURL: largeURL,
                              nation: nation)
            }
            return nil
        }
        print(friendList)
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
        
        cell.profileImageView.image = UIImage()
        Alamofire.request(friend.thumbnailURL).responseData { response in
            switch response.result {
            case .success(let value):
                cell.profileImageView.image = UIImage(data: value)
            case .failure(let error):
                print(error)
            }
        }
        
        cell.nameLabel.text = friend.title.localizedUppercase + ". " + friend.firstName + friend.lastName
        cell.emailLabel.text = friend.email
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension FriendsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
