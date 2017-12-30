//
//  PriceDetailVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-18.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class PriceDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var priceUnitPickerView: UIPickerView!
    @IBOutlet weak var priceTextField: UITextField!
    
    var initPriceUnit: String!
    var serviceNumber: Int!
    var priceNumber: Int!
    var service: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        priceUnitPickerView.delegate = self
        priceUnitPickerView.dataSource = self
        priceTextField.delegate = self

        initPriceUnit = priceUnitArr[0]
        initialize()
    }
    
    func initialize() {
        service = currentOwner.services[serviceNumber]
        let priceDisplayed = service.servicePrice[priceNumber]
        priceTextField.text = "\(priceDisplayed.amount)"
        let unit = priceDisplayed.unit
        let priceRowIndex = getUnitIndex(compareUnit: unit, unitsArray: priceUnitArr)
        priceUnitPickerView.selectRow(priceRowIndex, inComponent: 0, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        var priceValue: String!
        if let value = priceTextField.text {
            if value != "" {
                let lastIndex = value.index(before: value.endIndex)
                if value[lastIndex] == "." {
                    priceValue = value.substring(to: lastIndex)
                    priceTextField.text = priceValue
                    
                }
                if let priceEntered = Double(priceValue) {
                    print("PriceDetailVC): the price is \(priceEntered)/\(initPriceUnit)")
                    let priceToBeUpdated = Price(amount: priceEntered, unit: initPriceUnit)
                    service.servicePrice[priceNumber] = priceToBeUpdated
                    service.servicePrice[priceNumber] = priceToBeUpdated
                    sendAlertWithoutHandler(alertTitle: "Saving Price", alertMessage: "Price has been saved", actionTitle: ["OK"])
                }
            }
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceUnitArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceUnitArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initPriceUnit = priceUnitArr[row]
    }  
}
