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
    
    @IBAction func showAddUser(_ sender: Any) {
        let parentVC = self.parent as! CustomPageVC
        parentVC.setViewControllers([parentVC.orderedVCs.last!], direction: .forward, animated: true, completion: nil)
    }
    
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
        cell.userName.text = user.firstName + " " + user.lastName
        cell.userInfo.text = user.gender + " | " + user.age + " | " + user.state
        cell.userImage.image = user.userImage ?? UIImage(named: "person")
        cell.userImage.layer.cornerRadius = 25
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
