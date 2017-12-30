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
    var mondayFromTime = ""
    var mondayToTime = ""
    var tuesdayFromTime = ""
    var tuesdayToTime = ""
    var wednesdayFromTime = ""
    var wednesdayToTime = ""
    var thursdayFromTime = ""
    var thursdayToTime = ""
    var fridayFromTime = ""
    var fridayToTime = ""
    var saturdayFromTime = ""
    var saturdayToTime = ""
    var sundayFromTime = ""
    var sundayToTime = ""
    let schedule = currentOwner.schedule
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operationHoursPickerView.dataSource = self
        operationHoursPickerView.delegate = self
        
        initialize()
        
    }
    
    func initialize() {
        mondayFromLbl.text = schedule.mondayFrom
        mondayToLbl.text = schedule.mondayTo
            
        tuesdayFromLbl.text = schedule.tuesdayFrom
        tuesdayToLbl.text = schedule.tuesdayTo
        
        wednesdayFromLbl.text = schedule.wednesdayFrom
        wednesdayToLbl.text = schedule.wednesdayTo
        
        thursdayFromLbl.text = schedule.thursdayFrom
        thursdayToLbl.text = schedule.thursdayTo
        
        fridayFromLbl.text = schedule.fridayFrom
        fridayToLbl.text = schedule.fridayTo
        
        saturdayFromLbl.text = schedule.saturdayFrom
        saturdayToLbl.text = schedule.saturdayTo
        
        sundayFromLbl.text = schedule.sundayFrom
        sundayToLbl.text = schedule.sundayTo
        
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
        
        fromTime = "\(fromHour):\(fromMinute) \(fromAmPm)"
        toTime = "\(toHour):\(toMinute) \(toAmPm)"
        
        switch weekDay {
        case "Monday":
            mondayFromLbl.text = fromTime
            mondayToLbl.text = toTime
            mondayFromTime = fromTime
            mondayToTime = toTime
            schedule.mondayFrom = mondayFromTime
            schedule.mondayTo = mondayToTime
            print("(OwnerScheduleVC): monday schedule is \(mondayFromTime) and \(mondayToTime)")
        case "Tuesday":
            tuesdayFromLbl.text = fromTime
            tuesdayToLbl.text = toTime
            tuesdayFromTime = fromTime
            tuesdayToTime = toTime
            schedule.tuesdayFrom = tuesdayFromTime
            schedule.tuesdayTo = tuesdayToTime
            print("(OwnerScheduleVC): tuesday schedule is \(tuesdayFromTime) and \(tuesdayToTime)")
        case "Wednesday":
            wednesdayFromLbl.text = fromTime
            wednesdayToLbl.text = toTime
            wednesdayFromTime = fromTime
            wednesdayToTime = toTime
            schedule.wednesdayFrom = wednesdayFromTime
            schedule.wednesdayTo = wednesdayToTime
            print("(OwnerScheduleVC): wednesday schedule is \(wednesdayFromTime) and \(wednesdayToTime)")
        case "Thursday":
            thursdayFromLbl.text = fromTime
            thursdayToLbl.text = toTime
            thursdayFromTime = fromTime
            thursdayToTime = toTime
            schedule.thursdayFrom = thursdayFromTime
            schedule.thursdayTo = thursdayToTime
            print("(OwnerScheduleVC): thursday schedule is \(thursdayFromTime) and \(thursdayToTime)")
        case "Friday":
            fridayFromLbl.text = fromTime
            fridayToLbl.text = toTime
            fridayFromTime = fromTime
            fridayToTime = toTime
            schedule.fridayFrom = fridayFromTime
            schedule.fridayTo = fridayToTime
            print("(OwnerScheduleVC): friday schedule is \(fridayFromTime) and \(fridayToTime)")
        case "Saturday":
            saturdayFromLbl.text = fromTime
            saturdayToLbl.text = toTime
            saturdayFromTime = fromTime
            saturdayToTime = toTime
            schedule.saturdayFrom = saturdayFromTime
            schedule.saturdayTo = saturdayToTime
            print("(OwnerScheduleVC): saturday schedule is \(saturdayFromTime) and \(saturdayToTime)")
        case "Sunday":
            sundayFromLbl.text = fromTime
            sundayToLbl.text = toTime
            sundayFromTime = fromTime
            sundayToTime = toTime
            schedule.sundayFrom = sundayFromTime
            schedule.sundayTo = sundayToTime
            print("(OwnerScheduleVC): sunday schedule is \(sundayFromTime) and \(sundayToTime)")
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
            mondayFromTime = "Closed"
            mondayToTime = ""
            schedule.mondayFrom = mondayFromTime
            schedule.mondayTo = mondayToTime
        case 2:
            tuesdayFromLbl.text = "Closed"
            tuesdayToLbl.text = ""
            tuesdayFromTime = "Closed"
            tuesdayToTime = ""
            schedule.tuesdayFrom = tuesdayFromTime
            schedule.tuesdayTo = tuesdayToTime
        case 3:
            wednesdayFromLbl.text = "Closed"
            wednesdayToLbl.text = ""
            wednesdayFromTime = "Closed"
            wednesdayToTime = ""
            schedule.mondayFrom = mondayFromTime
            schedule.mondayTo = mondayToTime
        case 4:
            thursdayFromLbl.text = "Closed"
            thursdayToLbl.text = ""
            thursdayFromTime = "Closed"
            thursdayToTime = ""
            schedule.thursdayFrom = thursdayFromTime
            schedule.thursdayTo = thursdayToTime
        case 5:
            fridayFromLbl.text = "Closed"
            fridayToLbl.text = ""
            fridayFromTime = "Closed"
            fridayToTime = ""
            schedule.fridayFrom = fridayFromTime
            schedule.fridayTo = fridayToTime
        case 6:
            saturdayFromLbl.text = "Closed"
            saturdayToLbl.text = ""
            saturdayFromTime = "Closed"
            saturdayToTime = ""
            schedule.saturdayFrom = saturdayFromTime
            schedule.saturdayTo = saturdayToTime
        case 7:
            sundayFromLbl.text = "Closed"
            sundayToLbl.text = ""
            sundayFromTime = "Closed"
            sundayToTime = ""
            schedule.sundayFrom = sundayFromTime
            schedule.sundayTo = sundayToTime
        default:
            break
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: UIBarButtonItem) {
        schedule.isUploaded = true
        
        let mondaySchedule: String!
        let tuesdaySchedule: String!
        let wednesdaySchedule: String!
        let thursdaySchedule: String!
        let fridaySchedule: String!
        let saturdaySchedule: String!
        let sundaySchedule: String!
        
        if mondayFromTime == "" && mondayToTime == "" {
            mondaySchedule = "Closed"
        } else if mondayToTime == "" {
            mondaySchedule = "\(mondayFromTime)"
        } else {
            mondaySchedule = "\(mondayFromTime)-\(mondayToTime)"
        }
        
        if tuesdayFromTime == "" && tuesdayToTime == "" {
            tuesdaySchedule = "Closed"
        } else if tuesdayToTime == "" {
            tuesdaySchedule = "\(tuesdayFromTime)"
        } else {
            tuesdaySchedule = "\(tuesdayFromTime)-\(tuesdayToTime)"
        }
        
        if wednesdayFromTime == "" && wednesdayToTime == "" {
            wednesdaySchedule = "Closed"
        } else if wednesdayToTime == "" {
            wednesdaySchedule = "\(wednesdayFromTime)"
        } else {
            wednesdaySchedule = "\(wednesdayFromTime)-\(wednesdayToTime)"
        }
        
        if thursdayFromTime == "" && thursdayToTime == "" {
            thursdaySchedule = "Closed"
        } else if thursdayToTime == "" {
            thursdaySchedule = "\(thursdayFromTime)"
        } else {
            thursdaySchedule = "\(thursdayFromTime)-\(thursdayToTime)"
        }
        
        if fridayFromTime == "" && fridayToTime == "" {
            fridaySchedule = "Closed"
        } else if fridayToTime == "" {
            fridaySchedule = "\(fridayFromTime)"
        } else {
            fridaySchedule = "\(fridayFromTime)-\(fridayToTime)"
        }
        
        if saturdayFromTime == "" && saturdayToTime == "" {
            saturdaySchedule = "Closed"
        } else if saturdayToTime == "" {
            saturdaySchedule = "\(saturdayFromTime)"
        } else {
            saturdaySchedule = "\(saturdayFromTime)-\(saturdayToTime)"
        }
        
        if sundayFromTime == "" && sundayToTime == "" {
            sundaySchedule = "Closed"
        } else if sundayToTime == "" {
            sundaySchedule = "\(sundayFromTime)"
        } else {
            sundaySchedule = "\(sundayFromTime)-\(sundayToTime)"
        }
        
        let weeklySchedule = ["Operation Hours": ["01Monday": mondaySchedule, "02Tuesday": tuesdaySchedule, "03Wednesday": wednesdaySchedule, "04Thursday": thursdaySchedule, "05Friday": fridaySchedule, "06Saturday": saturdaySchedule, "07Sunday": sundaySchedule]]
        DataService().OWNERS_CURRENT_REF.child("Location Information").updateChildValues(weeklySchedule)
        performSegue(withIdentifier: "OwnerServicesVC", sender: nil)
    }

    
}
