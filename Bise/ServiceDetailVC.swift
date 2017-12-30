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

class ServiceDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var timePickerView: UIPickerView!

    var imagePicker: UIImagePickerController!
    var serviceNumber: Int!
    var initServiceUnit: String!
    var initPrice: Price!
    var selectedRow: Int!
    var service: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Bise(ServiceDetailVC): the services now has \(currentOwner.services.count) records")
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        durationTextField.delegate = self
        
        priceTableView.delegate = self
        priceTableView.dataSource = self
        
        initialize()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    func initialize() {
        let allTextFields = [serviceNameTextField, durationTextField]
        for i in 0..<allTextFields.count {
            allTextFields[i]?.heightCircleView()
        }
        
        initServiceUnit = timeArr[0]
        
        
//        if getService().servicePrice.count == 0 {
//            initPrice = Price(amount: 0.0, unit: "15 mins")
//            getService().servicePrice.append(initPrice)
//        }
        
        if getService().serviceName != "" {
            serviceNameTextField.text = getService().serviceName
            
            let durationUnit = getService().durationUnit
            let durationRowIndex = getUnitIndex(compareUnit: durationUnit, unitsArray: timeArr)
            timePickerView.selectRow(durationRowIndex, inComponent: 0, animated: true)
            
            if getService().serviceDuration == 0 {
                durationTextField.text = ""
            } else {
                durationTextField.text = "\(getService().serviceDuration)"
            }
            
            serviceImageView.image = getService().serviceImage

        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
 
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
        if textField == serviceNameTextField {
            if let value = serviceNameTextField.text {
                if value != "" {
                    getService().serviceName = value
                }
            }
        }
    }
    
    //PickerView delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initServiceUnit = timeArr[row]
    }
    
    //Table view delegate and datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getService().servicePrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let price = getService().servicePrice[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell") as? PriceCell {
            cell.configureCell(price: price)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "PriceDetailVC", sender: Any.self)
    }
    
    func getService() -> Service {
        return currentOwner.services[serviceNumber]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PriceDetailVC {
            destination.serviceNumber = serviceNumber
            destination.priceNumber = selectedRow
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
    
    @IBAction func plusBtnPressed(_ sender: UIButton) {
        let newPrice = Price(amount: 0, unit: "15 mins")
        getService().servicePrice.append(newPrice)
    }
    
    @IBAction func minusBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        guard let serviceName = serviceNameTextField.text, serviceName != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Service Name", alertMessage: "Please enter service name", actionTitle: ["Cancel"])
            return
        }
        
        guard let duration = durationTextField.text, duration != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Service Duration", alertMessage: "Please give an estimated duration for this service.", actionTitle: ["Cancel"])
            return
        }

        if let serviceImage = serviceImageView.image {
            if let imgData = UIImageJPEGRepresentation(serviceImage, 1) {
                let imageID = serviceName
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                DataService().STORE_IMAGE.child(ownerID!).child("Service Photos").child(imageID).putData(imgData, metadata: metadata) { (data, error) in
                    if error != nil {
                        self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: "\(error?.localizedDescription)!", actionTitle: ["Cancel"])
                    } else {
                        let imgUrl = data?.downloadURL()?.absoluteString
                        
                        var priceRecord = [String: String]()
                        let priceCount = self.getService().servicePrice.count
                        print("ServiceDetailVC): the price array currently has \(priceCount) records")
                        for i in 0..<priceCount {
                            let price = "\(self.getService().servicePrice[i].amount)/\(self.getService().servicePrice[i].unit)"
                            priceRecord.updateValue(price, forKey: "Price\(i+1)")
                            
                        }
                        let serviceInformation = ["\(serviceName)": ["Prices": priceRecord, "Duration": "\(duration) \(self.initServiceUnit!)", "Image Url": imgUrl!]] as [String: Any]
                        
                        self.getService().updateServiceLocally(service: self.getService(), serviceName: serviceName, servicePrice: self.getService().servicePrice, serviceDuration: Double(duration)!, durationUnit: self.initServiceUnit, serviceImageUrl: imgUrl!, serviceImage: serviceImage)
                        DataService().OWNERS_CURRENT_REF.child("Location Information").child("Services").updateChildValues(serviceInformation)
                        self.getService().savedInFirebase = true
                        self.sendAlertWithoutHandler(alertTitle: "Save completed", alertMessage: "", actionTitle: ["OK"])
                    }
                }
                
            }
        }
    }
}
