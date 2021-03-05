//
//  UserListFeed.swift
//  User List
//
//  Created by Nitin Yadav on 5/3/2021.
//

import UIKit

struct UserListFeed {
    static let starterUsers: [User] = []
    
    static var users: [User] = loadUsers()
    
    private static let usersJSONURL = URL(fileURLWithPath: "Users",
                                  relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    
    private static func loadUsers() -> [User] {
        let decoder = JSONDecoder()

        guard let usersData = try? Data(contentsOf: usersJSONURL) else {
          return starterUsers
        }

        do {
          let users = try decoder.decode([User].self, from: usersData)
          return users.map { userList in
            User(firstName: userList.firstName, lastName: userList.lastName, userImage: loadImage(forUser: userList))
          }
          
        } catch let error {
          print(error)
          return starterUsers
        }
    }
    
    private static func saveAllUsers() {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted

      do {
        let usersData = try encoder.encode(users)
        try usersData.write(to: usersJSONURL, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
    
    static func addNew(user: User) {
        if let image = user.userImage { saveImage(image, forUser: user) }
      users.insert(user, at: 0)
      saveAllUsers()
    }
    
    static func delete(user: User) {
      guard let userIndex = users.firstIndex(where: { storedUser in
        user == storedUser } )
        else { return }
    
      users.remove(at: userIndex)
      
      let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(user.firstName)
      do {
        try FileManager().removeItem(at: imageURL)
      } catch let error { print(error) }
      
      saveAllUsers()
    }
    
    static func saveImage(_ image: UIImage, forUser user: User) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(user.firstName + user.lastName)
      if let jpgData = image.jpegData(compressionQuality: 0.5) {
        try? jpgData.write(to: imageURL, options: .atomicWrite)
      }
    }

    static func loadImage(forUser user: User) -> UIImage? {
      let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(user.firstName + user.lastName)
      return UIImage(contentsOfFile: imageURL.path)
    }
}

extension FileManager {
    static var documentDirectoryURL: URL {
      return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
