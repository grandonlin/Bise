//
//  Address.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-13.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class Address {
    
    private var _addressLine: String!
    private var _city: String!
    private var _postalZip: String!
    private var _provinceState: String!
    private var _country: String!
    private var _unit: String!
    
    init() {
        self.addressLine = ""
        self.city = ""
        self.postalZip = ""
        self.provinceState = ""
        self.country = ""
        self.unit = ""
    }
    
    //With unit
    init(addressLine: String, city: String, postalZip: String, provinceState: String, country: String, unit: String) {
        self.addressLine = addressLine
        self.city = city
        self.unit = unit
        self.postalZip = postalZip
        self.provinceState = provinceState
        self.country = country
        
    }
    
    //Without unit
    init(addressLine: String, city: String, postalZip: String, provinceState: String, country: String) {
        self.addressLine = addressLine
        self.city = city
        self.postalZip = postalZip
        self.provinceState = provinceState
        self.country = country
        
    }
    
    var addressLine: String {
        get {
            return _addressLine
        }
        set {
            _addressLine = newValue
        }
    }
    
    var unit: String {
        get {
            return _unit
        }
        set {
            _unit = newValue
        }
    }
    
    var city: String {
        get {
            return _city
        }
        set {
            _city = newValue
        }
    }
    
    var provinceState: String {
        get {
            return _provinceState
        }
        set {
            _provinceState = newValue
        }
    }
    
    var postalZip: String {
        get {
            return _postalZip
        }
        set {
            _postalZip = newValue
        }
    }
    
    var country: String {
        get {
            return _country
        }
        set {
            _country = newValue
        }
    }
}
