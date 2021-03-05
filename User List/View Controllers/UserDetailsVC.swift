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
    @IBOutlet var userInfo: UILabel!
    @IBOutlet var userImageView: UIImageView!
    
    @IBAction func updateUserImage() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = user.firstName + user.lastName
        userInfo.text = "BlaBlaBla"
        userImageView.image = user.userImage
    }
    
    required init?(coder: NSCoder) { fatalError("Oops! Something went wrong!") }
    
    init?(coder: NSCoder, user: User) {
        self.user = user
        super.init(coder: coder)
    }
}

//extension UserDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.editedImage] as? UIImage else { return }
//        userImageView.image = selectedImage
//        UserListFeed.saveImage(selectedImage, forUser: user)
//        dismiss(animated: true)
//    }
//}
