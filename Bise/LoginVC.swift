//
//  LoginVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
    }

    func initialize() {
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        signInBtn.heightCircleView()
        
    }

}

