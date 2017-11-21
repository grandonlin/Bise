//
//  Global.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-21.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

extension UIView {
    func widthCircleView() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
    func heightCircleView() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
