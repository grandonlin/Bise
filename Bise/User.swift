//
//  User.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class User {
    
    private var _userName: String!
    private var _email: String!
    private var _category: String!
    private var _phone: String!
    private static var _userCount = 0

    init(category: String, userName: String, email: String) {
        _category = category
        _userName = userName
        _email = email
        if KeychainWrapper.standard.integer(forKey: USER_COUNT) == nil {
            KeychainWrapper.standard.set(0, forKey: USER_COUNT)
        }
        User.userCount = KeychainWrapper.standard.integer(forKey: USER_COUNT)!
        User.userCount += 1
        KeychainWrapper.standard.set(User._userCount, forKey: USER_COUNT)
    }
    
    var category: String {
        get {
            return _category
        }
        set {
            _category = newValue
        }
    }

    var userName: String {
        get {
            return _userName
        }
        set {
            _userName = newValue
        }
    }
    
    var phone: String {
        get {
            return _phone
        }
        set {
            _phone = newValue
        }
    }
    
    static var userCount: Int {
        get {
            return User._userCount
        }
        set {
            User._userCount = newValue
        }
    }
}
