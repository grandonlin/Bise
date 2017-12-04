//
//  DataService.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

var userName: String!

class DataService {
    
//    static let ds = DataService()
    var uid = KeychainWrapper.standard.string(forKey: KEY_UID)
    
    //DB references
    private var _BASE_REF = DB_BASE
    private var _OWNERS_REF = DB_BASE.child("Owners")
    private var _SHOPPERS_REF = DB_BASE.child("Shoppers")
    private var _SCHEDULE_REF = DB_BASE.child("Sechdule")
    private var _SERVICES_REF = DB_BASE.child("Services")
    
    //STORAGE references
    private var _STORE_IMAGE = STORAGE_BASE.child("Store_pic")
    private var _POST_IMAGE = STORAGE_BASE.child("post_pic")
    private var _STEP_IMAGE = STORAGE_BASE.child("step_pic")
    
    var BASE_REF: DatabaseReference {
        return _BASE_REF
    }
    
    var OWNERS_REF: DatabaseReference {
        return _OWNERS_REF
    }
    
    var OWNERS_CURRENT_REF: DatabaseReference {
        let user = DataService()._OWNERS_REF.child(uid!)
        return user
    }
    
    var SHOPPERS_REF: DatabaseReference {
        return _SHOPPERS_REF
    }
    
    var SCHEDULE_REF: DatabaseReference {
        return _SCHEDULE_REF
    }
    
    var SERVICE_REF: DatabaseReference {
        return _SERVICES_REF
    }
    
    var STORE_IMAGE: StorageReference {
        return _STORE_IMAGE
    }

    func createFirebaseDBUser(user: User, id: String, userData: Dictionary<String, Any>) {
        if user.category == OWNER {
            OWNERS_REF.child(id).updateChildValues(userData)
        } else {
            SHOPPERS_REF.child(id).updateChildValues(userData)
        }
        
        
    }
}
