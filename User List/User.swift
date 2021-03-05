//
//  User.swift
//  User List
//
//  Created by Nitin Yadav on 4/3/2021.
//

import UIKit

struct User: Hashable {
    let firstName: String
    let lastName: String
    var userImage: UIImage? 
//        UserListFeed.loadImage(forUser: self) ?? nil
//    }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
    }
}
