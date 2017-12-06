//
//  OwnerScheduleVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-02.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class OwnerScheduleVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var operationHoursPickerView: UIPickerView!
    @IBOutlet weak var mondayFromLbl: UILabel!
    @IBOutlet weak var mondayToLbl: UILabel!
    @IBOutlet weak var tuesdayFromLbl: UILabel!
    @IBOutlet weak var tuesdayToLbl: UILabel!
    @IBOutlet weak var wednesdayFromLbl: UILabel!
    @IBOutlet weak var wednesdayToLbl: UILabel!
    @IBOutlet weak var thursdayFromLbl: UILabel!
    @IBOutlet weak var thursdayToLbl: UILabel!
    @IBOutlet weak var fridayFromLbl: UILabel!
    @IBOutlet weak var fridayToLbl: UILabel!
    @IBOutlet weak var saturdayFromLbl: UILabel!
    @IBOutlet weak var saturdayToLbl: UILabel!
    @IBOutlet weak var sundayFromLbl: UILabel!
    @IBOutlet weak var sundayToLbl: UILabel!
    

    var currentSelectedDayPicker: Int!
    var weekDay = "Monday"
    var fromHour = "1"
    var fromMinute = "00"
    var fromAmPm = "AM"
    var toHour = "1"
    var toMinute = "00"
    var toAmPm = "AM"
    var fromTime = ""
    var toTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operationHoursPickerView.dataSource = self
        operationHoursPickerView.delegate = self
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.setLeftBarButton(backButton, animated: false)
        self.setNoTextOnBackBarButton()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 || component == 4 {
            return hourArr.count
        } else if component == 2 || component == 5 {
            return minuteArr.count
        } else if component == 3 || component == 6{
            return amPmArr.count
        } else {
            return weekArr.count
        }
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 1 || component == 4 {
//            return hourArr[row]
//        } else if component == 2 || component == 5 {
//            return minuteArr[row]
//        } else if component == 3 || component == 6 {
//            return amPmArr[row]
//        } else {
//            return weekArr[row]
//        }
//    }

//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 50
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        if component == 1 || component == 4 {
            label.text = hourArr[row]
        } else if component == 2 || component == 5 {
            label.text = minuteArr[row]
        } else if component == 3 || component == 6 {
            label.text = amPmArr[row]
        } else {
            label.text = weekArr[row]
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        if component == 0 {
            weekDay = weekArr[row]
        }
        if component == 1 {
            fromHour = hourArr[row]
        }
        if component == 2 {
            fromMinute = minuteArr[row]
        }
        if component == 3 {
            fromAmPm = amPmArr[row]
        }
        if component == 4 {
            toHour = hourArr[row]
        }
        if component == 5 {
            toMinute = minuteArr[row]
        }
        if component == 6 {
            toAmPm = amPmArr[row]
        }
        
        fromTime = "\(fromHour) : \(fromMinute) \(fromAmPm)"
        toTime = "\(toHour) : \(toMinute) \(toAmPm)"
        
        switch weekDay {
        case "Monday":
            mondayFromLbl.text = fromTime
            mondayToLbl.text = toTime
        case "Tuesday":
            tuesdayFromLbl.text = fromTime
            tuesdayToLbl.text = toTime
        case "Wednesday":
            wednesdayFromLbl.text = fromTime
            wednesdayToLbl.text = toTime
        case "Thursday":
            thursdayFromLbl.text = fromTime
            thursdayToLbl.text = toTime
        case "Friday":
            fridayFromLbl.text = fromTime
            fridayToLbl.text = toTime
        case "Saturday":
            saturdayFromLbl.text = fromTime
            saturdayToLbl.text = toTime
        case "Sunday":
            sundayFromLbl.text = fromTime
            sundayToLbl.text = toTime
        default:
            break
        }

    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        let index = sender.tag
        switch index {
        case 1:
            mondayFromLbl.text = "Closed"
            mondayToLbl.text = ""
        case 2:
            tuesdayFromLbl.text = "Closed"
            tuesdayToLbl.text = ""
        case 3:
            wednesdayFromLbl.text = "Closed"
            wednesdayToLbl.text = ""
        case 4:
            thursdayFromLbl.text = "Closed"
            thursdayToLbl.text = ""
        case 5:
            fridayFromLbl.text = "Closed"
            fridayToLbl.text = ""
        case 6:
            saturdayFromLbl.text = "Closed"
            saturdayToLbl.text = ""
        case 7:
            sundayFromLbl.text = "Closed"
            sundayToLbl.text = ""
        default:
            break
        }
    }
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let remove = KeychainWrapper.standard.removeObject(forKey: OWNER_COUNT)
//            print("Grandon: \(remove)")
//            performSegue(withIdentifier: "LoginVC", sender: nil)
        } catch let err as NSError {
            print(err.debugDescription)
        }

        
    }
    
}
