//
//  FriendsViewController.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
}
