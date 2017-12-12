//
//  ServiceDetailVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-09.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class ServiceDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var unitPickerView: UIPickerView!

    var imagePicker: UIImagePickerController!
    var serviceNumber: Int!
    var initPriceUnit: String!
    var initServiceUnit: String!
    var ownerID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Bise(ServiceDetailVC): the services now has \(services.count) records")
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        unitPickerView.delegate = self
        unitPickerView.dataSource = self
        
        priceTextField.delegate = self
        durationTextField.delegate = self
        
        initialize()
        
        
    }

    func initialize() {
        let allTextFields = [serviceNameTextField, priceTextField, durationTextField]
        for i in 0..<allTextFields.count {
            allTextFields[i]?.heightCircleView()
        }
        ownerID = KeychainWrapper.standard.string(forKey: CURRENT_OWNER_ID)
        
        initPriceUnit = priceUnitArr[0]
        initServiceUnit = timeArr[0]
        let service = services[serviceNumber]
        serviceNameTextField.text = service.serviceName
        if service.servicePrice == 0 {
            priceTextField.text = ""
        } else {
            priceTextField.text = "\(service.servicePrice)"
        }
        
        let priceUnit = service.priceUnit
        let priceRowIndex = getUnitIndex(compareUnit: priceUnit, unitsArray: priceUnitArr)
        unitPickerView.selectRow(priceRowIndex, inComponent: 0, animated: true)
        
        let durationUnit = service.durationUnit
        let durationRowIndex = getUnitIndex(compareUnit: durationUnit, unitsArray: timeArr)
        timePickerView.selectRow(durationRowIndex, inComponent: 0, animated: true)
        
        if service.serviceDuration == 0 {
            durationTextField.text = ""
        } else {
            durationTextField.text = "\(service.serviceDuration)"
        }
        
        
        serviceImageView.image = service.serviceImage
    }
    
    func getUnitIndex(compareUnit: String, unitsArray: [String]) -> Int {
        var index: Int!
        for i in 0...unitsArray.count {
            if compareUnit == unitsArray[i] {
                index = i
            }
        }
        return index
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == priceTextField {
            if let value = priceTextField.text {
                if value != "" {
                    let lastIndex = value.index(before: value.endIndex)
                    if value[lastIndex] == "." {
                        let priceValue = value.substring(to: lastIndex)
                        priceTextField.text = priceValue
                    }
                }
            }
        }
        if textField == durationTextField {
            if let value = durationTextField.text {
                if value != "" {
                    let lastIndex = value.index(before: value.endIndex)
                    if value[lastIndex] == "." {
                        let durationValue = value.substring(to: lastIndex)
                        durationTextField.text = durationValue
                    }
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timePickerView {
            return timeArr.count
        } else {
            return priceUnitArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timePickerView {
            return timeArr[row]
        } else {
            return priceUnitArr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == timePickerView {
            initServiceUnit = timeArr[row]
        }
        if pickerView == unitPickerView {
            initPriceUnit = priceUnitArr[row]
        }
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            serviceImageView.image = selectedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        guard let serviceName = serviceNameTextField.text, serviceName != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Service Name", alertMessage: "Please enter service name", actionTitle: ["Cancel"])
            return
        }
        
        guard let price = priceTextField.text, price != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Price", alertMessage: "Please enter the price for this service.", actionTitle: ["Cancel"])
            return
        }
        
        guard let duration = durationTextField.text, price != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Service Duration", alertMessage: "Please give an estimated duration for this service.", actionTitle: ["Cancel"])
            return
        }

        if let serviceImage = serviceImageView.image {
            if let imgData = UIImageJPEGRepresentation(serviceImage, 1) {
                let imageID = serviceName
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                DataService().STORE_IMAGE.child("Service Photos").child("\(self.ownerID!)").child(imageID).putData(imgData, metadata: metadata) { (data, error) in
                    if error != nil {
                        self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: "\(error?.localizedDescription)", actionTitle: ["Cancel"])
                    } else {
                        let imgUrl = data?.downloadURL()?.absoluteString
                        if self.durationTextField.text == "1" {
                            self.initServiceUnit = "hour"
                        }
                        let serviceInformation = ["\(serviceName)": ["price": "$\(price)/\(self.initPriceUnit!)", "duration": "\(duration) \(self.initServiceUnit!)", "Image Url": imgUrl]] as [String: Any]
                        let service = services[self.serviceNumber]
                        service.serviceName = serviceName
                        service.servicePrice = Double(price)!
                        service.serviceDuration = Double(duration)!
                        service.serviceImageUrl = imgUrl!
                        service.serviceImage = serviceImage
                        DataService().OWNERS_CURRENT_REF.child("Store Information").child("services").updateChildValues(serviceInformation)

                    }
                }
                
            }
        }
        
        
        sendAlertWithoutHandler(alertTitle: "Save completed", alertMessage: "", actionTitle: ["OK"])
    }
    
    
}
