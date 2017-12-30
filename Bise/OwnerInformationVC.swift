//
//  OwnerInformationVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-27.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class OwnerInformationVC: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var addressLineTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provinceStateTextField: UITextField!
    @IBOutlet weak var postalZipCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    
    var address: Address!
    var email: String!
    
    override func viewWillAppear(_ animated: Bool) {
        
        DataService().OWNERS_CURRENT_REF.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let data = snap.value as? Dictionary<String, Any> {
                        if let username = data["Username"] as? String {
                            currentOwner.userName = username
                        }
                        if let locationInfo = data["Location Information"] as? Dictionary<String, Any> {
                            if let addressInfo = locationInfo["Address"] as? Dictionary<String, String> {
                                let addressLine = addressInfo["Address Line"]
                                let city = addressInfo["City"]
                                let country = addressInfo["Country"]
                                let postalZip = addressInfo["Postal Zip Code"]
                                let province = addressInfo["Province State"]
                                
                                //Fill the screen text fields
                                self.addressLineTextField.text = addressLine
                                self.cityTextField.text = city
                                self.provinceStateTextField.text = province
                                self.postalZipCodeTextField.text = postalZip
                                self.countryTextField.text = country
                                var downloadAddress: Address!
                                if let unit = addressInfo["Unit"] {
                                    self.unitTextField.text = unit
                                    downloadAddress = Address(addressLine: addressLine!, city: city!, postalZip: postalZip!, provinceState: province!, country: country!, unit: unit)
                                } else {
                                    downloadAddress = Address(addressLine: addressLine!, city: city!, postalZip: postalZip!, provinceState: province!, country: country!)
                                }
                                
                                //Get info for current owner
                                currentOwner.address = downloadAddress
                                
                                
                            }
                            if let phone = locationInfo["Phone"] as? String {
                                self.phoneTextField.text = phone
                            }
                            if let contactEmail = locationInfo["Contact Email"] as? String {
                                self.contactEmailTextField.text = contactEmail
                            }
                            if let locationImageUrl = locationInfo["Location Image URL"] as? String {
                                let imageRef = Storage.storage().reference(forURL: locationImageUrl)
                                imageRef.getData(maxSize: 1024 * 1024, completion: { (data, error) in
                                    if error != nil {
                                        print("Grandon(ProfileVC): the error is \(error)")
                                    } else {
                                        if let img = UIImage(data: data!) {
                                            currentOwner.locationImage = img
                                            currentOwner.hasLocationImage = true
                                        }
                                    }
                                })
                            }
                            if let locationName = locationInfo["Location Name"] as? String {
                                currentOwner.storeName = locationName
                                self.locationNameTextField.text = locationName
                            }
                            if let operationData = locationInfo["Operation Hours"] as? Dictionary<String, String> {
                                var ownerSchedule = currentOwner.schedule
                                for (day, schedule) in operationData {
                                    switch day {
                                    case "01Monday":
                                        if schedule != "Closed"  {
                                            let mondaySchedule = schedule.characters.split(separator: "-")
                                            let mondayFromValue = String(mondaySchedule[0])
                                            let mondayToValue = String(mondaySchedule[1])
                                            ownerSchedule.mondayFrom = mondayFromValue
                                            ownerSchedule.mondayTo = mondayToValue
                                        } else {
                                            ownerSchedule.mondayFrom = "Closed"
                                            ownerSchedule.mondayTo = ""
                                        }
                                    break
                                    case "02Tuesday":
                                        if schedule != "Closed"  {
                                            let tuesdaySchedule = schedule.characters.split(separator: "-")
                                            let tuesdayFromValue = String(tuesdaySchedule[0])
                                            let tuesdayToValue = String(tuesdaySchedule[1])
                                            ownerSchedule.tuesdayFrom = tuesdayFromValue
                                            ownerSchedule.tuesdayTo = tuesdayToValue
                                        } else {
                                            ownerSchedule.tuesdayFrom = "Closed"
                                            ownerSchedule.tuesdayTo = ""
                                        }
                                        break
                                    case "03Wednesday":
                                        if schedule != "Closed"  {
                                            let wednesdaySchedule = schedule.characters.split(separator: "-")
                                            let wednesdayFromValue = String(wednesdaySchedule[0])
                                            let wednesdayToValue = String(wednesdaySchedule[1])
                                            ownerSchedule.wednesdayFrom = wednesdayFromValue
                                            ownerSchedule.wednesdayTo = wednesdayToValue
                                        } else {
                                            ownerSchedule.wednesdayFrom = "Closed"
                                            ownerSchedule.wednesdayTo = ""
                                        }
                                        break
                                    case "04Thursday":
                                        if schedule != "Closed"  {
                                            let thursdaySchedule = schedule.characters.split(separator: "-")
                                            let thursdayFromValue = String(thursdaySchedule[0])
                                            let thursdayToValue = String(thursdaySchedule[1])
                                            ownerSchedule.thursdayFrom = thursdayFromValue
                                            ownerSchedule.thursdayTo = thursdayToValue
                                        } else {
                                            ownerSchedule.thursdayFrom = "Closed"
                                            ownerSchedule.thursdayTo = ""
                                        }
                                        break
                                    case "05Friday":
                                        if schedule != "Closed"  {
                                            let fridaySchedule = schedule.characters.split(separator: "-")
                                            let fridayFromValue = String(fridaySchedule[0])
                                            let fridayToValue = String(fridaySchedule[1])
                                            ownerSchedule.fridayFrom = fridayFromValue
                                            ownerSchedule.fridayTo = fridayToValue
                                        } else {
                                            ownerSchedule.fridayFrom = "Closed"
                                            ownerSchedule.fridayTo = ""
                                        }
                                        break
                                    case "06Saturday":
                                        if schedule != "Closed"  {
                                            let saturdaySchedule = schedule.characters.split(separator: "-")
                                            let saturdayFromValue = String(saturdaySchedule[0])
                                            let saturdayToValue = String(saturdaySchedule[1])
                                            ownerSchedule.saturdayFrom = saturdayFromValue
                                            ownerSchedule.saturdayTo = saturdayToValue
                                        } else {
                                            ownerSchedule.saturdayFrom = "Closed"
                                            ownerSchedule.saturdayTo = ""
                                        }
                                        break
                                    case "07Sunday":
                                        if schedule != "Closed"  {
                                            let sundaySchedule = schedule.characters.split(separator: "-")
                                            let sundayFromValue = String(sundaySchedule[0])
                                            let sundayToValue = String(sundaySchedule[1])
                                            ownerSchedule.sundayFrom = sundayFromValue
                                            ownerSchedule.sundayTo = sundayToValue
                                        } else {
                                            ownerSchedule.sundayFrom = "Closed"
                                            ownerSchedule.sundayTo = ""
                                        }
                                        break
                                    default:
                                        ownerSchedule = Schedule()
                                    }
                                    
                                }
                            }
                            
                            if let serviceData = locationInfo["Services"] as? Dictionary<String, Any> {
                                for (serviceName, serviceInfo) in serviceData {
                                    let service = Service()
                                    service.serviceName = serviceName
                                    if let serviceDetailData = serviceInfo as? Dictionary<String, Any> {
                                        if let imageUrl = serviceDetailData["Image Url"] as? String {
                                            service.serviceImageUrl = imageUrl
                                            let imageRef = Storage.storage().reference(forURL: imageUrl)
                                            imageRef.getData(maxSize: 1024 * 1024, completion: { (data, error) in
                                                if error != nil {
                                                    print("Grandon(ProfileVC): the error is \(error)")
                                                } else {
                                                    if let img = UIImage(data: data!) {
                                                        service.serviceImage = img
                                                    }
                                                }
                                            })

                                        }
                                        if let duration = serviceDetailData["Duration"] as? String {
                                            service.durationUnit = duration
                                        }
                                        if let priceInfo = serviceDetailData["Prices"] as? Dictionary<String, String> {
                                            for priceValue in priceInfo.values {
                                                let priceDetail = priceValue.characters.split(separator: "/")
                                                let priceAmount = Double(String(priceDetail[0]))
                                                let priceUnit = String(priceDetail[1])
                                                let price = Price(amount: priceAmount!, unit: priceUnit)
                                                service.servicePrice.append(price)
                                            }
                                        }
                                    }
                                    currentOwner.services.append(service)
                                }
                            }
                        }
                    }
                }
            }
        })
        print("Owner Information: address: \(currentOwner.address.addressLine) \(currentOwner.address.city), \(currentOwner.schedule.fridayFrom), \(currentOwner.category)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true

        initialize()
        
//        getOwnerAddress(ownerID: ownerID)
    }
    
    func initialize() {
        let address = currentOwner.address
        addressLineTextField.text = address.addressLine
        cityTextField.text = address.city
        provinceStateTextField.text = address.provinceState
        postalZipCodeTextField.text = address.postalZip
        countryTextField.text = address.country
        if address.unit != "" {
            unitTextField.text = address.unit
        }
        phoneTextField.text = currentOwner.phone
        contactEmailTextField.text = currentOwner.locationEmail
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        guard let locationName = locationNameTextField.text, locationName != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the name of your location", actionTitle: ["Cancel"])
            return
        }
        
        guard let addressLine = addressLineTextField.text, addressLine != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the address", actionTitle: ["Cancel"])
            return
        }
        
        guard let city = cityTextField.text, city != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the city", actionTitle: ["Cancel"])
            return
        }
        
        guard let provinceState = provinceStateTextField.text, provinceState != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the province or state", actionTitle: ["Cancel"])
            return
        }
        
        guard let postalZipCode = postalZipCodeTextField.text, postalZipCode != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the postal code / zip code", actionTitle: ["Cancel"])
            return
        }
        
        guard let country = countryTextField.text, country != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the country", actionTitle: ["Cancel"])
            return
        }
        
        guard let contactEmail = contactEmailTextField.text, contactEmail != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the contact email", actionTitle: ["Cancel"])
            return
        }
        
        guard let phone = phoneTextField.text, phone != "" else {
            sendAlertWithoutHandler(alertTitle: "Missing Information", alertMessage: "Please enter the phone number", actionTitle: ["Cancel"])
            return
        }
        
        let unit = unitTextField.text
        let thisAddress: Address
        
        if unit == nil || unit == "" {
            thisAddress = Address(addressLine: addressLine, city: city, postalZip: postalZipCode, provinceState: provinceState, country: country)
        } else {
            thisAddress = Address(addressLine: addressLine, city: city, postalZip: postalZipCode, provinceState: provinceState, country: country, unit: unit!)
        }
        
        currentOwner.address = thisAddress
        currentOwner.phone = phone
        currentOwner.storeName = locationName
        currentOwner.locationEmail = contactEmail
        
        let ownerInfo: [String: Any]
        
        if unit == nil || unit == "" {
            ownerInfo = ["Phone": phone, "Contact Email": contactEmail, "Location Name": locationName, "Address": ["Address Line": addressLine, "City": city, "Postal Zip Code": postalZipCode, "Province State": provinceState, "Country": country]]
        } else {
            ownerInfo = ["Phone": phone, "Contact Email": contactEmail, "Location Name": locationName, "Address": ["Address Line": addressLine, "Unit": unit, "City": city, "Postal Zip Code": postalZipCode, "Province State": provinceState, "Country": country]]
        }

        DataService().OWNERS_CURRENT_REF.child("Location Information").updateChildValues(ownerInfo)
        performSegue(withIdentifier: "LocationImageVC", sender: nil)
    }
    
