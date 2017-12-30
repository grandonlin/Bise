//
//  Price.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-19.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import Foundation

class Price {
    
    private var _amount: Double!
    private var _unit: String!
    
    init(amount: Double, unit: String) {
        self.amount = amount
        self.unit = unit
    }
    
    var amount: Double {
        get {
            return _amount
        }
        set {
            _amount = newValue
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
}
