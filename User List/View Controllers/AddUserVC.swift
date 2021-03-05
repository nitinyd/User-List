//
//  AddUserVC.swift
//  User List
//
//  Created by Nitin Yadav on 5/3/2021.
//

import UIKit

class AddUserVC: UITableViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var dob: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var hometown: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var telephoneNumber: UITextField!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var addImageButton: UIButton!
    
    var newUserImage: UIImage?
    
    @IBAction func addImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func addUser(_ sender: Any) {
        guard let firstName = firstName.text, let lastName = lastName.text, !firstName.isEmpty, !lastName.isEmpty
        else { return }
        UserListFeed.addNew(user: User(firstName: firstName, lastName: lastName, userImage: newUserImage))
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension AddUserVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        userImageView.image = selectedImage
        newUserImage = selectedImage
        dismiss(animated: true)
    }
}

extension AddUserVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == firstName { return lastName.becomeFirstResponder() }
    else if textField == lastName { return dob.becomeFirstResponder() }
    else if textField == dob { return gender.becomeFirstResponder() }
    else if textField == gender { return country.becomeFirstResponder() }
    else if textField == country { return state.becomeFirstResponder() }
    else if textField == state { return hometown.becomeFirstResponder() }
    else if textField == hometown { return phoneNumber.becomeFirstResponder() }
    else if textField == phoneNumber { return telephoneNumber.becomeFirstResponder() }
    else { return telephoneNumber.resignFirstResponder() }
  }
}

extension AddUserVC {
    func setupViews() {
        userImageView.layer.cornerRadius = 10
        addImageButton.layer.cornerRadius = 5
        self.tableView.backgroundColor = UIColor.white
    }
}
