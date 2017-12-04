//
//  Shopper.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-28.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import Foundation

class Shopper: User {
    
    private var _shopperID: String!
    private var _shopperName: String!
    private var _gender: String!
    private var _category: String!
    private static var _shopperCount = 0
    
    //Create owner data when registering to Firebase
    init(shopperName: String, email: String) {
        super.init(category: SHOPPER, userName: shopperName, email: email)
//        super.userCount += 1
        Shopper._shopperCount += 1
        if Shopper._shopperCount < 10 {
            self._shopperID = "0\(Shopper._shopperCount)"
        } else {
            self._shopperID = "\(Shopper._shopperCount)"
        }
        self._category = SHOPPER
        self.shopperName = shopperName
        
    }
    
    var shopperCount: Int {
        get {
            return Shopper._shopperCount
        }
        set {
            Shopper._shopperCount = newValue
        }
    }
    
    var shopperID: String {
        get {
            return _shopperID
        }
        set {
            _shopperID = newValue
        }
    }
    
    var shopperName: String {
        get {
            return _shopperName
        }
        set {
            _shopperName = newValue
        }
    }

    var gender: String {
        get {
            return _gender
        }
        set {
            _gender = newValue
        }
    }
}
