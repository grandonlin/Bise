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
    @IBOutlet weak var test: UITextField!
    
    
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
//        self.setNoTextOnBackBarButton()
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
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
                    let owner = Owner(ownerName: username)
                    currentOwner = owner
                    let locationData = ["Username": username, "Location Information": ["Location Image URL": DEFAULT_LOCATION_IMAGE_URL]] as [String: Any]
                    KeychainWrapper.standard.set(currentOwner.ownerID, forKey: CURRENT_OWNER_ID)
                    self.completeSignIn(user: currentOwner, id: currentOwner.ownerID, userData: locationData)
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
            performSegue(withIdentifier: "OwnerInformationVC", sender: nil)
        } else {
            performSegue(withIdentifier: "ShopperSetupVC", sender: nil)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? OwnerInformationVC {
//            
//        }
//    }
    
    
    func passwordValidation(password: String) {
        if password.characters.count < 8 {
            sendAlertWithoutHandler(alertTitle: "Password Error", alertMessage: "Password must be at least 8 characters. Please re-enter.", actionTitle: ["OK"])
        }
    }
}




