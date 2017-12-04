//
//  Global.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

let KEY_UID = "key uid"
let USER_COUNT = "user count"
let OWNER = "OWNER"
let OWNER_COUNT = "owner count"
let SHOPPER = "SHOPPER"
let SHOPPER_COUNT = "shopper count"
let CURRENT_USERNAME = "current username"
let CURRENT_EMAIL = "current email"
let CURRENT_PASSWORD = "current password"
let DEFAULT_LOCATION_IMAGE_URL = "https://firebasestorage.googleapis.com/v0/b/bise-5884a.appspot.com/o/emptyImage.png?alt=media&token=b0595586-af18-4b6c-98cf-594f4487f66c"
let HANDLE = UInt(0)
let timeArr = ["12AM","0:30AM","1AM","1:30AM","2AM","2:30AM","3AM","3:30AM","4AM","4:30AM","5AM","5:30AM","6AM","6:30AM","7AM","7:30AM","8AM","8:30AM","9AM","9:30AM","10AM","10:30AM","11AM","11:30AM","12PM","12:30PM","1PM","1:30PM","2PM","2:30PM","3PM","3:30PM","4PM","4:30PM","5PM","5:30PM","6PM","6:30PM","7PM","7:30PM","8PM","3:30AM","9PM","3:30AM","10PM","3:30AM","11PM","3:30AM",]

var currentUsername: String!
var currentEmail: String!
var currentPassword: String!

extension UIView {
    func widthCircleView() {
        layer.cornerRadius = self.frame.width / 2.0
        clipsToBounds = true
    }
    
    func heightCircleView() {
        layer.cornerRadius = self.frame.height / 2.0
        clipsToBounds = true
    }
    

}

extension UIViewController {
    func sendAlertWithoutHandler(alertTitle: String, alertMessage: String, actionTitle: [String]) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        for action in actionTitle {
            alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    private var viewInfo: String {
        return "\(classForCoder), frame: \(frame))"
    }
    
    private func subviews(parentView: UIView, level: Int = 0, printSubviews: Bool = false) -> [UIView] {
        var result = [UIView]()
        if level == 0 && printSubviews {
            result.append(parentView)
            print("\(parentView.viewInfo)")
        }
        
        for subview in parentView.subviews {
            if printSubviews {
                print("\(String(repeating: "-", count: level))\(subview.viewInfo)")
            }
            result.append(subview)
            
            if subview.subviews.count != 0 {
                result += subviews(parentView: subview, level: level+1, printSubviews: printSubviews)
            }
        }
        return result
    }
    
    var allSubviews: [UIView] {
        return subviews(parentView: self)
    }
    
    func printSubviews() {
        _ = subviews(parentView: self, printSubviews: true)
    }
}

extension UIImage {
    static let IMAGE_USER = 0
    static let IMAGE_EMAIL = 1
    static let IMAGE_PASSWORD = 2
    
    public func getImageName(name: Int) -> String {
        var imageName: String!
        switch name {
        case 0:
            imageName = "text-field-user"
            break
        case 1:
            imageName = "text-field-email"
            break
        case 2:
            imageName = "text-field-password"
            break
        default:
            imageName = ""
        }
        return imageName
    }
}
