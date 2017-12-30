//
//  Schedule.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-15.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import Foundation

class Schedule {
    
    private var _mondayFrom: String!
    private var _mondayTo: String!
    private var _tuesdayFrom: String!
    private var _tuesdayTo: String!
    private var _wednesdayFrom: String!
    private var _wednesdayTo: String!
    private var _thursdayFrom: String!
    private var _thursdayTo: String!
    private var _fridayFrom: String!
    private var _fridayTo: String!
    private var _saturdayFrom: String!
    private var _saturdayTo: String!
    private var _sundayFrom: String!
    private var _sundayTo: String!
    private var _isUploaded: Bool!

    //Empty schedule
    init() {
        mondayFrom = ""
        mondayTo = ""
        tuesdayFrom = ""
        tuesdayTo = ""
        wednesdayFrom = ""
        wednesdayTo = ""
        thursdayFrom = ""
        thursdayTo = ""
        fridayFrom = ""
        fridayTo = ""
        saturdayFrom = ""
        saturdayTo = ""
        sundayFrom = ""
        sundayTo = ""
        isUploaded = false
    }
    
    //To upload to Firebase
    init(mdF: String, mdT: String, tuF: String, tuT: String, wdF: String, wdT: String, trF: String, trT: String, frF: String, frT: String, saF: String, saT: String, suF: String, suT: String) {
        mondayFrom = mdF
        mondayTo = mdT
        tuesdayFrom = tuF
        tuesdayTo = tuT
        wednesdayFrom = wdF
        wednesdayTo = wdT
        thursdayFrom = trF
        thursdayTo = trT
        fridayFrom = frF
        fridayTo = frT
        saturdayFrom = saF
        saturdayTo = saT
        sundayFrom = suF
        sundayTo = suT
        isUploaded = false
    }
    
    var mondayFrom: String {
        get {
            return _mondayFrom
        }
        set {
            _mondayFrom = newValue
        }
    }
    
    var mondayTo: String {
        get {
            return _mondayTo
        }
        set {
            _mondayTo = newValue
        }
    }
    
    var tuesdayFrom: String {
        get {
            return _tuesdayFrom
        }
        set {
            _tuesdayFrom = newValue
        }
    }
    
    var tuesdayTo: String {
        get {
            return _tuesdayTo
        }
        set {
            _tuesdayTo = newValue
        }
    }
    
    var wednesdayFrom: String {
        get {
            return _wednesdayFrom
        }
        set {
            _wednesdayFrom = newValue
        }
    }
    
    var wednesdayTo: String {
        get {
            return _wednesdayTo
        }
        set {
            _wednesdayTo = newValue
        }
    }
    
    var thursdayFrom: String {
        get {
            return _thursdayFrom
        }
        set {
            _thursdayFrom = newValue
        }
    }
    
    var thursdayTo: String {
        get {
            return _thursdayTo
        }
        set {
            _thursdayTo = newValue
        }
    }
    
    var fridayFrom: String {
        get {
            return _fridayFrom
        }
        set {
            _fridayFrom = newValue
        }
    }
    
    var fridayTo: String {
        get {
            return _fridayTo
        }
        set {
            _fridayTo = newValue
        }
    }
    
    var saturdayFrom: String {
        get {
            return _saturdayFrom
        }
        set {
            _saturdayFrom = newValue
        }
    }
    
    var saturdayTo: String {
        get {
            return _saturdayTo
        }
        set {
            _saturdayTo = newValue
        }
    }
    
    var sundayFrom: String {
        get {
            return _sundayFrom
        }
        set {
            _sundayFrom = newValue
        }
    }
    
    var sundayTo: String {
        get {
            return _sundayTo
        }
        set {
            _sundayTo = newValue
        }
    }
    
    var isUploaded: Bool {
        get {
            return _isUploaded
        }
        set {
            _isUploaded = newValue
        }
    }
}
