//
//  DetailViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    var index: Int!
    var friend: Friend!
    var showBestFriends = false
    
    // MARK: - Methods
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showBestFriends {
            self.friend = bestFriends[index]
        } else {
            self.friend = friends[index]
        }
        
        self.title = friend.title.firstUppercased + ". " + friend.lastName.firstUppercased
        self.nameLabel.text = friend.title.firstUppercased + ". " +
            friend.firstName.firstUppercased + " " +
            friend.lastName.firstUppercased
        self.detailLabel.text = friend.email + "\n" +
            friend.phone + "\n" +
            friend.nation
        self.profileImageView.setImageFromUrlString(urlString: friend.mediumURL)
        
        setBarbuttonItem()
    }
    
    // MARK: Custom Methods
    func setBarbuttonItem() {
        if friend.bookmark {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(editBookmark))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                     target: self,
                                                                     action: #selector(editBookmark))
        }
    }
    
    @objc func editBookmark() {
        if friend.bookmark {
            if let index = bestFriends.index(where: {$0.email == friend.email}) {
                bestFriends.remove(at: index)
            }
        }
        friend.bookmark = !friend.bookmark
        friends[index] = friend
        setBarbuttonItem()
        saveBestFriends()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewController
        webVC.nation = friends[index].nation
    }
}

