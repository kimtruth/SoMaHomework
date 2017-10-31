//
//  DetailViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

import Alamofire

class DetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var friendIndex: Int!

    // MARK: - Methods
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friend = friends[friendIndex]
        
        self.title = friend.title.firstUppercased + ". " + friend.lastName.firstUppercased
        self.nameLabel.text = friend.title.firstUppercased + ". " +
                              friend.firstName.firstUppercased + " " +
                              friend.lastName.firstUppercased
        self.detailLabel.text = friend.email + "\n" +
                                friend.phone + "\n" +
                                friend.nation 
        self.profileImageView.setImageFromUrlString(url: friend.mediumURL)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewController
        webVC.nation = friends[friendIndex].nation
    }
}
