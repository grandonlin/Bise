//
//  StoreSetupVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-27.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class OwnerSetupVC: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var streetNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "OwnerScheduleVC", sender: nil)
    }
    
    func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        streetNumberTextField.inputView = pickerView
    }
}
