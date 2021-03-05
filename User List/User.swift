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
    let age: String
    let gender: String
    let country: String
    let state: String
    let hometown: String
    let phoneNumber: String
    let telephoneNumber: String
    var userImage: UIImage?
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case age
        case gender
        case country
        case state
        case hometown
        case phoneNumber
        case telephoneNumber
    }
}
