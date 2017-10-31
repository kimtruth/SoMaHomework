//
//  Friend.swift
//  SoMaHomework
//
//  Created by Truth on 2017. 10. 29..
//  Copyright © 2017년 k1mtruth. All rights reserved.
//

import Foundation

struct Friend: Codable{
    var title: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var thumbnailURL: String
    var mediumURL: String
    var largeURL: String
    var nation: String
    var bookmark: Bool
    
    // Type Method - throwing method
    static func friendDataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let friendURL: URL
        
        documentURL = try fileManager.url(for: .documentDirectory,
                                          in: .userDomainMask,
                                          appropriateFor: nil,
                                          create: false)
        friendURL = documentURL.appendingPathComponent("friend.plsit")
        return friendURL
    }
}
