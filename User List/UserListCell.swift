//
//  UserListCell.swift
//  User List
//
//  Created by Nitin Yadav on 5/3/2021.
//

import UIKit

protocol CustomCellDelegate: class {
    func deletePressed(cell: UserListCell)
}

class UserListCell: UITableViewCell {
    var delegate: CustomCellDelegate?
    @IBOutlet var userName: UILabel!
    @IBOutlet var userInfo: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var deleteButton: UIButton!
    
    var user = User(firstName: "", lastName: "", userImage: nil)
    
    @IBAction func deleteUser(_ sender: UIButton) {
        delegate?.deletePressed(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
