//
//  Global.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import Foundation

// Global Variables
var friends = [Friend]()
var bestFriends: [Friend] = []


// Global Function
func loadBestFriends() {
    do {
        let friendData = try Data(contentsOf: Friend.friendDataURL())
        let decoder = PropertyListDecoder()
        let bestFriend: [Friend]?
        
        bestFriend = try? decoder.decode([Friend].self, from: friendData)
        bestFriends = bestFriend ?? []
    } catch {
        print(error.localizedDescription)
    }
}

func saveBestFriends() {
    let encoder = PropertyListEncoder()
    
    do {
        let best = friends.filter { $0.bookmark == true }
        let data = try encoder.encode(best)
        try data.write(to: Friend.friendDataURL())
    } catch {
        print(error.localizedDescription)
    }
}
