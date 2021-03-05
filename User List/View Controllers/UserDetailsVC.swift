//
//  UserDetailsVC.swift
//  User List
//
//  Created by Nitin Yadav on 5/3/2021.
//

import UIKit

class UserDetailsVC: UIViewController {
    let user: User
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userAge: UILabel!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var userPhoneNumber: UILabel!
    @IBOutlet var userTelephoneNumber: UILabel!
    
    @IBOutlet var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.layer.cornerRadius = 5
        userName.text =  "Name: " + user.firstName + " " + user.lastName
        userAge.text = "Age: " + user.age
        userAddress.text = "Address: " + user.hometown + ", " + user.state + ", " + user.country
        userPhoneNumber.text = "Phone No.: " + user.phoneNumber
        userTelephoneNumber.text = "Telephone No.: " + user.telephoneNumber
        userImageView.image = user.userImage ?? UIImage(named: "person")
    }
    
    required init?(coder: NSCoder) { fatalError("Oops! Something went wrong!") }
    
    init?(coder: NSCoder, user: User) {
        self.user = user
        super.init(coder: coder)
    }
}
