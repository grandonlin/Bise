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
    private var _servicePrice: [Price]!
    private var _serviceDuration: Double!
    private var _serviceImageUrl: String!
    private var _serviceImage: UIImage!
    private var _durationUnit: String!
    private var _savedInFirebase = false
    
    init() {
        serviceName = ""
        servicePrice = [Price]()
        serviceDuration = 0
        serviceImageUrl = ""
        serviceImage = UIImage(named: "emptyImage")!
        durationUnit = "15 mins"
        savedInFirebase = false
    }
    
    init(serviceName: String, servicePrice: [Price], serviceDuration: Double, durationUnit: String, serviceImageUrl: String, serviceImage: UIImage) {
        self._serviceName = serviceName
        self._servicePrice = servicePrice
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
    
    var servicePrice: [Price] {
        get {
            return _servicePrice
        }
        set {
            _servicePrice = newValue
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
    
    var savedInFirebase: Bool {
        get {
            return _savedInFirebase
        }
        set {
            _savedInFirebase = newValue
        }
    }
    
    func updateServiceLocally(service: Service, serviceName: String, servicePrice: [Price], serviceDuration: Double, durationUnit: String, serviceImageUrl: String, serviceImage: UIImage) {
        service.serviceName = serviceName
        service.servicePrice = servicePrice
        service.serviceDuration = Double(serviceDuration)
        service.durationUnit = durationUnit
        service.serviceImageUrl = serviceImageUrl
        service.serviceImage = serviceImage
    }
}
