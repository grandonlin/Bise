//
//  Owner.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class Owner: User {
    
    private var _ownerID: String!
    private var _storeName: String!
    private var _address: String!
    private var _category: String!
    private static var _ownerCount = 0
    
    //Create owner data when registering to Firebase
    init(ownerName: String, email: String) {
        super.init(category: OWNER, userName: ownerName, email: email)
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
    
    //Create owner data for uploading to Firebase
//    init(category: String, userName: String, gender: String, storeName: String, address: String, phone: String) {
//        super.init(category: category, userName: userName, gender: gender)
//        super.userCount += 1
//        self._storeName = storeName
//        self._address = address
//        self._phone = phone
//        Owner._ownerCount += 1
//        if Owner._ownerCount < 10 {
//            self._ownerID = "0\(Owner._ownerCount)"
//        } else {
//            self._ownerID = "\(Owner._ownerCount)"
//        }
//        self._category = category
//    }
    
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
    
    var address: String {
        get {
            return _address
        }
        set {
            _address = newValue
        }
    }
}
