//
//  NewUserVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-22.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class NewUserVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var ownerShopperSwitch: UISwitch!
    
//    var userName: String!
//    var password: String!
//    var email: String!
    var usernameExisted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        DataService().OWNERS_REF.removeAllObservers()
        DataService().SHOPPERS_REF.removeAllObservers()
    }

    func initialize() {
        let allTextFields = [userNameTextField, emailTextField, passwordTextField]
        configureTextField(textFields: allTextFields as! [UITextField])
        signUpBtn.heightCircleView()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNoTextOnBackBarButton()
    }
    
    func configureTextField(textFields: [UITextField]) {
        for i in 0..<textFields.count {
            textFields[i].heightCircleView()
            textFields[i].layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
            assignImageToTextField(imageName: i, textField: textFields[i])
        }
    }
    
    func assignImageToTextField(imageName: Int, textField: UITextField) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: UIImage().getImageName(name: imageName))
        textField.leftView = imageView
        textField.leftViewMode = .always
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        guard let userName = userNameTextField.text, userName != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Username", alertMessage: "Please enter your username", actionTitle: ["Cancel"])
            return
        }
        
        guard let email = emailTextField.text, email != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Email Address", alertMessage: "Please enter your email address", actionTitle: ["Cancel"])
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Password", alertMessage: "Please enter your password", actionTitle: ["Cancel"])
            return
        }
        
        passwordValidation(password: password)
        usernameExisted = false
        print("Grandon: the userName is \(userName)")
        print("Grandon: currently the usernameExisted is \(usernameExisted)")
//        checkExistingUsername(username: userName)
        if !ownerShopperSwitch.isOn {
            DataService().OWNERS_REF.observeSingleEvent(of: .value, with: { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    self.usernameExisted = self.checkExistingUser(snapshot: snapshot, userName: userName)
                    if self.usernameExisted == true {
                        self.sendAlertWithoutHandler(alertTitle: "Username Exists", alertMessage: "This username has been occupied, please use another.", actionTitle: ["Cancel"])
                        self.usernameExisted = false
                        print("Grandon: the usernameExisted after cancel is \(self.usernameExisted)")
                    } else {
                        self.createKeychains(username: userName, email: email, password: password)
                        //activityIndicator.startAnimating()
                        self.createFirebaseUser(category: OWNER, username: userName, email: email, password: password)
                    }
                }
            })
        } else {
            DataService().SHOPPERS_REF.observeSingleEvent(of: .value, with: { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    self.usernameExisted = self.checkExistingUser(snapshot: snapshot, userName: userName)
                    if self.usernameExisted == true {
                        self.sendAlertWithoutHandler(alertTitle: "Username Exists", alertMessage: "This username has been occupied, please use another.", actionTitle: ["Cancel"])
                        self.usernameExisted = false
                    } else {
                        self.createKeychains(username: userName, email: email, password: password)
                        //activityIndicator.startAnimating()
                        self.createFirebaseUser(category: SHOPPER, username: userName, email: email, password: password)
                    }
                }
            })
        }
        
        
    }
    
    func checkExistingUser(snapshot: [DataSnapshot], userName: String) -> Bool {
        var exist = false
        for snap in snapshot {
            if let userSnap = snap.value as? Dictionary<String, Any> {
                if let name = userSnap["Username"] as? String {
                    print("Grandon: username is \(name)")
                    if name == userName {
                        exist = true
                        print("Grandon: is it true? \(exist)")
                        break
                    }
                }
            }
        }
        return exist
    }
    
    func createKeychains(username: String, email: String, password: String) {
        KeychainWrapper.standard.set(username, forKey: CURRENT_USERNAME)
        currentUsername = KeychainWrapper.standard.string(forKey: CURRENT_USERNAME)
        KeychainWrapper.standard.set(email, forKey: CURRENT_EMAIL)
        currentEmail = KeychainWrapper.standard.string(forKey: CURRENT_EMAIL)
        KeychainWrapper.standard.set(password, forKey: CURRENT_PASSWORD)
        currentPassword = KeychainWrapper.standard.string(forKey: CURRENT_PASSWORD)
    }

    func createFirebaseUser(category: String, username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: ["Cancel"])
            } else {
                print("Grandon: successfully create a new user")
                if category == OWNER {
                    let owner = Owner(ownerName: username, email: email)
                    let locationData = ["Username": username, "Store Information": ["Email": email, "Store Image URL": DEFAULT_LOCATION_IMAGE_URL]] as [String: Any]
                    self.completeSignIn(user: owner, id: owner.ownerID, userData: locationData)
                } else {
                    let shopper = Shopper(shopperName: username, email: email)
                    let shopperData = ["Username": username, "Email": email] as Dictionary<String, String>
                    self.completeSignIn(user: shopper, id: shopper.shopperID, userData: shopperData)
                }
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        print("Grandon: sent email verification")
                    } else {
                        self.sendAlertWithoutHandler(alertTitle: "Not able to send email verification", alertMessage: (error?.localizedDescription)!, actionTitle: ["Cancel"])
                    }
                })
            }
        })
    }
    
    func completeSignIn(user: User, id: String, userData: Dictionary<String, Any>) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        DataService().createFirebaseDBUser(user: user, id: id, userData: userData)
        //        loadingView.hide()
//        activityIndicator.stopAnimating()
        if user.category == OWNER {
            performSegue(withIdentifier: "OwnerSetupVC", sender: nil)
        } else {
            performSegue(withIdentifier: "ShopperSetupVC", sender: nil)
        }
    }
    
//    func checkExistingUsername(username: String) {
//    }
    
    func passwordValidation(password: String) {
        if password.characters.count < 8 {
            sendAlertWithoutHandler(alertTitle: "Password Error", alertMessage: "Password must be at least 8 characters. Please re-enter.", actionTitle: ["OK"])
        }
    }
}




