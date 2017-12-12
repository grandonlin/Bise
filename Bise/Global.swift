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
let CURRENT_OWNER_ID = "current owner id"
let SHOPPER = "SHOPPER"
let SHOPPER_COUNT = "shopper count"
let CURRENT_USERNAME = "current username"
let CURRENT_EMAIL = "current email"
let CURRENT_PASSWORD = "current password"
let DEFAULT_LOCATION_IMAGE_URL = "https://firebasestorage.googleapis.com/v0/b/bise-5884a.appspot.com/o/emptyImage.png?alt=media&token=b0595586-af18-4b6c-98cf-594f4487f66c"
let HANDLE = UInt(0)
let weekArr = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
let hourArr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
let minuteArr = ["00","10","20","30","40","50"]
let amPmArr = ["AM", "PM"]
let timeArr = ["hour(s)", "minutes"]
let priceUnitArr = ["15 mins", "30 mins", "45 mins", "hour", "time"]
var services = [Service]()

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
    
    func setNoTextOnBackBarButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationItem.setLeftBarButton(backButton, animated: false)
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

extension UITextFieldDelegate {
    
}
