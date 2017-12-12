//
//  Service.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-08.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class Service {
    
    private var _serviceName: String!
    private var _servicePrice: Double!
    private var _serviceDuration: Double!
    private var _serviceImageUrl: String!
    private var _serviceImage: UIImage!
    private var _priceUnit: String!
    private var _durationUnit: String!
    
    init(serviceName: String, servicePrice: Double, priceUnit: String, serviceDuration: Double, durationUnit: String, serviceImageUrl: String, serviceImage: UIImage) {
        self._serviceName = serviceName
        self._servicePrice = servicePrice
        self._priceUnit = priceUnit
        self._serviceDuration = serviceDuration
        self._serviceImageUrl = serviceImageUrl
        self._serviceImage = serviceImage
    }
    
    var serviceName: String {
        get {
            return _serviceName
        }
        set {
            _serviceName = newValue
        }
    }
    
    var servicePrice: Double {
        get {
            return _servicePrice
        }
        set {
            _servicePrice = newValue
        }
    }
    
    var priceUnit: String {
        get {
            return _priceUnit
        }
        set {
            _priceUnit = newValue
        }
    }
    
    var serviceDuration: Double {
        get {
            return _serviceDuration
        }
        set {
            _serviceDuration = newValue
        }
    }
    
    var durationUnit: String {
        get {
            return _durationUnit
        }
        set {
            _durationUnit = newValue
        }
    }
    
    var serviceImageUrl: String {
        get {
            return _serviceImageUrl
        }
        set {
            _serviceImageUrl = newValue
        }
    }
    
    var serviceImage: UIImage {
        get {
            return _serviceImage
        }
        set {
            _serviceImage = newValue
        }
    }
}
