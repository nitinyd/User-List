//
//  AddUserVC.swift
//  User List
//
//  Created by Nitin Yadav on 5/3/2021.
//

import UIKit

class AddUserVC: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var hometown: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var telephoneNumber: UITextField!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    var newUserImage: UIImage?
    
    @IBAction func refreshFields(_ sender: Any) {
        refreshAllFields()
    }
    
    @IBAction func showUserList(_ sender: Any) {
        let parentVC = self.parent as! CustomPageVC
        parentVC.setViewControllers([parentVC.orderedVCs.first!], direction: .reverse, animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func addUser(_ sender: Any) {
        guard let firstName = firstName.text,
              let lastName = lastName.text,
              let age = age.text,
              let gender = gender.text,
              let country = country.text,
              let state = state.text,
              let hometown = hometown.text,
              let phoneNumber = phoneNumber.text,
              let telephoneNumber = telephoneNumber.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !age.isEmpty,
              !gender.isEmpty,
              !country.isEmpty,
              !state.isEmpty,
              !hometown.isEmpty
        else {
            let alert = UIAlertController(title: "Alert", message: "Please enter all Fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let phoneNumberStatus = isValidNumber(number: phoneNumber)
        let telephoneNumberStatus = isValidNumber(number: telephoneNumber)
        
        if Int(age) == nil {
            let alert = UIAlertController(title: "Alert", message: "Please enter a valid age", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        switch phoneNumberStatus {
            case .repeated:
                let alert = UIAlertController(title: "Alert", message: "This phone number is Already used!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
                return
            case .notANumber:
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid phone Number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
                return
            case .valid:
                print("Valid Phone Number")
        }
        
        switch telephoneNumberStatus {
            case .repeated:
                let alert = UIAlertController(title: "Alert", message: "This telephone number is Already used!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
                return
            case .notANumber:
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid telephone Number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
                return
            case .valid:
                print("Valid Telephone Number")
        }
        
        UserListFeed.addNew(user: User(firstName: firstName, lastName: lastName, age: age, gender: gender, country: country, state: state, hometown: hometown, phoneNumber: phoneNumber, telephoneNumber: telephoneNumber, userImage: newUserImage))
        
        refreshAllFields()
        let parentVC = self.parent as! CustomPageVC
        parentVC.setViewControllers([parentVC.orderedVCs.first!], direction: .reverse, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
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
    else if textField == lastName { return age.becomeFirstResponder() }
    else if textField == age { return gender.becomeFirstResponder() }
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
    }
    
    func isValidNumber(number: String) -> NumberError {
        if isRepeatedNumber(number: number) { return .repeated }
        else if Int(number) == nil { return .notANumber }
        else { return .valid }
    }
    
    func isRepeatedNumber(number: String) -> Bool {
        for user in UserListFeed.users {
            if number == user.phoneNumber {
                return true
            }
        }
        return false
    }
    
    enum NumberError {
        case repeated, notANumber, valid
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func refreshAllFields() {
        self.firstName.text = ""
        self.lastName.text = ""
        self.age.text = ""
        self.gender.text = ""
        self.country.text = ""
        self.state.text = ""
        self.hometown.text = ""
        self.phoneNumber.text = ""
        self.telephoneNumber.text = ""
        self.userImageView.image = UIImage(named: "person")
    }
}