//    func getOwnerAddress(ownerID: String){
////        let receivedAddress = Address()
//        DataService().OWNERS_REF.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let snapShot = snapshot.children.allObjects as? [DataSnapshot] {
//                for snap in snapShot {
//                    print("(OwnerInformationVC): the snap key is \(snap.key)")
//                    if ownerID == snap.key {
//                        let ownerInfo = snap.value as! Dictionary<String, Any>
//                        if let locationInfo = ownerInfo["Locaiton Information"] as? Dictionary<String, Any> {
//                            if let address = locationInfo["Address"] as? Dictionary<String, Any> {
//                                let addressLine = address["Address Line"] as! String
//                                let city = address["City"] as! String
//                                let postalZip = address["Postal_Zip Code"] as! String
//                                let province = address["Province_State"] as! String
//                                let country = address["Country"] as! String
//                                //                            let unitNumber: String
//                                if let unit = address["Unit"] as? String {
//                                    //                                unitNumber = unit
//                                    self.unitTextField.text = unit
//                                    //                            receivedAddress.unit = unitNumber
//                                }
//                                //                        receivedAddress.addressLine = addressLine
//                                //                        receivedAddress.city = city
//                                //                        receivedAddress.postalZip = postalZip
//                                //                        receivedAddress.provinceState = province
//                                //                        receivedAddress.country = country
//                                self.addressLineTextField.text = addressLine
//                                self.cityTextField.text = city
//                                self.provinceStateTextField.text = province
//                                self.postalZipCodeTextField.text = postalZip
//                                self.countryTextField.text = country
//                            }
//                        }
//                    }
//                }
//            }
//        })
//    }
    
//    func getOwnerLocationInfo(owner: Owner) {
//        let address = owner.address
//        addressLineTextField.text = address.addressLine
//        cityTextField.text = address.city
//        provinceStateTextField.text = address.provinceState
//        postalZipCodeTextField.text = address.postalZip
//        countryTextField.text = address.country
//        if address.unit != "" {
//            unitTextField.text = address.unit
//        }
//        phoneTextField.text = owner.phone
//        contactEmailTextField.text = owner.locationEmail
//    }
//

    
}
