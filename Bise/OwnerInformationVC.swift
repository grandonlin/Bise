//
//  OwnerInformationVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-27.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class OwnerInformationVC: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var streetNumberTextField: UITextField!
    @IBOutlet weak var streetNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provinceStateTextField: UITextField!
    @IBOutlet weak var postalZipCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true

    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        guard let locationName = locationNameTextField.text, locationName != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the name of your location", actionTitle: ["Cancel"])
            return
        }
        
        
        
        
        performSegue(withIdentifier: "OwnerScheduleVC", sender: nil)
    }
    
    func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        streetNumberTextField.inputView = pickerView
    }
    
    @IBAction func provinceStateTextFieldSelected(_ sender: Any) {
    }
    
}
