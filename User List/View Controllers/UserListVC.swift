//
//  ViewController.swift
//  User List
//
//  Created by Nitin Yadav on 4/3/2021.
//

import UIKit

class UserListVC: UIViewController {

    @IBSegueAction func showUserDetails(_ coder: NSCoder) -> UserDetailsVC? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Oops something went wrong!")
        }
        let user = UserListFeed.users[indexPath.row]
        return UserDetailsVC(coder: coder, user: user)
    }
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserListFeed.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserListCell.self)", for: indexPath) as? UserListCell
        else { fatalError("Could not load cell!") }
        let user = UserListFeed.users[indexPath.row]
        cell.userName.text = user.firstName + user.lastName
        cell.userInfo.text = "BlaBlaBla"
        cell.userImage.image = user.userImage
        cell.userImage.layer.cornerRadius = 25
        cell.delegate = self
        cell.user = user
        return cell
    }
}

extension UserListVC: CustomCellDelegate {
    func deletePressed(cell: UserListCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        let user = UserListFeed.users[index]
        UserListFeed.delete(user: user)
        tableView.reloadData()
    }
}
