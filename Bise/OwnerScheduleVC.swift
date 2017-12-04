//
//  OwnerScheduleVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-02.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class OwnerScheduleVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var operationHoursPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operationHoursPickerView.dataSource = self
        operationHoursPickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }

    
    
}
