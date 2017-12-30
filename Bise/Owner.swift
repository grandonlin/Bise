//
//  Owner.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class Owner: User {
    
    private var _ownerID: String!
    private var _storeName: String!
    private var _address: Address!
    private var _category: String!
    private static var _ownerCount = 0
    private var _locationImage: UIImage!
    private var _hasLocationImage: Bool!
    private var _schedule: Schedule!
    private var _locationEmail: String!
    private var _services: [Service]!
    
    override init() {
        super.init()
        ownerID = ""
        storeName = ""
        address = Address()
        category = OWNER
        locationImage = UIImage(named: "emptyImage")!
        hasLocationImage = false
        schedule = Schedule()
        services = [Service]()
        
        
        
    }
    
    //Create owner data when registering to Firebase
    init(ownerName: String) {
        super.init(category: OWNER, userName: ownerName)
        self.address = Address()
        self.schedule = Schedule()
        self.storeName = ""
        self.locationEmail = ""
        self.locationImage = UIImage(named: "emptyImage")!
        self.hasLocationImage = false
        self.services = [Service]()
        User.userCount = KeychainWrapper.standard.integer(forKey: USER_COUNT)!
        User.userCount += 1
        KeychainWrapper.standard.set(User.userCount, forKey: USER_COUNT)
        if KeychainWrapper.standard.integer(forKey: OWNER_COUNT) == nil {
            KeychainWrapper.standard.set(0, forKey: OWNER_COUNT)
        }
        Owner.ownerCount = KeychainWrapper.standard.integer(forKey: OWNER_COUNT)!
        Owner.ownerCount += 1
        if Owner.ownerCount < 10 {
            self.ownerID = "0\(Owner.ownerCount)"
        } else {
            self.ownerID = "\(Owner.ownerCount)"
        }
        KeychainWrapper.standard.set(Owner.ownerCount, forKey: OWNER_COUNT)
        self.category = OWNER
    }
    
    //Create owner from downloaded data
    init(userName: String, locationEmail: String, gender: String, storeName: String, address: Address, phone: String) {
        super.init(category: OWNER, userName: userName)
        super.phone = phone
        self.storeName = storeName
        self.address = address
        self.category = category
        self.locationEmail = locationEmail
    }
    
    static var ownerCount: Int {
        get {
            return Owner._ownerCount
        }
        set {
            Owner._ownerCount = newValue
        }
    }

    var ownerID: String {
        get {
            return _ownerID
        }
        set {
            _ownerID = newValue
        }
    }
    
    var storeName: String {
        get {
            return _storeName
        }
        set {
            _storeName = newValue
        }
    }
    
    var address: Address {
        get {
            return _address
        }
        set {
            _address = newValue
        }
    }
    
    var locationEmail: String {
        get {
            return _locationEmail
        }
        set {
            _locationEmail = newValue
        }
    }
    
    var locationImage: UIImage {
        get {
            return _locationImage
        }
        set {
            _locationImage = newValue
        }
    }
    
    var hasLocationImage: Bool {
        get {
            return _hasLocationImage
        }
        set {
            _hasLocationImage = newValue
        }
    }
    
    var schedule: Schedule {
        get {
            return _schedule
        }
        set {
            _schedule = newValue
        }
    }
    
    var services: [Service] {
        get {
            return _services
        }
        set {
            _services = newValue
        }
    }
}
